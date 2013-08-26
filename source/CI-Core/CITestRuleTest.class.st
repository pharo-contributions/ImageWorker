Class {
	#name : #CITestRuleTest,
	#superclass : #CIValidationRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CITestRuleTest >> newFailingChange [
	^ CITestChange loadBlock: [ CIValidationResult failure: 'failure' ]
]

{ #category : #accessing }
CITestRuleTest >> newInstance [
	^ self ruleClass block: [ :change | 
		change loadBlock 
			ifNotNil: [ :block | block value ]
			ifNil: [ CIValidationResult new ]]
]

{ #category : #accessing }
CITestRuleTest >> newSuccessfulChange [
	^ CITestChange loadBlock: [ CIValidationResult new ]
]

{ #category : #accessing }
CITestRuleTest >> newWarningChange [
	^ CITestChange loadBlock: [ CIValidationResult warning: 'warning' ]
]

{ #category : #accessing }
CITestRuleTest >> ruleClass [
	^ CITestRule
]
