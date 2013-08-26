"
A CISmallIntRule is responsible to run smallint rules and report the results.
"
Class {
	#name : #CISmallIntRule,
	#superclass : #CITestChangeDifferenceRule,
	#instVars : [
		'rules'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #'instance creation' }
CISmallIntRule class >> with: aRule [
	^ self new
		add: aRule;
		yourself
]

{ #category : #'instance creation' }
CISmallIntRule class >> with: aRule with: anotherRule [
	^ self new
		add: aRule;
		add: anotherRule;
		yourself
]

{ #category : #accessing }
CISmallIntRule >> add: aRule [
	self rules add: aRule
]

{ #category : #validation }
CISmallIntRule >> basicValidate [

	self testResult: self runRules.
	^ self validationResult.
]

{ #category : #initialization }
CISmallIntRule >> initialize [
	super initialize.
	self rules: OrderedCollection new.
]

{ #category : #accessing }
CISmallIntRule >> rules [
	^ rules
]

{ #category : #accessing }
CISmallIntRule >> rules: anObject [
	rules := anObject
]

{ #category : #validation }
CISmallIntRule >> runRules [
	| result |
	result := OrderedCollection new.
	self rules do: [ :rule |
		rule run addResultTo: result. ].
	^ result
]

{ #category : #tests }
CISmallIntRule >> testResult: aSmallIntResult [

	aSmallIntResult do: [ :each |
		each classes do: [ :class |
			self addWarning: each label asString, ' ', class asString ]].
]
