"
I modify the validation result of a given rule.
"
Class {
	#name : #CIRuleModifer,
	#superclass : #CIAbstractValidationRule,
	#instVars : [
		'rule'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #'instance creation' }
CIRuleModifer class >> rule: aCIValidationRule [
	^ self new
		rule: aCIValidationRule;
		yourself
]

{ #category : #protocol }
CIRuleModifer >> modifyResult: aCIValidationResult [
	^ self subclassResponsibility
]

{ #category : #accessing }
CIRuleModifer >> rule [
	^ rule
]

{ #category : #accessing }
CIRuleModifer >> rule: anObject [
	rule := anObject
]

{ #category : #protocol }
CIRuleModifer >> validate [
	self assertHasChange.
	^ self modifyResult: (self rule validate: self change)
]
