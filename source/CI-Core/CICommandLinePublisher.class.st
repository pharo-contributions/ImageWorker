"
A CICommandLinePublisher is a publisher which publish on the shell directlty.

Try : 

result := CIValidationResult failure: 'Testing !'.
CICommandLinePublisher publish: result.
"
Class {
	#name : #CICommandLinePublisher,
	#superclass : #CIAbstractPublisher,
	#category : #'CI-Core-Publishing'
}

{ #category : #publishing }
CICommandLinePublisher >> publishBeforeValidation: aCIChange [
	VTermOutputDriver stderr 
		yellow: 'Starting validation of ', aCIChange asString; 
		flush; clear; lf.
]

{ #category : #publishing }
CICommandLinePublisher >> publishChangeNotFound: aChange [
	VTermOutputDriver stderr 
		color256: Color orange; 
		<< aChange name asString; << ' >> no changes has been found'; 
		flush; clear; lf.
]

{ #category : #publishing }
CICommandLinePublisher >> publishFailure: aCIValidationResult [ 

	VTermOutputDriver stderr 
		red: (aCIValidationResult change name asString, ' >> test failure report').
	
	aCIValidationResult errors do: [ :aFailure |
		VTermOutputDriver stderr red: aFailure asString;lf ]
]

{ #category : #publishing }
CICommandLinePublisher >> publishMessages: aCIValidationResult [ 

	VTermOutputDriver stderr 
		color256: Color orange; 
		<<(aCIValidationResult change name asString, ' >> test success report') asString; 
		flush; clear; lf.
		
	aCIValidationResult messages do: [ :aMessage |
		VTermOutputDriver stderr color256: Color orange; <<aMessage asString; flush; clear; lf.]
]

{ #category : #publishing }
CICommandLinePublisher >> publishSuccess: aCIValidationResult [ 

	VTermOutputDriver stderr 
		green: (aCIValidationResult change name asString, ' >> test success report'); lf.
	self publishWarnings: aCIValidationResult .
]

{ #category : #publishing }
CICommandLinePublisher >> publishValidationResult: aCIValidationResult [
	
	aCIValidationResult	isSuccess 
			ifTrue: [ self publishSuccess: aCIValidationResult ]
			ifFalse: [ self publishFailure: aCIValidationResult ].
	(aCIValidationResult messages isNil or: [ aCIValidationResult errors isEmpty ])
		ifFalse: [ self publishMessages: aCIValidationResult ].
]

{ #category : #publishing }
CICommandLinePublisher >> publishWarnings: aCIValidationResult [ 

	VTermOutputDriver stderr color256: Color orange; <<(aCIValidationResult change name asString, ' >> warning report :') asString; flush; clear; lf.
	aCIValidationResult warnings do: [ :aWarnings |
		VTermOutputDriver stderr color256: Color orange; <<aWarnings asString; flush; clear; lf.]
]
