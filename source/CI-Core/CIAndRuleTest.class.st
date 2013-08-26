Class {
	#name : #CIAndRuleTest,
	#superclass : #CIComposedRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIAndRuleTest >> ruleClass [
	^ CIAndRule
]

{ #category : #tests }
CIAndRuleTest >> testFailureAndMessage [

	| ruleOne ruleTwo aResult validatedRuleOne validatedRuleTwo |
	
	validatedRuleOne := false.
	validatedRuleTwo := false.
	
	ruleOne := [ :change |
		validatedRuleOne := true.
		CIValidationResult failure: 'test failure' ] asCIValidationRule.
	ruleTwo := [ :change | 
		validatedRuleTwo := true.
		CIValidationResult message: 'test message' ] asCIValidationRule.
	
	aResult := (ruleOne & ruleTwo) validate: self newChange.
	self assert: validatedRuleOne.
	self deny: validatedRuleTwo.
	
	"in case of the failure is handle first, it shouldn't continue to run tests, that's why we get 0 message and 1 failure"
	self assert: aResult errors size equals: 1.
	self assert: aResult messages size equals: 0.	
	self assert: aResult warnings size equals: 0.
]

{ #category : #tests }
CIAndRuleTest >> testMessageAndFailure [

	| ruleOne ruleTwo aResult validatedRuleOne validatedRuleTwo |
	
	validatedRuleOne := false.
	validatedRuleTwo := false.
	
	ruleOne := [ :change |
		validatedRuleOne := true.
		CIValidationResult message: 'test message' ] asCIValidationRule.
	ruleTwo := [ :change | 
		validatedRuleTwo := true. 
		CIValidationResult failure: 'test failure'] asCIValidationRule.
	
	aResult := (ruleOne & ruleTwo) validate: self newChange.
	self assert: validatedRuleOne.
	self assert: validatedRuleTwo.
	
	"in case of the message is handle first, it should continue to run tests, that's why we get 1 message and 1 failure"
	self assert: aResult errors size equals: 1.
	self assert: aResult messages size equals: 1.	
	self assert: aResult warnings size equals: 0.
]
