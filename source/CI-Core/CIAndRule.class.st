"
I am a composed rule.
I only continue validating my subrules if all the previous subrules were successful.
"
Class {
	#name : #CIAndRule,
	#superclass : #CIComposedRule,
	#category : #'CI-Core-Validation'
}

{ #category : #combining }
CIAndRule >> & anotherRule [
	^ anotherRule asCIValidationRule andWithAll: self
]

{ #category : #combining }
CIAndRule >> andWith: anotherRule [
	self add: anotherRule
]

{ #category : #private }
CIAndRule >> shouldContinueValidationWith: aCIValidationResult [
	"Validate rules for as long as they succeed. Hence all rules after a failing result are ignored."
	^ aCIValidationResult isSuccess
]
