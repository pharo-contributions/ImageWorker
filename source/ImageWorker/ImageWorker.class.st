"
An ImageWorker is the new image forker stuff. It will use Seamless stuff to communicate with the forked image.

Example : 

ImageWorker evaluate: [ 1+2 ].

/_\ WARNING /_\

You have to use asLocalObject !
Exemple:

ImageWorker evaluate: [ ConfigurationOfCI asLocalObject load ].

ImageWorker evaluate: [ ConfigurationOfCI load ]. Will not work and crash you current image
"
Class {
	#name : #ImageWorker,
	#superclass : #Object,
	#instVars : [
		'localPort',
		'remotePort',
		'forkedImageName',
		'remote',
		'session',
		'localServer',
		'forkedImageProcess'
	],
	#category : #ImageWorker
}

{ #category : #'image-evaluation' }
ImageWorker class >> do: aBlock [

	| worker process |
	
	worker := self new.
	process := self newPollProcessFor: worker.
	worker isForkedImage
		ifTrue: [ ^ self ].
		
	[ 
		^ aBlock value: worker
	] ensure: [ 
		process terminate.
		worker close ]
]

{ #category : #'image-evaluation' }
ImageWorker class >> evaluate: aBlock [
	self do: [ :worker | ^ worker evaluate: aBlock ].
]

{ #category : #'image-evaluation' }
ImageWorker class >> evaluateFromForkedImage: aBlock [	
	| result |
	
	self inform: aBlock asString, ' is currently running.'.
	
	[ result := (aBlock asLocalObject value) ] 
		on: Error do: [ :e |  VTermOutputDriver stderr red: e asString ].
		
	^ result
]

{ #category : #'image-evaluation' }
ImageWorker class >> newPollProcessFor: worker [
	"process is usefull to prevent a timeout from Seamless, just in case of."
	
	| process |
	
	process := [ 
		[ VTermOutputDriver stderr green: '.'.
			10 seconds wait.	
			"send a message over the wire"
			(worker remote at: #DateAndTime) now
		] repeat.
		Processor terminateActive ] forkNamed: 'Seamless Poll Process'.
		
	^ process
]

{ #category : #'image-evaluation' }
ImageWorker class >> send: aSelector to: aClassName [

	^ self do: [ :worker | ^ worker send: aSelector to: aClassName ].
]

{ #category : #assertion }
ImageWorker >> checkFileCreation [
	
	self 
		assert: self temporaryChangesFile exists  
		description: self temporaryChangesFile basename, ' doesn''t exist'.
	self 
		assert: self temporaryImageFile exists 
		description: self temporaryImageFile basename, ' doesn''t exist'.
]

{ #category : #'image-communication' }
ImageWorker >> close [
	self isForkedImage
		ifTrue: [ ^ self ].
	
	[self closeRemoveImage] fork.
	2 seconds wait.
	self 
		removeForkedImageFiles;
		closeCommunication
]

{ #category : #'image-communication' }
ImageWorker >> closeCommunication [
	
	localServer stop.
]

{ #category : #'image-communication' }
ImageWorker >> closeRemoveImage [
	(self remote at:#Smalltalk) snapshot: true andQuit: true.
]

{ #category : #'image-creation' }
ImageWorker >> createForkedImage [
	self createNewImageName.
	self isForkedImage
		ifTrue: [ self terminateActiveProcess ]
		ifFalse: [ self launchNewImage ]
]

{ #category : #'image-creation' }
ImageWorker >> createNewImageName [
	self forkedImageName: (Smalltalk imageFile nextVersion basenameWithoutExtension, '_fork', DateAndTime now asString).
	session := Smalltalk session.
	Smalltalk backupTo: self forkedImageName.
	self checkFileCreation
]

{ #category : #'image-evaluation' }
ImageWorker >> evaluate: aBlock [
	self isForkedImage 
		ifFalse: [ 
			^ aBlock value: self remote ]
]

{ #category : #accessing }
ImageWorker >> forkedImageName [
	^ forkedImageName
]

{ #category : #accessing }
ImageWorker >> forkedImageName: anObject [
	forkedImageName := anObject
]

{ #category : #'initialize-release' }
ImageWorker >> initialize [
	"Just in case kill any existing Seamless Daemons.."
	self flag: 'This essentially prevents us from having more than one connection at a time'.
	SeamlessDeamonManager shutDown.
	
	self localPort: self randomPort.
	VTermOutputDriver stderr red: '<= ', self localPort asString;lf .
	
	self remotePort: self randomPort.
	VTermOutputDriver stderr red: '=> ', self remotePort asString;lf.
	
	self createForkedImage.
	VTermOutputDriver stderr red: self forkedImageName asString;lf.
	
	self isForkedImage 
		ifFalse: [ self initializeCommunication ].			
	
]

{ #category : #'image-communication' }
ImageWorker >> initializeCommunication [
	| remoteAuthority |
	remoteAuthority := '127.0.0.1:', self remotePort asString.
	
	100 timesRepeat:[
		0.2 seconds wait.
		[ 
			self remote: 
				(self startLocalServer connectOn: remoteAuthority).
			VTermOutputDriver stdout 
				green: localServer serverAddress; lf.
			^ self.
		] on: Error do: [ :e | ]].
		
	Error signal: 'Connection to ', remoteAuthority, ' failed'.
]

{ #category : #assertion }
ImageWorker >> isForkedImage [
	^ (session = Smalltalk session) not
]

{ #category : #'image-forking' }
ImageWorker >> launchNewImage [
	self isForkedImage 
		ifFalse: [
			forkedImageProcess := OSProcess command: 
				Smalltalk vm command, 
				' ', 
				self temporaryImageFile fullName, 
				' seamless ', 
				self remotePort asString ]
	
	"
	it will not be a forked image since we have seamless comm Unmatched string quote ->andline handlers
	PipeableOSProcess command: temporaryImageCommand.
	self waitingForkedImageMessage."
]

{ #category : #accessing }
ImageWorker >> localPort [
	^ localPort
]

{ #category : #accessing }
ImageWorker >> localPort: anObject [
	localPort := anObject
]

{ #category : #'image-communication' }
ImageWorker >> randomPort [

	| socket port |
	
	socket := Socket newTCP.
	port := (socket listenOn: 0) port.
	socket close.
	
	^ port
]

{ #category : #accessing }
ImageWorker >> remote [
	^ remote
]

{ #category : #accessing }
ImageWorker >> remote: anObject [
	remote := anObject
]

{ #category : #accessing }
ImageWorker >> remotePort [
	^ remotePort
]

{ #category : #accessing }
ImageWorker >> remotePort: anObject [
	remotePort := anObject
]

{ #category : #'image-creation' }
ImageWorker >> removeForkedImageFiles [
	self temporaryChangesFile ensureDelete.
	self temporaryImageFile ensureDelete.	
]

{ #category : #'image-evaluation' }
ImageWorker >> send: aSelector to: aClassName [
	
	^ ((self remote at:aClassName) perform: aSelector  ) asLocalObject 
]

{ #category : #'image-communication' }
ImageWorker >> startLocalServer [

	^ localServer := SeamlessDeamon newDefaultWithGlobalAccess startOn: self localPort 
]

{ #category : #accessing }
ImageWorker >> temporaryChangesFile [
	"return the FileReference to the newly created test image "
	^ Smalltalk fileForChangesNamed: self forkedImageName 
]

{ #category : #accessing }
ImageWorker >> temporaryImageFile [
	"return the FileReference to the newly created test image "
	^ Smalltalk fileForImageNamed: self forkedImageName 
]

{ #category : #'image-creation' }
ImageWorker >> terminateActiveProcess [
	"Terminate the current UI process in the freshly spawned image.
	This way we can be sure to not have any nast side-effects from the pending stack.
	The forked  image will contain the full stack of the original image, thus it is not guaranteed that the exuction in the new image is properly stopped."
	 
	| currentProcess semaphore |

	semaphore := Semaphore new.
	currentProcess := Processor activeProcess.

	[ | queue nextInQueue|
		"kill the current UI process"
		[currentProcess terminate] on: Error do: [ :error | ].
		"process the pending ui messages to make sure we activate the commandline handler!"
		queue := WorldState deferredUIMessages.
		[(nextInQueue := queue nextOrNil) isNil] whileFalse: [ nextInQueue value]. 
		
		semaphore signal.
	] fork.

	semaphore wait.
	Error signal: 'Should not get here'
]
