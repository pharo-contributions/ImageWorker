"
I am an abstract composed rule. 
I contain subrules that are evaluated in a certain manner see my subclasses for more implementations.
"
Class {
	#name : #CIComposedRule,
	#superclass : #CIAbstractValidationRule,
	#instVars : [
		'rules'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #'instance creation' }
CIComposedRule class >> with: aCIValidationRule [
	^ self new
		add: aCIValidationRule;
		yourself
]

{ #category : #'instance creation' }
CIComposedRule class >> with: aCIValidationRule with: anotherCIValidationRule [
	^ self new
		add: aCIValidationRule;
		add: anotherCIValidationRule;
		yourself
]

{ #category : #'instance creation' }
CIComposedRule class >> with: aCIValidationRule withRules: anotherCIValidationRule [
	^ self new
		add: aCIValidationRule;
		addAll: anotherCIValidationRule;
		yourself
]

{ #category : #adding }
CIComposedRule >> add: aValidationRule [
	^ rules add: aValidationRule
]

{ #category : #adding }
CIComposedRule >> addAll: aValidationRule [
	^ rules addAll: aValidationRule
]

{ #category : #initialize }
CIComposedRule >> initialize [
	super initialize.

	rules := OrderedCollection new.
]

{ #category : #accessing }
CIComposedRule >> rules [
	^ rules
]

{ #category : #accessing }
CIComposedRule >> rules: anObject [
	rules := anObject
]

{ #category : #private }
CIComposedRule >> shouldContinueValidationWith: aCIValidationResult [
	self subclassResponsibility
]

{ #category : #protocol }
CIComposedRule >> validate [
	| result |
	self assertHasChange.
	result := CIValidationResult new.
	
	self rules do: [ :validationRule |
		result := result, (validationRule validate: self change).
		(self shouldContinueValidationWith: result)
			ifFalse: [ ^ self addValidationResult: result ]].
	
	^  self addValidationResult: result.
	
]
