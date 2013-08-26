Class {
	#name : #CIPublisherTest,
	#superclass : #CITestCase,
	#instVars : [
		'instance'
	],
	#category : #'CI-Core-Test'
}

{ #category : #testing }
CIPublisherTest class >> isAbstract [
	^ self = CIPublisherTest
]

{ #category : #accessing }
CIPublisherTest >> publisherClass [
	^ self subclassResponsibility
]

{ #category : #setup }
CIPublisherTest >> setUp [
	super setUp.
	instance := self newPublisher
]

{ #category : #tests }
CIPublisherTest >> testPublishBeforeValidation [
	instance publishBeforeValidation: self newChange
]

{ #category : #tests }
CIPublisherTest >> testPublishChangeNotFound [
	instance publishChangeNotFound: self newChange
]

{ #category : #tests }
CIPublisherTest >> testPublishIntermediateResult [
	instance publishIntermediateResult: self newValidationResult
]

{ #category : #tests }
CIPublisherTest >> testPublishValidationResult [
	instance publishValidationResult: self newValidationResult.
	instance publishValidationResult: self newFailingValidationResult.
]

{ #category : #tests }
CIPublisherTest >> testSetManager [
	| manager |
	
	self assert: instance manager isNil.
	
	manager := self newManager.
	instance manager: manager.
	self assert: instance manager equals: manager
]
