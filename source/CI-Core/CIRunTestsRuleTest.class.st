Class {
	#name : #CIRunTestsRuleTest,
	#superclass : #CIValidationRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #tests }
CIRunTestsRuleTest >> createNewTestClass [
	^ (TestCase subclass: (#CIRunTestsRule_, self selector) asSymbol
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: self defaultTestPackage) asLocalObject 
]

{ #category : #accessing }
CIRunTestsRuleTest >> defaultTestPackage [
	^ 'KernelTests-Numbers'
]

{ #category : #accessing }
CIRunTestsRuleTest >> newFailingChange [
	^ [ | class |
		class := self createNewTestClass.
		class compile: 'testFail
			self fail'.
		class compile: 'testError
			Error signal: #anErrorDescription asWideString '.
		class compile: 'testError2
			self assert: false description: (Character value: 1000) asWideString ' ] asCIChange
]

{ #category : #accessing }
CIRunTestsRuleTest >> newInstance [
	^ self ruleClass selectTestCaseBlock: [ :aClass | 
		aClass package name beginsWith: self defaultTestPackage ]
]

{ #category : #accessing }
CIRunTestsRuleTest >> newSuccessfulChange [
	
	^ [ | class |
		class := self createNewTestClass.
		class compile: 'testSuccess
			self assert: true' ] asCIChange
]

{ #category : #accessing }
CIRunTestsRuleTest >> newWarningChange [
	
	^ [ | class |
		class := self createNewTestClass.
		class compile: 'testSkip
			self skip: #skipping' ] asCIChange
]

{ #category : #accessing }
CIRunTestsRuleTest >> ruleClass [
	^ CIRunTestsRule
]

{ #category : #tests }
CIRunTestsRuleTest >> testErrorValidation [
	| instance aResult |
	
	instance := self newInstance.
	aResult := instance validate: self newFailingChange. 
	
	self assert: aResult errors size > 0 description: 'Ensure there is errors'.
]

{ #category : #tests }
CIRunTestsRuleTest >> testPerfectValidation [
	| instance aResult |
	
	instance := self newInstance.
	aResult := instance validate: self newSuccessfulChange.
	
	self assert: aResult errors size equals: 0.	
	self assert: aResult messages size equals: 0.	
	self assert: aResult warnings size equals: 0.	
]

{ #category : #tests }
CIRunTestsRuleTest >> testSelectTestCaseBlock [
	| suite suite2 |
	suite := self ruleClass new testSuite.
	self deny: suite tests isEmpty.
	
	suite2 := self newInstance
		selectTestCaseBlock: [ :case | false ];
		testSuite.
	self assert: suite2 tests isEmpty.
	
	suite2 := self ruleClass new
		selectTestCaseBlock: [ :case | true ];
		testSuite.
	self 
		assert: suite tests size 
		equals: suite2 tests size
	
]
