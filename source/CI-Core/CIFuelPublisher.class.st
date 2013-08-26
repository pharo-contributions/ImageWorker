"
I output validation result as fuel-serialized files.

Try : 


result := CIValidationResult failure: 'Testing !'.
CIFilePublisher publish: result.
"
Class {
	#name : #CIFuelPublisher,
	#superclass : #CIFilePublisher,
	#category : #'CI-Core-Publishing'
}

{ #category : #'file creation' }
CIFuelPublisher >> publishValidationResult: aCIValidationResult [
	self updateFileName: aCIValidationResult.
	
	FileStream forceNewFileNamed: self fileName, '.fuel' do: [:aStream |
		FLSerializer newDefault 
			showProgress;
			serialize: aCIValidationResult 
			on: aStream binary ].
	
]
