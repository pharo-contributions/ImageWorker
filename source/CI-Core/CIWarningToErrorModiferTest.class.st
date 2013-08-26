Class {
	#name : #CIWarningToErrorModiferTest,
	#superclass : #CIRuleModifierTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIWarningToErrorModiferTest >> ruleClass [
	^ CIWarningToErrorModifer
]

{ #category : #tests }
CIWarningToErrorModiferTest >> testModify [
	| aResult aModifyResult |
	
	
	aResult := CIValidationResult new.
	aResult addError: 'a'.
	aResult addMessage: 'b'.
	aResult addWarning: 'c'.
	aModifyResult := (CIWarningToErrorModifer new) modifyResult: aResult.
	
	self assert: aResult errors size equals: 1.	
	self assert: aResult messages size equals: 1.	
	self assert: aResult warnings size equals: 1.	
	
	self assert: aModifyResult errors size equals: 2.	
	self assert: aModifyResult messages size equals: 1.	
	self assert: aModifyResult warnings size equals: 0.	
		
	self assert: (aModifyResult errors first = 'a').
	self assert: (aModifyResult errors second = 'c').
	self assert: (aModifyResult messages first = 'b').
]

{ #category : #tests }
CIWarningToErrorModiferTest >> testSoften [
	| aRule aSoftenedRule result |
	
	aRule := [ :change | CIValidationResult failure: 'failure' ] asCIValidationRule.
	aSoftenedRule := aRule soften.
	result := aSoftenedRule validate: self newChange.
	
	self deny: aRule validate isSuccess.
	self assert: result isSuccess description: 'Ensure tests is successful'.
	
	self assert: result errors isEmpty description: 'Ensure there is no errors for the validation'.
	self assert: result warnings size equals: 1.
	self assert: result warnings first equals: 'failure'.
]
