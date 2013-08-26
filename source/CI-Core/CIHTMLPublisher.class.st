"
A CIHTMLPublisher publish report as a html file

Try : 


result := CIValidationResult failure: 'Testing !'.
CIHTMLPublisher  publish: result.
"
Class {
	#name : #CIHTMLPublisher,
	#superclass : #CIFilePublisher,
	#category : #'CI-Core-Publishing'
}

{ #category : #publishing }
CIHTMLPublisher >> htmlBeginning: aCIValidationResult [
	self stream nextPutAll:  '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>', aCIValidationResult change name asString, ' -- Test report</title>
</head>
<body>'

]

{ #category : #publishing }
CIHTMLPublisher >> htmlEnding: aCIValidationResult [
	self stream nextPutAll: '
</body>
</html>
'
]

{ #category : #publishing }
CIHTMLPublisher >> publishFailures: aCIValidationResult [
	| aString |
	aString := '<h1>', aCIValidationResult change name asString, ' failures : </h1><ul>'.
	aCIValidationResult errors do: [ :aFailure |
		aString := aString, '<li>', aFailure asString, '</li>'. ].
	self stream nextPutAll:  aString, '</ul>'.
	
]

{ #category : #publishing }
CIHTMLPublisher >> publishMessages: aCIValidationResult [ 
	| aString |
	aString := '<h1>', aCIValidationResult change name asString, ' messages : </h1><ul>'.
	aCIValidationResult messages do: [ :aMessage |
		aString := aString, '<li>', aMessage asString, '</li>'. ].
	self stream nextPutAll: aString, '</ul>'.
	
]

{ #category : #publishing }
CIHTMLPublisher >> publishSuccess: aCIValidationResult [

	self stream nextPutAll: '<h1>', aCIValidationResult change name asString, ' test succeed ! </h1>'.
]

{ #category : #'file creation' }
CIHTMLPublisher >> publishValidationResult: aCIValidationResult [

	self updateFileName: aCIValidationResult.
	
	self stream: (self outputDirectory / self fileName, 'html') writeStream.
	self htmlBeginning: aCIValidationResult.
	
	(aCIValidationResult isSuccess )
			ifTrue: [self publishSuccess: aCIValidationResult]
			ifFalse: [ self publishFailures: aCIValidationResult].
	
	(aCIValidationResult warnings isNil or: aCIValidationResult warnings isEmpty ) 
		ifFalse: [self publishWarnings: aCIValidationResult]	.
	(aCIValidationResult messages isNil or: [ aCIValidationResult messages isEmpty ])
		ifFalse: [ self publishMessages: aCIValidationResult ].
		
	self htmlEnding: aCIValidationResult.
	self stream close.
]

{ #category : #publishing }
CIHTMLPublisher >> publishWarnings: aCIValidationResult [ 
	| aString |
	aString := '<h1>', aCIValidationResult change name asString, ' warnings : </h1><ul>'.
	aCIValidationResult warnings do: [ :aWarning |
		aString := aString, '<li>', aWarning asString, '</li>'. ].
	self stream nextPutAll:  aString, '</ul>'.
	
]
