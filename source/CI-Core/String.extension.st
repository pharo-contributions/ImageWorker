Extension { #name : #String }

{ #category : #'*CI-Core' }
String >> asGoogleIssueComment [
	^ GoogleIssueComment new
		content: self;
		author: (GoogleUser email: Author fullName);	
		yourself
]

{ #category : #'*CI-Core' }
String >> asGoogleIssueDescription [
	^ self asGoogleIssueComment asDescription
]
