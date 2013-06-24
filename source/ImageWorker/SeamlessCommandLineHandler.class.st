"
Usage: seamless port

	port		is the seamless actual port.
			
Documentation:

A SeamlessCommandLineHandler is a commandLineHandler to use Seamless from commandLine :)
"
Class {
	#name : #SeamlessCommandLineHandler,
	#superclass : #CommandLineHandler,
	#instVars : [
		'localPort'
	],
	#category : #ImageWorker
}

{ #category : #accessing }
SeamlessCommandLineHandler class >> commandName [
	^ 'seamless'
]

{ #category : #accessing }
SeamlessCommandLineHandler class >> description [
	^ 'ImageWorker stuff with Seamless communication'
]

{ #category : #activation }
SeamlessCommandLineHandler >> activate [
	" isn't working for the moment ..."
	self activateHelp
		ifTrue: [ ^ self ].
	localPort := self argumentAt: 1.
	self initializeCommunication.
]

{ #category : #'image-communication' }
SeamlessCommandLineHandler >> closeCommunication [
]

{ #category : #'image-communication' }
SeamlessCommandLineHandler >> initializeCommunication [
	SeamlessDeamon newDefaultWithGlobalAccess startOn: self localPort 
]

{ #category : #accessing }
SeamlessCommandLineHandler >> localPort [
	^ localPort
]

{ #category : #accessing }
SeamlessCommandLineHandler >> localPort: anObject [
	localPort := anObject
]
