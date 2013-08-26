Class {
	#name : #CIHTMLPublisherTest,
	#superclass : #CIPublisherTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIHTMLPublisherTest >> defaultContent [

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>TestEntity -- Test report</title>
</head>
<body><h1>TestEntity test succeed ! </h1>
</body>
</html>
'
]

{ #category : #accessing }
CIHTMLPublisherTest >> publisherClass [
	^ CIHTMLPublisher 
]

{ #category : #tests }
CIHTMLPublisherTest >> testContents [
	| file path directory |
	
	directory := FileSystem memory.
	file := (self publisherClass new) 
		outputDirectory: directory;
		publishValidationResult: (CIValidationResult change: (CITestChange new name: 'TestEntity')).
	path := file outputDirectory / 'TestEntity', 'html'.
	
	self assert: (directory exists: path ) description: 'Testing the creation of html file'.
	self assert: path readStream contents asString equals: self defaultContent.
]

{ #category : #tests }
CIHTMLPublisherTest >> testEntity [
	| file directory path |
	
	directory := FileSystem memory.
	file := (self publisherClass new) 
		outputDirectory: directory;
		publishValidationResult: (CIValidationResult change: (CITestChange new name: 'TestEntity')).
	path := file outputDirectory / 'TestEntity', 'html'.
	
	self assert: (directory exists: path ) description: 'Testing the creation of html file'.
]
