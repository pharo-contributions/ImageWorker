Extension { #name : #TSeamlessRemoteProxy }

{ #category : #'*ImageWorker' }
TSeamlessRemoteProxy >> nextObject [
	"We duplicate the nextObject method here to avoid issues with the #obsoleteBehaviors implementation. 
	Or in general when using #allObjectsDo: as we would start iterating over all the objects of the remote image as well, which technically works, but pratically ends up in an ever bigger growing serialization overhead."

	<primitive: 139>
	self primitiveFailed.
]
