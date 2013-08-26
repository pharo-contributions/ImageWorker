"
I collect results from different CIValidators
"
Class {
	#name : #CIValidationResult,
	#superclass : #Object,
	#instVars : [
		'warnings',
		'messages',
		'change',
		'errors'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #'instance creation' }
CIValidationResult class >> change: aCase [
	^ self new 
		change: aCase;
		yourself
]

{ #category : #'instance creation' }
CIValidationResult class >> failure: aMessage [
	^ self new
		addError: aMessage;
		yourself
]

{ #category : #'instance creation' }
CIValidationResult class >> message: aMessage [
	^ self new
		addMessage: aMessage;
		yourself
]

{ #category : #'instance creation' }
CIValidationResult class >> warning: aMessage [
	^ self new
		addWarning: aMessage;
		yourself
]

{ #category : #concatenation }
CIValidationResult >> , aCIValidationResult [ 
	errors addAll: aCIValidationResult errors.
	warnings addAll: aCIValidationResult warnings.
	messages addAll: aCIValidationResult messages.
]

{ #category : #accessing }
CIValidationResult >> addAllErrors: aCollection [
	self errors addAll: aCollection
]

{ #category : #accessing }
CIValidationResult >> addAllMessages: aCollection [ 
	self messages addAll: aCollection
]

{ #category : #accessing }
CIValidationResult >> addAllWarnings: aCollection [ 
	self warnings addAll: aCollection
]

{ #category : #accessing }
CIValidationResult >> addError: aMessage [
	errors add: aMessage
]

{ #category : #accessing }
CIValidationResult >> addMessage: aMessage [
	messages add: aMessage
]

{ #category : #accessing }
CIValidationResult >> addWarning: aMessage [
	warnings add: aMessage
]

{ #category : #accessing }
CIValidationResult >> change [
	^ change
]

{ #category : #accessing }
CIValidationResult >> change: anObject [
	change := anObject
]

{ #category : #printing }
CIValidationResult >> errorString [
	^ String streamContents: [ :str |
		self printErrorsOn: str ]
]

{ #category : #accessing }
CIValidationResult >> errors [
	^ errors
]

{ #category : #accessing }
CIValidationResult >> errors: aCollection [
	errors := aCollection.
]

{ #category : #testing }
CIValidationResult >> hasErrors [
	^ self errors isEmpty not.
]

{ #category : #testing }
CIValidationResult >> hasMessages [
	^ self messages isEmpty not.
]

{ #category : #testing }
CIValidationResult >> hasWarnings [
	^ self warnings isEmpty not.
]

{ #category : #printing }
CIValidationResult >> htmlString [
	| string |
	string := self printString.
	^ string copyReplaceAll: String cr with: '<br/>'.
	
]

{ #category : #printing }
CIValidationResult >> htmlStringOn: aStream [
	^ self printOn: aStream
]

{ #category : #initialize }
CIValidationResult >> initialize [
	super initialize.

	errors := OrderedCollection new.
	messages := OrderedCollection new.
	warnings := OrderedCollection new.
]

{ #category : #testing }
CIValidationResult >> isFailure [ 
	^ self isSuccess not
]

{ #category : #testing }
CIValidationResult >> isSuccess [
	^ self errors isNil or: [ self errors isEmpty ]
]

{ #category : #accessing }
CIValidationResult >> messages [
	^ messages
]

{ #category : #accessing }
CIValidationResult >> messages: aCollection [
	messages := aCollection.
]

{ #category : #copying }
CIValidationResult >> postCopy [
	super postCopy.
	errors := errors copy.
	warnings := warnings copy.
	messages := messages copy.
]

{ #category : #printing }
CIValidationResult >> printErrorsOn: aStream [
	self printList: self errors named: 'Failures' on: aStream.
]

{ #category : #printing }
CIValidationResult >> printList: aList named: name on: aStream [
	aList ifEmpty: [ ^ self ].
	
	aStream 
		nextPutAll: name; cr;
		nextPutAll: ('' padLeftTo: name size with: $-); cr.
	aList
		do: [ :item | item printOn: aStream ]
		separatedBy: [ aStream cr ]
]

{ #category : #printing }
CIValidationResult >> printMessagesOn: aStream [
	self printList: self messages named: 'Messages' on: aStream.
]

{ #category : #printing }
CIValidationResult >> printOn: aStream [
	self 
		printErrorsOn: aStream;
		printWarningsOn: aStream;
		printMessagesOn: aStream
]

{ #category : #printing }
CIValidationResult >> printWarningsOn: aStream [
	self printList: self warnings named: 'Warnings' on: aStream.
]

{ #category : #accessing }
CIValidationResult >> warnings [
	^ warnings
]

{ #category : #accessing }
CIValidationResult >> warnings: aCollection [
	warnings := aCollection.
]
