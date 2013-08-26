Class {
	#name : #CIValidationRuleTest,
	#superclass : #CITestCase,
	#category : #'CI-Core-Test'
}

{ #category : #testing }
CIValidationRuleTest class >> isAbstract [
	^ self = CIValidationRuleTest
]

{ #category : #accessing }
CIValidationRuleTest >> newFailingChange [
	^ self shouldBeImplemented
]

{ #category : #accessing }
CIValidationRuleTest >> newInstance [
	^ self ruleClass new
]

{ #category : #accessing }
CIValidationRuleTest >> newSuccessfulChange [
	^ self shouldBeImplemented
]

{ #category : #accessing }
CIValidationRuleTest >> newWarningChange [
	^ self subclassresponsibility 
]

{ #category : #accessing }
CIValidationRuleTest >> ruleClass [
	self subclassResponsibility
]

{ #category : #tests }
CIValidationRuleTest >> testLoadEmptyChange [
	| rule result |
	rule := self newInstance.
	result := rule validate: self newChange.
	self assert: result isSuccess.
]

{ #category : #tests }
CIValidationRuleTest >> testLoadFailingChange [
	| rule result |
	rule := self newInstance.
	result := rule validate: self newFailingChange.
	self assert: result isFailure.
]

{ #category : #tests }
CIValidationRuleTest >> testLoadNil [

	self should: [ self newInstance validate: nil ] raise: Error, AssertionFailure.
	self should: [ self newInstance validate ] raise: Error, AssertionFailure.
]

{ #category : #tests }
CIValidationRuleTest >> testLoadSuccessfulChange [
	| rule result |
	rule := self newInstance.
	result := rule validate: self newSuccessfulChange.
	self assert: result isSuccess.
]

{ #category : #tests }
CIValidationRuleTest >> testLoadWarningChange [
	| rule result |
	rule := self newInstance.
	result := rule validate: self newWarningChange.
	self assert: result isSuccess.
	self assert: result hasWarnings.
]

{ #category : #helper }
CIValidationRuleTest >> validate: rule [
	^ rule validate: self newChange
]
