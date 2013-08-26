"
I'm responsible to test if the change and the configuration associated to the change is correclty structured and if it's loadable without any problem
"
Class {
	#name : #CIChangeConfigurationValidationRule,
	#superclass : #CIChangeValidationRule,
	#category : #'CI-Core-Validation'
}

{ #category : #accessing }
CIChangeConfigurationValidationRule >> configuration [ 
	^ self source configuration
]

{ #category : #tests }
CIChangeConfigurationValidationRule >> testIsLoadable [
"	self change assertLoadable.
	ImageWorker evaluate: [| test specLoader|
	(self change group isNil )
		ifTrue: [ test := self change configurationPoint load ]
		ifFalse: [ test := self change configurationPoint load: self group].
	test isNil 
		ifTrue: [ ^ self addError: self change asString, ': Problem while loading' ].
	specLoader := test spec.
	specLoader required isEmpty 
		ifTrue: [ self addError: self change asString, ': loading required is empty' ].
	specLoader packages isEmpty not
		ifTrue: [ self addMessage: self change asString, ': load this packages, ', specLoader packages asString ].
	specLoader loaderPolicy isNotNil 
		ifTrue: [ self addMessage: self change asString, specLoader loaderPolicy loadDirective asString  ]
		ifFalse: [ self addError: self change asString, ': loading''s directive is anormal '  ].]"
		
	 
	
]

{ #category : #tests }
CIChangeConfigurationValidationRule >> testMetacelloToolBox [
	| result |
	result := (Smalltalk at: #MetacelloToolBox) validateConfiguration: self configuration class.
	result do: [ :each |
		self addError: each asString].
	
	^ self validationResult 
	

]

{ #category : #tests }
CIChangeConfigurationValidationRule >> testStructure [
 	| classSelectors selectors |	
	classSelectors := self configuration class class selectors.
	selectors := self configuration class selectors.
	
	self testing: classSelectors contains: #load.
	self testing: classSelectors contains: #loadDevelopment.
	self testing: classSelectors contains: #loadBleedingEdge.
	self testing: classSelectors contains: #validate.
	
	self testing: selectors contains: #project.
	self testing: selectors contains: #stable:.
	self testing: selectors contains: #development:.
	self testing: selectors contains: #bleedingEdge:.
	^ self validationResult 
	

]

{ #category : #tests }
CIChangeConfigurationValidationRule >> testing: anArray contains: aSymbol [
	
	(anArray contains: [ :each | each = aSymbol ])
		ifFalse: [ self addError: aSymbol asString, ' is missing to ', self configuration name ]
]

{ #category : #protocol }
CIChangeConfigurationValidationRule >> validate [
	self source isNil 	
		ifTrue: [ self addError: 'Source is nil'.
			^ self validationResult  ].
	self configuration isNil
		ifTrue: [ 
			self addError: 'No configuration has been found'.
			^ self validationResult ].
	self testMetacelloToolBox.
	self testStructure.
	self testIsLoadable.
			
]
