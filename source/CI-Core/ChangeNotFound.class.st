"
I am signalled if the sources for an CIChange cannot be found.
"
Class {
	#name : #ChangeNotFound,
	#superclass : #Error,
	#instVars : [
		'change'
	],
	#category : #'CI-Core'
}

{ #category : #signalling }
ChangeNotFound class >> signalChange: aChange [
	^ self new
		change: aChange;
		signal
]

{ #category : #signalling }
ChangeNotFound class >> signalChange: aChange message: aMessage [
	^ self new
		change: aChange;
		signal: aMessage
]

{ #category : #accessing }
ChangeNotFound >> change [
	^ change
]

{ #category : #accessing }
ChangeNotFound >> change: anObject [
	change := anObject
]
