"
I am an abstract representation of an issue tracker case mainly used to define protocol methods.

Description :

Change contains many informations about changesets, URL repository, name, id, which version to use and how to load changesets in the system.

Change will be used by manager to start the validation process. 

CIManager >> validate: aChange
	""return a CIValidationResult which will be used by CIPublisher""
	^ self validationRule validate: aChange
"
Class {
	#name : #CIAbstractChange,
	#superclass : #Object,
	#instVars : [
		'source'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
CIAbstractChange class >> source: aCISource [ 
	^ self new source: aCISource; yourself
]

{ #category : #conversion }
CIAbstractChange >> asCIChange [
	^ self
]

{ #category : #asserting }
CIAbstractChange >> assertLoadable [
	self isLoadable
		ifFalse: [ ChangeNotFound signalChange: self ]
]

{ #category : #protocol }
CIAbstractChange >> basicLoad [
	self subclassResponsibility
]

{ #category : #testing }
CIAbstractChange >> changeValidationRule [

	self subclassResponsibility
]

{ #category : #accessing }
CIAbstractChange >> id [
	self subclassResponsibility .
]

{ #category : #testing }
CIAbstractChange >> isLoadable [
	"return true if this change as loadable sources attached"
	^ self subclassResponsibility
]

{ #category : #loading }
CIAbstractChange >> load [
	| result |
	self assertLoadable.
	result := self basicLoad.
	Smalltalk garbageCollect.
	^ result
]

{ #category : #accessing }
CIAbstractChange >> manager [
	^ self source manager
]

{ #category : #accessing }
CIAbstractChange >> name [
	^ self subclassResponsibility
]

{ #category : #printing }
CIAbstractChange >> printOn: aStream [

	aStream 
		nextPutAll: 'Change of ';
		nextPutAll: self name.
]

{ #category : #protocol }
CIAbstractChange >> publicUrl [

	self subclassResponsibility
]

{ #category : #accessing }
CIAbstractChange >> source [
	^ source
]

{ #category : #accessing }
CIAbstractChange >> source: anObject [
	source := anObject
]
