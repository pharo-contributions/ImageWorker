Class {
	#name : #CIPluggablePublisherTest,
	#superclass : #CIPublisherTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIPluggablePublisherTest >> publisherClass [
	^ CIPluggablePublisher
]

{ #category : #tests }
CIPluggablePublisherTest >> testNoBlocks [
	" check that all publishing hooks work even without blocks"
	| publisher |
	publisher := CIPluggablePublisher new.
	
	publisher 
		publishBeforeValidation: #aValue;
		publishChangeNotFound: #aValue;
		publishIntermediateResult: #aValue;
		publishValidationResult: #aValue.
]

{ #category : #tests }
CIPluggablePublisherTest >> testPublishBeforeValidation [
	| publisher publishedSomethingElse publishedBeforeValidation |
	
	publishedSomethingElse := false.
	publishedBeforeValidation := false.
	publisher := CIPluggablePublisher block: [ publishedSomethingElse := true ].
	publisher beforeValidationBlock: [ publishedBeforeValidation := true ].
	
	publisher publishBeforeValidation: #anObject.
	self assert: publishedBeforeValidation  description: 'Ensure the validation'.
	self deny: publishedSomethingElse.
]

{ #category : #tests }
CIPluggablePublisherTest >> testPublishChangeNotFound [
	| publisher publishedSomethingElse publishedChangeNotFound |
	
	publishedSomethingElse := false.
	publishedChangeNotFound := false.
	publisher := CIPluggablePublisher block: [ publishedSomethingElse := true ].
	publisher changeNotFoundBlock: [ publishedChangeNotFound := true ].
	
	publisher publishChangeNotFound: #anObject.
	self assert: publishedChangeNotFound .
	self deny: publishedSomethingElse.
]

{ #category : #tests }
CIPluggablePublisherTest >> testPublishIntermediateResult [
	| publisher publishedSomethingElse published |
	
	publishedSomethingElse := false.
	published := false.
	publisher := CIPluggablePublisher block: [ publishedSomethingElse := true ].
	publisher intermediateResultBlock: [ published := true ].
	
	publisher publishIntermediateResult: #anObject.
	self assert: published.
	self deny: publishedSomethingElse.
]

{ #category : #tests }
CIPluggablePublisherTest >> testPublishValidationResult [
	| publisher publishedSomethingElse published |
	
	publishedSomethingElse := false.
	published := false.
	publisher := CIPluggablePublisher block: [ publishedSomethingElse := true ].
	publisher validationResultBlock: [ published := true ].
	
	publisher publishValidationResult: #anObject.
	self assert: published.
	self deny: publishedSomethingElse.
]

{ #category : #tests }
CIPluggablePublisherTest >> testResetAllBlocks [
	| publisher published |
	
	published := 0.
	publisher := CIPluggablePublisher new.
	
	publisher resetAllBlocks: [ published := published + 1 ].
	
	self assert: published = 0.
	publisher 	publishBeforeValidation: #aValue.
	self assert: published = 1.
	
	publisher publishChangeNotFound: #aValue.
	self assert: published = 2.
	
	publisher publishIntermediateResult: #aValue.
	self assert: published = 3.
	
	publisher publishValidationResult: #aValue.
	self assert: published = 4.
]
