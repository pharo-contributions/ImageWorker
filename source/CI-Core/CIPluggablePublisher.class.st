"
I am a pluggable publisher that delegates all the publishing actions to blocks.
This is mainly useful for testing.
"
Class {
	#name : #CIPluggablePublisher,
	#superclass : #CIAbstractPublisher,
	#instVars : [
		'beforeValidationBlock',
		'changeNotFoundBlock',
		'validationResultBlock',
		'intermediateResultBlock'
	],
	#category : #'CI-Core-Publishing'
}

{ #category : #'instance creation' }
CIPluggablePublisher class >> block: aBlock [
	" create an instance using the same block for all actions."
	^ self new
		resetAllBlocks: aBlock;
		yourself
]

{ #category : #accessing }
CIPluggablePublisher >> beforeValidationBlock [
	^ beforeValidationBlock
]

{ #category : #accessing }
CIPluggablePublisher >> beforeValidationBlock: anObject [
	beforeValidationBlock := anObject
]

{ #category : #accessing }
CIPluggablePublisher >> changeNotFoundBlock [
	^ changeNotFoundBlock
]

{ #category : #accessing }
CIPluggablePublisher >> changeNotFoundBlock: anObject [
	changeNotFoundBlock := anObject
]

{ #category : #accessing }
CIPluggablePublisher >> intermediateResultBlock [
	^ intermediateResultBlock
]

{ #category : #accessing }
CIPluggablePublisher >> intermediateResultBlock: anObject [
	intermediateResultBlock := anObject
]

{ #category : #publishing }
CIPluggablePublisher >> publishBeforeValidation: aCIChange [
	self beforeValidationBlock ifNotNil: [ 
		self beforeValidationBlock cull: aCIChange ]
]

{ #category : #publishing }
CIPluggablePublisher >> publishChangeNotFound: aCIChange [
	self changeNotFoundBlock ifNotNil: [ 
		self changeNotFoundBlock cull: aCIChange ]
]

{ #category : #publishing }
CIPluggablePublisher >> publishIntermediateResult: aCIValidationResult [
	self intermediateResultBlock ifNotNil: [ 
		self intermediateResultBlock cull: aCIValidationResult ]
]

{ #category : #publishing }
CIPluggablePublisher >> publishValidationResult: aCIValidationResult [
	self validationResultBlock ifNotNil: [ 
		self validationResultBlock cull: aCIValidationResult ]
]

{ #category : #accessing }
CIPluggablePublisher >> resetAllBlocks: aBlock [
	"set all blocks to the given one"
	self
		beforeValidationBlock: aBlock;
		changeNotFoundBlock: aBlock;
		intermediateResultBlock: aBlock;
		validationResultBlock: aBlock
]

{ #category : #accessing }
CIPluggablePublisher >> validationResultBlock [
	^ validationResultBlock
]

{ #category : #accessing }
CIPluggablePublisher >> validationResultBlock: anObject [
	validationResultBlock := anObject
]
