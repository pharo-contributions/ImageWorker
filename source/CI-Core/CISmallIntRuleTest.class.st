Class {
	#name : #CISmallIntRuleTest,
	#superclass : #CIValidationRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #testing }
CISmallIntRuleTest class >> isAbstract [
	^ self = CISmallIntRuleTest
]

{ #category : #accessing }
CISmallIntRuleTest >> newInstance [
	^ self ruleClass asCIValidationRule  
]
