"
A CIXMLPublisher publish report as a xml file

Try : 


result := CIValidationResult failure: 'Testing !'.
CIXMLPublisher  publish: result.
"
Class {
	#name : #CIXMLPublisher,
	#superclass : #CIFilePublisher,
	#instVars : [
		'xmlWriter'
	],
	#category : #'CI-Core-Publishing'
}

{ #category : #'as yet unclassified' }
CIXMLPublisher >> initialize [ 
	super initialize.
	self xmlWriter: XMLWriter new.
]

{ #category : #publishing }
CIXMLPublisher >> publishFailures: aCIValidationResult [
	self xmlWriter
		writeWith: [ :writer | 
			writer tag: 'finality' with: 'succeed'.
			writer tag: 'failure' with: [ aCIValidationResult errors do: [ :aMessage | writer tag: 'result' with: aMessage ] ] ]
]

{ #category : #publishing }
CIXMLPublisher >> publishMessages: aCIValidationResult [
	self xmlWriter
		writeWith: [ :writer | writer tag: 'message' with: [ aCIValidationResult messages do: [ :aMessage | writer tag: 'result' with: aMessage ] ] ]
]

{ #category : #publishing }
CIXMLPublisher >> publishSuccess: aCIValidationResult [

	^self xmlWriter writeWith: [ :writer | writer tag: 'finality' with: 'succeed'].
]

{ #category : #'file creation' }
CIXMLPublisher >> publishValidationResult: aCIValidationResult [
	| file |
	
	self updateFileName: aCIValidationResult.
	
	file := self outputDirectory / self fileName, 'xml'.
	file ensureDelete.
	self stream: file writeStream.
	self xmlWriter stream: self stream.
	self xmlBeginning: aCIValidationResult.
	self xmlWriter
		writeWith: [ :writer | 
			writer
				tag: 'report'
				with: [ 
					writer tag: 'name' with: aCIValidationResult change name, ' - report'.
					aCIValidationResult isSuccess
						ifTrue: [ self publishSuccess: aCIValidationResult ]
						ifFalse: [ self publishFailures: aCIValidationResult ].
					(aCIValidationResult warnings isNil or: aCIValidationResult warnings isEmpty)
						ifFalse: [ self publishWarnings: aCIValidationResult ].
					(aCIValidationResult messages isNil or: [ aCIValidationResult messages isEmpty ])
						ifFalse: [ self publishMessages: aCIValidationResult ] ] ].
	self xmlWriter close
]

{ #category : #publishing }
CIXMLPublisher >> publishWarnings: aCIValidationResult [ 
	
	self xmlWriter writeWith: [ :writer |
		writer tag: 'warnings' with: [
			aCIValidationResult warnings do: [ :aMessage |
				writer tag: 'result' with:  aMessage ]]].
	
]

{ #category : #publishing }
CIXMLPublisher >> xmlBeginning: aCIValidationResult [
	self xmlWriter writeWith: [  :writer |
		writer 
			enablePrettyPrinting ;
			xml;
			comment: 'Pharo CI report']

]

{ #category : #accessing }
CIXMLPublisher >> xmlWriter [
	^ xmlWriter
]

{ #category : #accessing }
CIXMLPublisher >> xmlWriter: anObject [
	xmlWriter := anObject
]
