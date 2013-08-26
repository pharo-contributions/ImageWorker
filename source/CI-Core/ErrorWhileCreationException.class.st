"
An ErrorWhileCreationException is an exception raised when the creation of a new issue fails
"
Class {
	#name : #ErrorWhileCreationException,
	#superclass : #Exception,
	#instVars : [
		'response'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
ErrorWhileCreationException class >> response: response [

	^ self new
		response: response;
		yourself
]

{ #category : #accessing }
ErrorWhileCreationException >> response [
	^ response
]

{ #category : #accessing }
ErrorWhileCreationException >> response: anObject [
	response := anObject
]
