Extension { #name : #FLMethodContextSerializationTest }

{ #category : #'*ImageWorker' }
FLMethodContextSerializationTest >> testDoIt [
	"Serialization of DoIt methods should be possible by default."
	
	| context |
	self skip: 'This Test does not work properly when we use it with the ImageWorker'.
	[ Smalltalk evaluate: 'self error' ]
		on: Error 
		do: [:error | context:= error signalerContext sender copyTo: thisContext sender ].
	
	self serialize: context
]
