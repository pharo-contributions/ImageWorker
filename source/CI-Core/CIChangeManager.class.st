"
I am in charge of loading an issue for my tracker and then provide it to the validator, and finally update the tracker according to the validator result.

My scenario is:
	1) log on to the tracker
	2) fetch the next interesting issue, the logic of which one is interesting or not depends on me only. The tracker should not know about this at all
	3) load latest slice (yes, we drop cs files)
	4) provide it to the validator
	5) get results from the validator
	6) update the issue
	7) log off and let another instance do the next issue
"
Class {
	#name : #CIChangeManager,
	#superclass : #Object,
	#instVars : [
		'validator',
		'source',
		'publisher'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
CIChangeManager class >> pharo [
	^ self pharo30
]

{ #category : #'instance creation' }
CIChangeManager class >> pharo30 [
	^ self 
		source: CISliceChangeProvider pharo30
		validator: CIValidator pharo30
]

{ #category : #'instance creation' }
CIChangeManager class >> source: anIssueSource validator: aCIValidator [
	
	^ self new
		source: anIssueSource;
		validator: aCIValidator;
		publisher: anIssueSource publisher;
		yourself
]

{ #category : #'delegate issue source' }
CIChangeManager >> changeWithGroup: aString [

	^ self source group: aString
]

{ #category : #'delegate issue source' }
CIChangeManager >> changeWithId: anInteger [

	^ self source changeWithId: anInteger
]

{ #category : #'delegate issue source' }
CIChangeManager >> isAuthenticated [
	
	^ self source isAuthenticated
]

{ #category : #'log on/off' }
CIChangeManager >> logOn [

	self tracker logOnWithEmail: self emailAddress password: self password
]

{ #category : #'delegate issue source' }
CIChangeManager >> logOnWithEmail: email password:  password [

	^ self source logOnWithEmail: email password: password
]

{ #category : #'delegate issue source' }
CIChangeManager >> nextIssueToBeChecked [

	^ self source nextIssueToBeChecked
]

{ #category : #'delegate issue source' }
CIChangeManager >> openIssues [

	^ self source openIssues
]

{ #category : #accessing }
CIChangeManager >> publisher [
	^ publisher
]

{ #category : #accessing }
CIChangeManager >> publisher: aCIPublisher [
	publisher := aCIPublisher.
	publisher manager: self
]

{ #category : #accessing }
CIChangeManager >> source [
	^ source
]

{ #category : #accessing }
CIChangeManager >> source: aCIIssueSource [
	source := aCIIssueSource.
	source manager: self.
]

{ #category : #'delegate issue source' }
CIChangeManager >> validateChange: aCase [
	^ self validator validateChange: aCase
]

{ #category : #accessing }
CIChangeManager >> validator [
	^ validator
]

{ #category : #accessing }
CIChangeManager >> validator: aCIValidator [
	validator := aCIValidator.
	validator manager: self.
]
