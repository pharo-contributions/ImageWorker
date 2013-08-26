Extension { #name : #SocketStream }

{ #category : #'*CI-Core' }
SocketStream >> fuelNextWordsInto: aWordObject [
	"This method is the same as nextWordsInto: but the restoreEndianness is only done if needed"
	self next: aWordObject basicSize into: aWordObject startingAt: 1.
	^ aWordObject
]

{ #category : #'*CI-Core' }
SocketStream >> nextBytesPutAll: aCollection [
	self nextPutAll: aCollection
]
