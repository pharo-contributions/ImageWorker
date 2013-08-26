Extension { #name : #BlockClosure }

{ #category : #'*CI-Core' }
BlockClosure >> asCIChange [
	^ CITestChange loadBlock: self
]

{ #category : #'*CI-Core-Validation' }
BlockClosure >> asCIValidationRule [
	^ CITestRule block: self 
]

{ #category : #'*CI-Core-Validation' }
BlockClosure >> valueInForkedImage [
	^ ImageWorker evaluate: self. 
]
