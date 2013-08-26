"
I validate an issue and publish the results in a CIValidationResult.

A validation rule should be side-effect free so that they can be run in parallel.
"
Class {
	#name : #CIAbstractValidationRule,
	#superclass : #Object,
	#instVars : [
		'change',
		'validationResult'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #combination }
CIAbstractValidationRule class >> & anotherRule [
	^ self asCIValidationRule & anotherRule
]

{ #category : #combination }
CIAbstractValidationRule class >> , anotherRule [
	^ self asCIValidationRule, anotherRule asCIValidationRule
]

{ #category : #conversion }
CIAbstractValidationRule class >> asCIValidationRule [
	^ self new
]

{ #category : #'instance creation' }
CIAbstractValidationRule class >> change: aCase [
	^ self new
		change: aCase;
		yourself
]

{ #category : #conversion }
CIAbstractValidationRule class >> harden [
	^ self asCIValidationRule harden
]

{ #category : #'instance creation' }
CIAbstractValidationRule class >> selectTestCaseBlock: aBlock [
	^ self new
		selectTestCaseBlock: aBlock;
		yourself
]

{ #category : #conversion }
CIAbstractValidationRule class >> soften [
	^ self asCIValidationRule soften
]

{ #category : #validation }
CIAbstractValidationRule class >> validate: aChange [
	^ self asCIValidationRule 
		validate: aChange 
]

{ #category : #combination }
CIAbstractValidationRule class >> | anotherRule [
	^ self asCIValidationRule | anotherRule asCIValidationRule
]

{ #category : #combining }
CIAbstractValidationRule >> & anotherRule [
	^ anotherRule asCIValidationRule andWith: self
]

{ #category : #combining }
CIAbstractValidationRule >> , anotherRule [
	^ anotherRule asCIValidationRule addWith: self
]

{ #category : #adding }
CIAbstractValidationRule >> addAllErrors: aCollection [
	aCollection do: [ :error |
		self addError: error ]
]

{ #category : #adding }
CIAbstractValidationRule >> addAllMessages: aCollection [
	aCollection do: [ :error |
		self addMessage: error ]
]

{ #category : #adding }
CIAbstractValidationRule >> addAllWarnings: aCollection [
	aCollection do: [ :error |
		self addWarning: error ]
]

{ #category : #adding }
CIAbstractValidationRule >> addError: anError [
	| index |
	
	self flag: 'ugly'.
	(anError isKindOf: Exception)
		ifFalse: [ ^ self validationResult addError: anError asString ].
	
	self flag: 'even uglier'.
	index := 1.
	self validationResult addError: (String streamContents: [ :stream | 
		stream tab print: anError; lf.
		(anError signalerContext contextStack first: 10) do: [ :context | 
			stream << (index asString padded: #left to: 2 with: $ ); << ':'; tab.	
			"indent the error string"
			stream << (context asString copyReplaceAll: String cr with: String lf , String tab); lf.
			index := index + 1 ].
		stream tab << '...' ])
]

{ #category : #adding }
CIAbstractValidationRule >> addMessage: message [
	
	self validationResult addMessage: message asString
]

{ #category : #adding }
CIAbstractValidationRule >> addValidationResult: aCIValidationResult [
	self validationResult, aCIValidationResult.
	^ self validationResult
]

{ #category : #adding }
CIAbstractValidationRule >> addWarning: aWarning [
	
	self validationResult addWarning: aWarning asString
]

{ #category : #combining }
CIAbstractValidationRule >> addWith: anotherRule [
	^ CIListRule with: anotherRule with: self
]

{ #category : #combining }
CIAbstractValidationRule >> addWithAll: anotherRule [
	^ anotherRule add: self; yourself
]

{ #category : #combining }
CIAbstractValidationRule >> andWith: anotherRule [
	^ CIAndRule with: anotherRule with: self
]

{ #category : #combining }
CIAbstractValidationRule >> andWithAll: anotherRule [
	^ anotherRule add: self; yourself
]

{ #category : #conversion }
CIAbstractValidationRule >> asCIValidationRule [
	^ self
]

{ #category : #validation }
CIAbstractValidationRule >> assertHasChange [
	self assert: change isNotNil description: 'No change given'.
]

{ #category : #accessing }
CIAbstractValidationRule >> change [
	^ change
]

{ #category : #accessing }
CIAbstractValidationRule >> change: anObject [
	change := anObject asCIChange.
	self validationResult ifNotNil: [ 
		self validationResult change: change ]
]

{ #category : #accessing }
CIAbstractValidationRule >> errors [
	^ self validationResult errors
]

{ #category : #conversion }
CIAbstractValidationRule >> harden [
	"Make this rule less permissive"
	^ CIWarningToErrorModifer rule: self
]

{ #category : #ui }
CIAbstractValidationRule >> inform: aString [
	self flag: 'for debugging'.
	VTermOutputDriver stderr
			nextPutAll: 'Notice: ';
			nextPutAll: aString asString; lf.
]

{ #category : #initialization }
CIAbstractValidationRule >> initialize [
	super initialize.
	self validationResult: CIValidationResult new.
]

{ #category : #accessing }
CIAbstractValidationRule >> messages [
	^ self validationResult messages
]

{ #category : #combining }
CIAbstractValidationRule >> orWith: anotherRule [
	^ CIOrRule with: anotherRule with: self
]

{ #category : #combining }
CIAbstractValidationRule >> orWithAll: anotherRule [
	^ anotherRule add: self; yourself
]

{ #category : #conversion }
CIAbstractValidationRule >> soften [
	"Make this rule less permissive"
	^ CIErrorToWarningModifer rule: self
]

{ #category : #accessing }
CIAbstractValidationRule >> timeout [
	^ 20 minutes
]

{ #category : #validation }
CIAbstractValidationRule >> timeoutFailure [
	self addError: 'Timeout occured while loading ', self change name.
]

{ #category : #protocol }
CIAbstractValidationRule >> validate [
	^self subclassResponsibility
]

{ #category : #validation }
CIAbstractValidationRule >> validate: aChange [
	self change: aChange.
	self inform: 'Running ', self asString.
	[ Author useAuthor: 'CI Validation User' during: [ self validate ]] 
		valueWithin: self timeout 
		onTimeout: [ self timeoutFailure ].
	
	^ self validationResult
]

{ #category : #accessing }
CIAbstractValidationRule >> validationResult [
	
	^ validationResult 
]

{ #category : #accessing }
CIAbstractValidationRule >> validationResult: aCIValidationResult [
	validationResult := aCIValidationResult 
]

{ #category : #accessing }
CIAbstractValidationRule >> warnings [
	^ self validationResult warnings
]

{ #category : #combining }
CIAbstractValidationRule >> | anotherRule [
	^ anotherRule asCIValidationRule orWith: self
]
