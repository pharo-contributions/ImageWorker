Extension { #name : #RBLintRuleTest }

{ #category : #'*CI-Core-Validation' }
RBLintRuleTest >> asCIValidationRule [
	^ CISmallIntRule with: self
]
