Class {
	#name : #CIListRuleTest,
	#superclass : #CIComposedRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIListRuleTest >> ruleClass [
	^ CIListRule
]

{ #category : #tests }
CIListRuleTest >> testShouldContinue [

	| ruleOne ruleTwo aResult ruleThree ruleFour |
	
	ruleOne :=   [ :change | CIValidationResult failure: 'test failure' ] asCIValidationRule.
	ruleTwo :=   [ :change | CIValidationResult message: 'test message' ] asCIValidationRule.
	ruleThree := [ :change | CIValidationResult warning: 'test message' ] asCIValidationRule.
	ruleFour :=  [ :change | CIValidationResult failure: 'test message' ] asCIValidationRule.
	aResult := (ruleOne, ruleTwo, ruleThree, ruleFour) validate: self newChange.
	
	self assert: aResult errors size equals: 2.
	self assert: aResult messages size equals: 1.	
	self assert: aResult warnings size equals: 1.
]
