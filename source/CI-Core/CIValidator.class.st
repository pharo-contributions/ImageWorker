"
I validate a given case using CIValidationRules
"
Class {
	#name : #CIValidator,
	#superclass : #Object,
	#instVars : [
		'manager',
		'rule'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #'instance creation' }
CIValidator class >> configuration [
				
	^ self new
		addRule: 
				RBUnclassifiedMethodsRule harden & 
				RBNoClassCommentRule harden;
		yourself
]

{ #category : #'instance creation' }
CIValidator class >> manager: aCIChecker [
	^ self new	
		manager: aCIChecker;
		yourself
]

{ #category : #'instance creation' }
CIValidator class >> pharo30 [
	^ self new
		addRule: 
			CIRunTestsRule,
			RBCompositeLintRule pharoHardLintRules harden,
			RBCompositeLintRule pharoSoftLintRules;
		yourself
]

{ #category : #'instance creation' }
CIValidator class >> slice [
	^self pharo30 
]

{ #category : #adding }
CIValidator >> addRule: aRule [ 
	rule := rule, aRule
]

{ #category : #validation }
CIValidator >> asertLoadable: aChange [
	aChange isLoadable 
		ifTrue: [ ^ self ].
	self publishChangeNotFound: aChange.
]

{ #category : #'initialize-release' }
CIValidator >> initialize [
	super initialize.
	rule := CIListRule new.
]

{ #category : #accessing }
CIValidator >> manager [
	^ manager
]

{ #category : #accessing }
CIValidator >> manager: anObject [
	manager := anObject
]

{ #category : #publishing }
CIValidator >> publishBeforeValidation: aCIChange. [
	^ self publisher publishBeforeValidation: aCIChange.
]

{ #category : #publishing }
CIValidator >> publishChangeNotFound: aCIChange. [
	^ self publisher publishChangeNotFound: aCIChange.
]

{ #category : #publishing }
CIValidator >> publishIntermediateResult: aValidationResult [
	^ self publisher publishIntermediateResult: aValidationResult
]

{ #category : #publishing }
CIValidator >> publishValidationResult: aValidationResult [
	^ self publisher publishValidationResult: aValidationResult
]

{ #category : #accessing }
CIValidator >> publisher [
	^ self manager publisher
]

{ #category : #accessing }
CIValidator >> rule [
	^ rule
]

{ #category : #validation }
CIValidator >> validateChange: aCIChange [
	| result rules |
	self publishBeforeValidation: aCIChange.
	
	rules :=  aCIChange changeValidationRule & self rule.
	result := CIValidationResult change: aCIChange.
	
	[ 
		result := rules validate: aCIChange.
	] ensure: [ 
		self publishValidationResult: result ].
	
	^ result
]
