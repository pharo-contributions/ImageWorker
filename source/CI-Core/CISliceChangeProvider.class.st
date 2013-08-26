"
I am specialized issue source for the Pharo Integration process. I load issues from the default pharo issue tracker (fogbugz) and I load the corresponding slices from the Pharo Inbox.

"
Class {
	#name : #CISliceChangeProvider,
	#superclass : #CIAbstractMonticelloChangeProvider,
	#instVars : [
		'tracker'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
CISliceChangeProvider class >> pharo30 [
	^ self new
		url: 'http://smalltalkhub.com/mc/Pharo/Pharo30Inbox/main';
		tracker: FogBugzTracker pharo;
		yourself
]

{ #category : #'delegating issue tracker' }
CISliceChangeProvider >> changeWithId: anInteger [
	^ self wrapIssue: (self tracker issueWithId: anInteger)
]

{ #category : #'delegating issue tracker' }
CISliceChangeProvider >> changes [
	^ self tracker openIssues collect: [ :trackerIssue | 
			self wrapIssue: trackerIssue ]
]

{ #category : #'delegating issue tracker' }
CISliceChangeProvider >> isAuthenticated [
	^ self tracker isAuthenticated
]

{ #category : #accessing }
CISliceChangeProvider >> issueTrackerPublisher [
	"If we run on jenkins use a different publisher "
	^ Smalltalk os environment
		at: 'JENKINS_URL'
		ifPresent: [ :value | CIIssueTrackerJenkinsURLPublisher ] 
		ifAbsent: [ CIIssueTrackerPublisher ]

]

{ #category : #loading }
CISliceChangeProvider >> loadSliceFor: anIssue from: gofer [
	| match slices |
	
	match := 'SLICE-Issue-', anIssue id asString.
	slices := gofer allResolved select: [ :ref| ref name beginsWith: match].
	
	slices ifEmpty: [ ^ nil ].
	
	slices size == 1 ifTrue: [ ^ slices first ].
	
	"filter out local cache repositories"
	slices := slices reject: [ :goferReference| 
		goferReference repository isKindOf: MCCacheRepository ].
	
	" get the last version "
	^ (slices sort: [ :a :b | a versionNumber >= b versionNumber ]) first
]

{ #category : #'delegating issue tracker' }
CISliceChangeProvider >> logOnWithEmail: email password:  password [
	^ self tracker logOnWithEmail: email password:  password
]

{ #category : #'delegating issue tracker' }
CISliceChangeProvider >> nextIssueToBeChecked [
	^ self wrapIssue: (self tracker nextIssueToBeChecked)
]

{ #category : #'delegating issue tracker' }
CISliceChangeProvider >> openIssues [
	^ self tracker openIssues collect: [ :trackerIssue | 
			self wrapIssue: trackerIssue ]
]

{ #category : #accessing }
CISliceChangeProvider >> publisher [
	^ CICommandLinePublisher, self issueTrackerPublisher
]

{ #category : #loading }
CISliceChangeProvider >> sliceFor: anIssue [
	^ self loadSliceFor: anIssue from: self gofer
]

{ #category : #accessing }
CISliceChangeProvider >> tracker [
	^ tracker
]

{ #category : #accessing }
CISliceChangeProvider >> tracker: anObject [
	tracker := anObject
]

{ #category : #private }
CISliceChangeProvider >> wrapIssue: anIssue [
	^ CISliceChange source: self case: anIssue 
]
