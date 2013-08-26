"
A CIAbstractChangeProvider is an API than you have to use with an issue provider.

Description : 

The IssueChecker communicates with an issue source to get sources that can be loaded or validated.
It give to the manager the way to download changesets. Example, in case of the changeset is from the fogbugz tracker, we have to know how to fetch by autentification protocol from the tracker.
I also contain publishers needed for the manager. (See CI-Core-Publishing for available publisher)

ChangeProvider contain Change than we will work with.

changeWithId: gives you the Change
"
Class {
	#name : #CIAbstractChangeProvider,
	#superclass : #Object,
	#instVars : [
		'manager'
	],
	#category : #'CI-Core'
}

{ #category : #protocol }
CIAbstractChangeProvider >> changeWithId: anId [

	self subclassResponsibility
]

{ #category : #testing }
CIAbstractChangeProvider >> isAuthenticated [

	self subclassResponsibility
]

{ #category : #'log on/off' }
CIAbstractChangeProvider >> logOnWithEmail: emailAddress password: password [

	self subclassResponsibility
]

{ #category : #accessing }
CIAbstractChangeProvider >> manager [
	^ manager
]

{ #category : #accessing }
CIAbstractChangeProvider >> manager: anObject [
	manager := anObject
]

{ #category : #protocol }
CIAbstractChangeProvider >> nextIssueToBeChecked [
	
	self subclassResponsibility
]

{ #category : #accessing }
CIAbstractChangeProvider >> openIssues [
	
	self subclassResponsibility
]

{ #category : #accessing }
CIAbstractChangeProvider >> publisher [
	"return a default CIPublisher for this source"
	^ self subclassResponsibility
]
