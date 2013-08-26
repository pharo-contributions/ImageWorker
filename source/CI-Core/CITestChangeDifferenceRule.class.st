"
A CIWithPreRunnedRule is an abstract which defines a specific comportment for rules which run test before load changements.

"
Class {
	#name : #CITestChangeDifferenceRule,
	#superclass : #CIAbstractValidationRule,
	#instVars : [
		'loadTime',
		'environmentChange',
		'previousResult'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #validation }
CITestChangeDifferenceRule class >> validateLocally: aValidationRule [
	| instance |
	
	instance := aValidationRule asLocalObject.
	
	[ 
		"here we are in the forked image, let's run it"
		instance recordEnvironmentChangeDuring: [
			instance recordValidationChangesDuring: [ instance change load ]]
	] on: Error, Deprecation , Exit do: [ :e | 
		instance addError: e ].
	
	instance validationResult change: nil.
	"now than we got results, doit over, over ... "
	^ instance validationResult
]

{ #category : #protocol }
CITestChangeDifferenceRule >> basicValidate [
	"Basic validate should build up and return a validation result."
	self shouldBeImplemented
]

{ #category : #accessing }
CITestChangeDifferenceRule >> environmentCopy [
	self flag: 'To be implemented properly'.
	^ RPackageOrganizer default copy
]

{ #category : #'false positive handling' }
CITestChangeDifferenceRule >> falsePositives: falsePositives includesResult: result [
	^ falsePositives includes: result
]

{ #category : #accessing }
CITestChangeDifferenceRule >> loadTime [
	^ loadTime
]

{ #category : #validation }
CITestChangeDifferenceRule >> newImageDo: aBlock [
	| result |
	result := ImageWorker evaluate: aBlock.	
	^ result
]

{ #category : #validation }
CITestChangeDifferenceRule >> postLoadValidate [
	"Run the validation checks after loading the change"
	^ self basicValidate
]

{ #category : #validation }
CITestChangeDifferenceRule >> preLoadValidate [
	"Run the validation before loading the change and store the intermediate validation result for later removal of false-positives"
	^ previousResult := self basicValidate copy.
]

{ #category : #validation }
CITestChangeDifferenceRule >> recordEnvironmentChangeDuring: aChangeBlock [
	| oldEnvironment |
	"oldEnvironment := self environmentCopy."
	aChangeBlock value.
	"environmentChange := CIEnvironmentChange from: oldEnvironment to: self environmentCopy."
]

{ #category : #validation }
CITestChangeDifferenceRule >> recordValidationChangesDuring: aBlock [
	self preLoadValidate.
	self inform: 'Loading change.'.
	
	[[ loadTime := aBlock timeToRun ]
		on: Error, Deprecation , Warning do: [ :error |
			^ self addError: (String streamContents: [ :stream |
				stream << 'Could not apply change: '; print: error.
				error signalerContext shortDebugStackOn: stream ])]
	] on: Exception do: [ :e|
		self inform: '   loading signalled ', e asString.
		e pass ].
	
	self inform: 'Loaded change in ', loadTime asString, ' ms'.
	self 
		postLoadValidate;
		removeFalsePositives.
]

{ #category : #'false positive handling' }
CITestChangeDifferenceRule >> removeFalsePositives [
	previousResult 
		ifNil: [ ^ self ].

	validationResult errors: (self 
		removeFalsePositives: previousResult errors 
		from: self errors).
		
	validationResult warnings: (self 
		removeFalsePositives: previousResult warnings 
		from: self warnings).
		
	validationResult messages: (self 
		removeFalsePositives: previousResult messages 
		from: self messages).
		
	 
		
]

{ #category : #'false positive handling' }
CITestChangeDifferenceRule >> removeFalsePositives: falsePositives from: results [
	
	^ results reject: [ :each || detected |
		self falsePositives: falsePositives includesResult: each ].
	
]

{ #category : #protocol }
CITestChangeDifferenceRule >> validate [
	| result |
	self assertHasChange.
	"this is the new version"
	result := self newImageDo: [ :remote | 
		((remote at: self class name) validateLocally: self) asLocalObject ].
	^ self addValidationResult: result
	
]

{ #category : #validation }
CITestChangeDifferenceRule >> validateChangeBlock: aChangeBlock [
	[ 
		self recordEnvironmentChangeDuring: [
			self recordValidationChangesDuring: aChangeBlock ]
	] on: Error, Exit, Deprecation do: [ :e | 
		self addError: e ].
	
	^ self validationResult
]
