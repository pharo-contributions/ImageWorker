Extension { #name : #TBehavior }

{ #category : #'*ImageWorker' }
TBehavior >> fuelInitializeTraitComposition [

	self traitComposition traits do: [:each | each addUser: self]
]
