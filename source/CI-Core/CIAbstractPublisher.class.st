"
I am an abstract result / change publisher for the CI system.
I will be informed
- before the validator checks a change
- after the validation was performed

It define the default API.
The entry point is publishValidationResult: 

"
Class {
	#name : #CIAbstractPublisher,
	#superclass : #Object,
	#instVars : [
		'manager'
	],
	#category : #'CI-Core-Publishing'
}

{ #category : #concatenation }
CIAbstractPublisher class >> , anotherPublisher [
	^ self asCIPublisher , anotherPublisher
]

{ #category : #'instance creation' }
CIAbstractPublisher class >> asCIPublisher [
	^ self new
]

{ #category : #'instance creation' }
CIAbstractPublisher class >> manager: aCIPharoManager [
	^ self new 
		manager:  aCIPharoManager;
		yourself.
]

{ #category : #publishing }
CIAbstractPublisher class >> publish: aCIValidationResult [
	^ self new
		publishValidationResult: aCIValidationResult;
		yourself
]

{ #category : #concatenation }
CIAbstractPublisher >> , anotherPubliser [
	^ anotherPubliser asCIPublisher addWith: self 
]

{ #category : #concatenation }
CIAbstractPublisher >> addWith: anotherRule [
	^ CIComposedPublisher 
		with: anotherRule 
		with: self
]

{ #category : #concatenation }
CIAbstractPublisher >> addWithAll: anotherRule [
	^ anotherRule add: self
]

{ #category : #conversion }
CIAbstractPublisher >> asCIPublisher [
	^ self
]

{ #category : #accessing }
CIAbstractPublisher >> manager [
	^ manager
]

{ #category : #accessing }
CIAbstractPublisher >> manager: anObject [
	manager := anObject
]

{ #category : #publishing }
CIAbstractPublisher >> publishBeforeValidation: aCIChange [
	"Publish a CIChange that is about to be validatet"
	self subclassResponsibility
]

{ #category : #publishing }
CIAbstractPublisher >> publishChangeNotFound: aCIChange [
	"Triggered if the change is not found or has no loadable sources attached"
	self subclassResponsibility
]

{ #category : #publishing }
CIAbstractPublisher >> publishFailure: aCIValidationResult [
	"pbulish a failing validation result"
	self subclassResponsibility
]

{ #category : #publishing }
CIAbstractPublisher >> publishIntermediateResult: aValidationResult [
	"By default nothing to be done"
]

{ #category : #publishing }
CIAbstractPublisher >> publishSuccess: aCIValidationResult [
	"pbulish a sucessful validation result"
	self subclassResponsibility
]

{ #category : #publishing }
CIAbstractPublisher >> publishValidationResult: aCIValidationResult [
	"Publish the result of validation"
	
	aCIValidationResult	isSuccess 
			ifTrue: [ self publishSuccess: aCIValidationResult ]
			ifFalse: [ self publishFailure: aCIValidationResult ].
]

{ #category : #accessing }
CIAbstractPublisher >> source [
	^ self manager source
]
