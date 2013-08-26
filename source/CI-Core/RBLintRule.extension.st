Extension { #name : #RBLintRule }

{ #category : #'*CI-Core-Validation' }
RBLintRule >> addResultTo: results [
	"Helper method to collect results from simple rules and composite rules in a single method"
	results add: self result.
]

{ #category : #'*CI-Core-Validation' }
RBLintRule class >> asCIValidationRule [
	^ CISmallIntRule with: self new.
]

{ #category : #'*CI-Core-Validation' }
RBLintRule >> asCIValidationRule [
	^ CISmallIntRule with: self.
]

{ #category : #'*CI-Core-Validation' }
RBLintRule >> harden [
	^ self asCIValidationRule harden
]

{ #category : #'*CI-Core-Validation' }
RBLintRule class >> harden [
	^ self asCIValidationRule harden
]
