Class {
	#name : #CISmallIntRuleUncategorizedMethodTest,
	#superclass : #CISmallIntRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CISmallIntRuleUncategorizedMethodTest >> newFailingChange [
	^ CITestChange loadBlock: [ (Error signal) ]
]

{ #category : #accessing }
CISmallIntRuleUncategorizedMethodTest >> newSuccessfulChange [
	^ CITestChange loadBlock: [ 
		(Object subclass: #CITestClass	
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: 'CI-Test') ]
]

{ #category : #accessing }
CISmallIntRuleUncategorizedMethodTest >> newWarningChange [
	^ CITestChange loadBlock: [ 
		(Object subclass: #CITestClass	
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: 'CI-Test') .
		 (Smalltalk at:#CITestClass) compile: 'testingUngategorized
^ self']
	
	
]

{ #category : #accessing }
CISmallIntRuleUncategorizedMethodTest >> ruleClass [
	^ RBUnclassifiedMethodsRule 
]
