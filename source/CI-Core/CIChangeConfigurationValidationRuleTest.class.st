Class {
	#name : #CIChangeConfigurationValidationRuleTest,
	#superclass : #CIChangeValidationRuleTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIChangeConfigurationValidationRuleTest >> newFailingChange [
	
	^ CITestChange loadBlock: [ Error signal ]
]

{ #category : #accessing }
CIChangeConfigurationValidationRuleTest >> newSuccessfulChange [
	| source |
	
	[Gofer new
	smalltalkhubUser: 'Pharo' project: 'Example';
	version: 'ConfigurationOfPharoExample-ErwanDouaille.4';
	load. ]valueWithin: 40 seconds onTimeout: [ ^ CITestChange loadBlock: [ Error signal ] ].

	 source := CIConfigurationChangeProvider new
		metacelloProject: (ConfigurationOfPharoExample project).
	
	^ source changeWithId: #stable
]

{ #category : #accessing }
CIChangeConfigurationValidationRuleTest >> newWarningChange [
	| source |
	
	[Gofer new
	smalltalkhubUser: 'Pharo' project: 'Example';
	version: 'ConfigurationOfPharoExample-ErwanDouaille.1';
	load. ]valueWithin: 40 seconds onTimeout: [ ^ CITestChange loadBlock: [ Error signal ] ].
	
	source := CIConfigurationChangeProvider new
		metacelloProject: (ConfigurationOfPharoExample project).
	
	^ source changeWithId: #stable
]

{ #category : #accessing }
CIChangeConfigurationValidationRuleTest >> ruleClass [
 	^ CIChangeConfigurationValidationRule
]

{ #category : #tests }
CIChangeConfigurationValidationRuleTest >> testLoadEmptyChange [
	| rule result |
	rule := self newInstance.
	result := rule validate: self newChange.
	self assert: result isFailure .
]

{ #category : #tests }
CIChangeConfigurationValidationRuleTest >> testLoadWarningChange [
	| rule result |
	rule := self newInstance.
	result := rule validate: self newSuccessfulChange.
	result := (CIErrorToWarningModifer new modifyResult: result) validationResult. 
	self assert: result isSuccess.

]
