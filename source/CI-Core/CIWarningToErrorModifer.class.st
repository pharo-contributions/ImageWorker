"
I convert all the warnings of the validation of a rule to errors.
"
Class {
	#name : #CIWarningToErrorModifer,
	#superclass : #CIRuleModifer,
	#category : #'CI-Core-Validation'
}

{ #category : #protocol }
CIWarningToErrorModifer >> modifyResult: aCIValidationResult [
	| result |
	result := CIValidationResult new
		addAllErrors: aCIValidationResult errors;
		addAllErrors: aCIValidationResult warnings;
		addAllMessages: aCIValidationResult messages;
		yourself.
	^ self validationResult: result
]

{ #category : #printing }
CIWarningToErrorModifer >> printOn: asStream [
	asStream print: self rule; << ' harden'.
]

{ #category : #conversion }
CIWarningToErrorModifer >> soften [
	^ self rule
]
