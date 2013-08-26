Extension { #name : #RBBrowserEnvironment }

{ #category : #'*CI-Core-Validation' }
RBBrowserEnvironment class >> empty [
	^ RBClassEnvironment 
		onEnvironment: RBBrowserEnvironment new 
		classes: #().
]
