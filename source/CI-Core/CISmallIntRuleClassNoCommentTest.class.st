Class {
	#name : #CISmallIntRuleClassNoCommentTest,
	#superclass : #CISmallIntRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CISmallIntRuleClassNoCommentTest >> newFailingChange [
	^ CITestChange loadBlock: [ Error signal ]
]

{ #category : #accessing }
CISmallIntRuleClassNoCommentTest >> newSuccessfulChange [
	^ CITestChange loadBlock: [ 
		(Object subclass: #CITestClass	
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: 'CI-Test') .
	(Smalltalk at:#CITestClass) comment: ' testing !' ]
	
	
]

{ #category : #accessing }
CISmallIntRuleClassNoCommentTest >> newWarningChange [
	^ CITestChange loadBlock: [ 
		(Object subclass: #CITestClass	
			instanceVariableNames: ''
			classVariableNames: ''
			poolDictionaries: ''
			category: 'CI-Test')  ]
	
	
]

{ #category : #accessing }
CISmallIntRuleClassNoCommentTest >> ruleClass [
	^ RBNoClassCommentRule   
]
