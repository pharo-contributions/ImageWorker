Extension { #name : #GoferResolvedReference }

{ #category : #'*CI-Core' }
GoferResolvedReference >> url [
	^ self repository locationWithTrailingSlash, self name
]
