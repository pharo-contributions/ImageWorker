"
I'm responsible to test is the slice is loadable
"
Class {
	#name : #CIChangeSliceValidationRule,
	#superclass : #CIChangeValidationRule,
	#category : #'CI-Core-Validation'
}

{ #category : #tests }
CIChangeSliceValidationRule >> testIsLoadable [
	self change assertLoadable.
	[[ self change slice merge ] 
		on: MCMergeResolutionRequest do: [ :request |
			self addError: 'Merge conflict occured while loading slice'  ]]
		on: Warning do: [ :warning |
			self addError: 'Warning occurred while loading slice: ', warning asString ]
]

{ #category : #protocol }
CIChangeSliceValidationRule >> validate [

	self testIsLoadable.
			
]
