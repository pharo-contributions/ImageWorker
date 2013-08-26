"
I display validation result and progress on mutliple other publishers.
This is useful for instance if you want to have direct feedback on the command line using the CICommandLinePublisher and at the same time use another publisher.
"
Class {
	#name : #CIComposedPublisher,
	#superclass : #CIAbstractPublisher,
	#instVars : [
		'publishers'
	],
	#category : #'CI-Core-Publishing'
}

{ #category : #'instance creation' }
CIComposedPublisher class >> with: aPublisher with: anotherPublisher [
	^ self new
		add: aPublisher;
		add: anotherPublisher;
		yourself
]

{ #category : #concatenation }
CIComposedPublisher >> , anotherRule [
	^ anotherRule asCIPublisher addWithAll: self
]

{ #category : #adding }
CIComposedPublisher >> add: aCIPublisher [
	self publishers add: aCIPublisher .
]

{ #category : #adding }
CIComposedPublisher >> addAll: aCollection [
	self publishers addAll: aCollection.
]

{ #category : #concatenation }
CIComposedPublisher >> addWith: anotherRule [
	^ self add: anotherRule
]

{ #category : #concatenation }
CIComposedPublisher >> addWithAll: anotherRule [
	^ anotherRule addAll: self publishers
]

{ #category : #'initialize-release' }
CIComposedPublisher >> initialize [ 
	self publishers: OrderedCollection new.
]

{ #category : #accessing }
CIComposedPublisher >> manager: aCIChangeManager [
	super manager: aCIChangeManager.
	self publishers do: [ :publisher |
		publisher manager: aCIChangeManager ]
]

{ #category : #publishing }
CIComposedPublisher >> publishBeforeValidation: aCIChange [
	
	self publishers do: [ :publisher | 
			publisher publishBeforeValidation: aCIChange ].
]

{ #category : #publishing }
CIComposedPublisher >> publishChangeNotFound: aCIValidationResult [
	
	self publishers do: [ :publisher | 
			publisher publishChangeNotFound: aCIValidationResult ].
	
]

{ #category : #publishing }
CIComposedPublisher >> publishIntermediateResult: aCIValidationResult [
	
	self publishers do: [ :publisher | 
			publisher publishIntermediateResult: aCIValidationResult ].
	
]

{ #category : #publishing }
CIComposedPublisher >> publishValidationResult: aCIValidationResult [
	
	self publishers do: [ :publisher | 
			publisher publishValidationResult: aCIValidationResult ].
	
]

{ #category : #accessing }
CIComposedPublisher >> publishers [
	^ publishers
]

{ #category : #accessing }
CIComposedPublisher >> publishers: anObject [
	publishers := anObject
]
