"
A CITestCase is an abstract containing the default API used to test the CI project
"
Class {
	#name : #CITestCase,
	#superclass : #TestCase,
	#category : #'CI-Core-Test'
}

{ #category : #testing }
CITestCase class >> isAbstract [
	^ self = CITestCase
]

{ #category : #testing }
CITestCase class >> shouldInheritSelectors [
	^ true
]

{ #category : #accessing }
CITestCase >> newChange [
	^ CITestChange new
]

{ #category : #accessing }
CITestCase >> newFailingValidationResult [
	| result |
	result := self newValidationResult.
	result
		addError: 'failure 1';
		addError: 'failure 2';
		addError: 'failure 3'.
	^ result
]

{ #category : #accessing }
CITestCase >> newFailingValidationRule [
	^ CITestRule block: [ :change| 
		self newFailingValidationResult ]
]

{ #category : #accessing }
CITestCase >> newManager [
	^ CIChangeManager new
]

{ #category : #accessing }
CITestCase >> newPublisher [
	^ self publisherClass new
]

{ #category : #accessing }
CITestCase >> newValidationResult [
	^ CIValidationResult new.
]

{ #category : #accessing }
CITestCase >> newValidationRule [
	^ CITestRule block: [ :change| 
		self newValidationResult ]
]
