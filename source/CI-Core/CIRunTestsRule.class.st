"
I load a case source in a separate image and publish the test results.
"
Class {
	#name : #CIRunTestsRule,
	#superclass : #CITestChangeDifferenceRule,
	#instVars : [
		'selectTestCaseBlock',
		'testErrors',
		'testFailures'
	],
	#category : #'CI-Core-Validation'
}

{ #category : #'instance creation' }
CIRunTestsRule class >> packagePrefix: aString [
	^ self selectTestCaseBlock: [ :case |
		case package name beginsWith: aString ]
]

{ #category : #'instance creation' }
CIRunTestsRule class >> selectTestCaseBlock: aBlock [
	^ self new
		 	selectTestCaseBlock: aBlock;
			yourself
]

{ #category : #validation }
CIRunTestsRule >> basicValidate [
	| suite result |
	
	suite := self testSuite.
	result := CITestResult new.
	result maxTest: suite tests size.
	
	suite run: result.
	
	self testResult: result.
	^ self validationResult
]

{ #category : #'initialize-release' }
CIRunTestsRule >> defaultSelectTestCaseBlock [
	"I return a default test block that filters out certain packages that would cause trouble when testing during a validation process."
	^ [ :testCaseClass | 
		#('CI-' 'OSProcess-' 'CommandShell-' 'Seamless-' ) noneSatisfy: [ :packagePrefix |
			testCaseClass package name beginsWith: packagePrefix ]]
]

{ #category : #accessing }
CIRunTestsRule >> filePrefix [
	| imageName originalPrefix |
	
	imageName := Smalltalk imageFile basenameWithoutExtension.
	originalPrefix := super filePrefix.
	
	(originalPrefix = imageName)
		ifFalse: [ ^ originalPrefix ].
		
	^ imageName, '_', originalPrefix
		
]

{ #category : #'initialize-release' }
CIRunTestsRule >> initialize [
	super initialize.
	"Do not run the CI tests by default"
	selectTestCaseBlock := self defaultSelectTestCaseBlock
]

{ #category : #accessing }
CIRunTestsRule >> selectTestCaseBlock [
	^ selectTestCaseBlock
]

{ #category : #accessing }
CIRunTestsRule >> selectTestCaseBlock: aSelectBlock [
	selectTestCaseBlock := aSelectBlock
]

{ #category : #validation }
CIRunTestsRule >> testResult: aTestResult [
	"process the test results "
	self 
		addAllErrors: aTestResult failures;
		addAllErrors: aTestResult errors;
		addAllWarnings: aTestResult skipped.
]

{ #category : #validation }
CIRunTestsRule >> testSuite [
	| suite |
	suite := TestSuite new.
	TestCase allSubclasses
		select: self defaultSelectTestCaseBlock
		thenDo: [ :testClass | 
			(self selectTestCaseBlock value: testClass)
				ifTrue: [ 
					testClass isAbstract
						ifFalse: [ suite addTests: testClass suite tests ]]].
	^ suite
]
