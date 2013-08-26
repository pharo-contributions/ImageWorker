"
I convert all the errors of the validation of a rule to warnings.
"
Class {
	#name : #CIErrorToWarningModifer,
	#superclass : #CIRuleModifer,
	#category : #'CI-Core-Validation'
}

{ #category : #conversion }
CIErrorToWarningModifer >> harden [
	^ self rule
]

{ #category : #protocol }
CIErrorToWarningModifer >> modifyResult: aCIValidationResult [
	| result |
	result := CIValidationResult new
		addAllWarnings: aCIValidationResult errors;
		addAllWarnings: aCIValidationResult warnings;
		addAllMessages: aCIValidationResult messages;
		yourself.
	^ self validationResult: result.
]

{ #category : #printing }
CIErrorToWarningModifer >> printOn: asStream [
	asStream print: self rule; << ' soften'.
]
