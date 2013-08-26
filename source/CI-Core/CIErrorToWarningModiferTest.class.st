Class {
	#name : #CIErrorToWarningModiferTest,
	#superclass : #CIRuleModifierTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIErrorToWarningModiferTest >> ruleClass [
	^ CIErrorToWarningModifer
]

{ #category : #tests }
CIErrorToWarningModiferTest >> testHarden [
	| rule hardenedRule result |
	
	rule := [ :change | CIValidationResult warning: 'warning' ] asCIValidationRule .
	hardenedRule := rule harden.
	
	result := hardenedRule validate: self newChange.
	
	self assert: result warnings isEmpty.
	self assert: result errors first equals: 'warning'.
]

{ #category : #tests }
CIErrorToWarningModiferTest >> testModify [
	| aResult aModifyResult |
	
	
	aResult := CIValidationResult new.
	aResult addError: 'a'.
	aResult addMessage: 'b'.
	aResult addWarning: 'c'.
	aModifyResult := CIErrorToWarningModifer new modifyResult: aResult.
	
	self assert: aResult errors size equals: 1.	
	self assert: aResult messages size equals: 1.	
	self assert: aResult warnings size equals: 1.	
	
	self assert: aModifyResult warnings size equals: 2.	
	self assert: aModifyResult messages size equals: 1.	
	self assert: aModifyResult errors size equals: 0.	
		
	self assert: (aModifyResult warnings first = 'a').
	self assert: (aModifyResult warnings second = 'c').
	self assert: (aModifyResult messages first = 'b').
]
