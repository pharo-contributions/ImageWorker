"
I am a customized test result which outputs the progress on the command line
"
Class {
	#name : #CITestResult,
	#superclass : #TestResult,
	#instVars : [
		'currentTest',
		'maxTest',
		'currentTestCase'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #'image-evaluation' }
CITestResult class >> evaluate: aBlock [
	^ self new; evaluate: aBlock
]

{ #category : #'image-evaluation' }
CITestResult class >> evaluateFromForkedImage: aBlock [
	^ aBlock value
]

{ #category : #adding }
CITestResult >> addError: aTestFailure [
	super addError: aTestFailure.
	self
		print: aTestFailure printString 
		short: ' [FAIL]' 
		on: self stderr red 
]

{ #category : #adding }
CITestResult >> addPass: aTestCase [
	super addPass: aTestCase.
	self
		print: ''
		short: ' [OK]' 
		on: self stderr green 
]

{ #category : #adding }
CITestResult >> addSkip: aTestCase [
	super addSkip: aTestCase.
	self
		print: ''
		short: ' [SKIP]' 
		on: self stderr blue 
]

{ #category : #accessing }
CITestResult >> currentTestCase [
	^ currentTestCase
]

{ #category : #helper }
CITestResult >> increaseTestCount [
	currentTest := currentTest + 1.
]

{ #category : #initialize }
CITestResult >> initialize [
	"Initialization code for CommandLineTestResult"

	super initialize.

	currentTest := 0.
	maxTest := 0.
]

{ #category : #initialize }
CITestResult >> maxTest [
	^ maxTest
]

{ #category : #initialize }
CITestResult >> maxTest: anInteger [
	maxTest := anInteger
]

{ #category : #printing }
CITestResult >> print: anLongErrorMesssage short: aShortString on: aStream [ 
	
	aStream 
		nextPutAll: anLongErrorMesssage;
		nextPutAll: aShortString.
		
	aStream
		clear; flush; lf.
]

{ #category : #printing }
CITestResult >> printProgress [
	| maxPositions |
	maxPositions := (self maxTest log + 1) floor.
	self stderr
		nextPut: $[;
		nextPutAll: (currentTest asString padLeftTo: maxPositions);
		nextPut: $/;
		print: self maxTest;
		nextPutAll: '] '.
]

{ #category : #printing }
CITestResult >> printTestCase: aTestCase [ 
	self printProgress.
	self stderr print: aTestCase.
]

{ #category : #running }
CITestResult >> runCase: aTestCase [ 
	self increaseTestCount.
	currentTestCase := aTestCase.
	self printTestCase: aTestCase.
	super runCase: aTestCase
]

{ #category : #accessing }
CITestResult >> stderr [
	^ VTermOutputDriver stderr
]
