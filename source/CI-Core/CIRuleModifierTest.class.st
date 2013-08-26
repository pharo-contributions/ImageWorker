Class {
	#name : #CIRuleModifierTest,
	#superclass : #CIValidationRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #testing }
CIRuleModifierTest class >> isAbstract [
	^ self = CIRuleModifierTest
]

{ #category : #accessing }
CIRuleModifierTest >> newInstance [
	^ self ruleClass 
		rule: self newValidationRule
]

{ #category : #tests }
CIRuleModifierTest >> testLoadFailingChange [
	"invalid test for this rule"
]

{ #category : #tests }
CIRuleModifierTest >> testLoadSuccessfulChange [
	"invalid test for this rule"
]

{ #category : #tests }
CIRuleModifierTest >> testLoadWarningChange [
	"invalid test for this rule"
]
