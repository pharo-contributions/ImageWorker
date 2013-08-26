"
I am a composed rule.
I validate a set of subrules and return their combined result.
"
Class {
	#name : #CIListRule,
	#superclass : #CIComposedRule,
	#category : #'CI-Core-Validation'
}

{ #category : #combining }
CIListRule >> , anotherRule [
	^ anotherRule asCIValidationRule addWithAll: self
]

{ #category : #combining }
CIListRule >> addWith: anotherRule [
	self add: anotherRule
]

{ #category : #private }
CIListRule >> shouldContinueValidationWith: aCIValidationResult [
	^ true
]
