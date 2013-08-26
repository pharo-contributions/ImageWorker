"
I am a composed rule.
I only stop validating my subrules after the first succesfull result. 
"
Class {
	#name : #CIOrRule,
	#superclass : #CIComposedRule,
	#category : #'CI-Core-Validation'
}

{ #category : #combining }
CIOrRule >> orWith: anotherRule [
	self add: anotherRule
]

{ #category : #private }
CIOrRule >> shouldContinueValidationWith: aCIValidationResult [
	"As long as the intermediate result is a failure continue validating.
	Hence as soon as there is a positive result all the following rules are not validated."
	^ aCIValidationResult isFailure
]

{ #category : #combining }
CIOrRule >> | anotherRule [
	^ anotherRule asCIValidationRule orWithAll: self
]
