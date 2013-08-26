"
I am very generic validation rule that takes a block and evaluates it with a change.

Example: 
	[ :change | CIValidationResult new ] asCIValidationRule
"
Class {
	#name : #CITestRule,
	#superclass : #CIAbstractValidationRule,
	#instVars : [
		'block'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #conversion }
CITestRule class >> asCIValidationRule [
	Error signal: 'Cannot create default instance of CIBlockRule, do not use the Class as a rule'
]

{ #category : #'instance creation' }
CITestRule class >> block: aBlock [
	^ self new
		block: aBlock;
		yourself
]

{ #category : #accessing }
CITestRule >> block [
	^ block
]

{ #category : #accessing }
CITestRule >> block: anObject [
	block := anObject
]

{ #category : #protocol }
CITestRule >> validate [
	self assertHasChange.
	^ self block ifNotNil: [ 
		self addValidationResult: (self block cull: self change) ]
]
