Class {
	#name : #CIOrRuleTest,
	#superclass : #CIComposedRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIOrRuleTest >> ruleClass [
	^ CIOrRule
]

{ #category : #tests }
CIOrRuleTest >> testFailureOrMessage [

	| ruleOne ruleTwo aResult validatedRuleOne validatedRuleTwo |
	
	validatedRuleOne := false.
	validatedRuleTwo := false.
	
	ruleOne := [ :change |
		validatedRuleOne := true.
		CIValidationResult failure: 'test failure'] asCIValidationRule.
	ruleTwo := [ :change | 
		validatedRuleTwo := true. 
		CIValidationResult message: 'test message' ] asCIValidationRule.
	
	aResult := (ruleOne | ruleTwo) validate: self newChange.
	self assert: validatedRuleOne.
	self assert: validatedRuleTwo.
	
	self assert: aResult errors size equals: 1.
	self assert: aResult messages size equals: 1.	
	self assert: aResult warnings size equals: 0.
]

{ #category : #tests }
CIOrRuleTest >> testMessageOrFailure [

	| ruleOne ruleTwo aResult validatedRuleOne validatedRuleTwo |
	
	validatedRuleOne := false.
	validatedRuleTwo := false.
	
	ruleOne := [ :change |
		validatedRuleOne := true.
		CIValidationResult message: 'test message' ] asCIValidationRule.
	ruleTwo := [ :change | 
		validatedRuleTwo := true. 
		CIValidationResult failure: 'test failure'] asCIValidationRule.
	
	aResult := (ruleOne | ruleTwo) validate: self newChange.
	self assert: validatedRuleOne.
	self deny: validatedRuleTwo.
	
	self assert: aResult errors size equals: 0.
	self assert: aResult messages size equals: 1.	
	self assert: aResult warnings size equals: 0.
]

{ #category : #tests }
CIOrRuleTest >> testNothingOrFailure [

	| ruleOne ruleTwo aResult validatedRuleOne validatedRuleTwo |
	
	validatedRuleOne := false.
	validatedRuleTwo := false.
	
	ruleOne := [ :change |
		validatedRuleOne := true.
		CIValidationResult new] asCIValidationRule.
	ruleTwo := [ :change | 
		validatedRuleTwo := true. 
		CIValidationResult message: 'test message' ] asCIValidationRule.
	
	aResult := (ruleOne | ruleTwo) validate: self newChange.
	self assert: validatedRuleOne.
	self deny: validatedRuleTwo.
	
	self assert: aResult errors size equals: 0.
	self assert: aResult messages size equals: 0.	
	self assert: aResult warnings size equals: 0.
]
