Class {
	#name : #CIComposedPublisherTest,
	#superclass : #CIPublisherTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIComposedPublisherTest >> publisherClass [
	^ CIComposedPublisher
]

{ #category : #tests }
CIComposedPublisherTest >> testConcatenation [
	| publisherA publisherB composedPublisher |
	
	publisherA := CICommandLinePublisher new.
	publisherB := CIFilePublisher new.
	composedPublisher := publisherA, publisherB.
	
	self assert: composedPublisher publishers size equals: 2.	
		
	self assert: composedPublisher publishers first equals: publisherA.
	self assert: composedPublisher publishers second equals: publisherB.
]

{ #category : #tests }
CIComposedPublisherTest >> testConcatenationClasses [
	| composedPublisher |
	composedPublisher := CICommandLinePublisher, CIFilePublisher.
	
	self assert: composedPublisher publishers size equals: 2.	
		
	self assert: (composedPublisher publishers first isKindOf: CICommandLinePublisher).
	self assert: (composedPublisher publishers second isKindOf: CIFilePublisher).
]

{ #category : #tests }
CIComposedPublisherTest >> testConcatenationComposedPublisher [
	| publisherA publisherB composedPublisher |
	
	publisherA := CICommandLinePublisher, CICommandLinePublisher.
	publisherB := CIFilePublisher new.
	composedPublisher := publisherA, publisherB.
	
	self assert: composedPublisher publishers size equals: 3.	
		
	self assert: (composedPublisher publishers first isKindOf: CICommandLinePublisher).
	self assert: (composedPublisher publishers second isKindOf: CICommandLinePublisher).
	self assert: composedPublisher publishers third equals: publisherB.
]

{ #category : #tests }
CIComposedPublisherTest >> testConcatenationComposedPublishers [
	| publisherA publisherB composedPublisher |
	
	publisherA := CICommandLinePublisher, CICommandLinePublisher.
	publisherB := CIFilePublisher, CIFilePublisher.
	composedPublisher := publisherA, publisherB.
	
	self assert: composedPublisher publishers size equals: 4.	
		
	self assert: (composedPublisher publishers first isKindOf: CICommandLinePublisher).
	self assert: (composedPublisher publishers second isKindOf: CICommandLinePublisher).
	self assert: (composedPublisher publishers third isKindOf: CIFilePublisher).
	self assert: (composedPublisher publishers fourth isKindOf: CIFilePublisher).
]

{ #category : #tests }
CIComposedPublisherTest >> testSetManager [
	| composedPublisher manager|
	
	composedPublisher := CIFuelPublisher, CICommandLinePublisher, CIIssueTrackerPublisher.
	manager := CIChangeManager new.
	
	self assert: composedPublisher manager equals: nil.
	
	composedPublisher manager: manager.
	
	self assert: composedPublisher manager equals: manager.
	composedPublisher publishers do: [ :publisher|
		self assert: publisher manager equals: manager ]
]
