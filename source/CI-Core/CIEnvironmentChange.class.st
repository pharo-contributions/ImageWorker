"
will be used in a near future. It provide necessary methods to know which packages are impacted by changes.

07/2013 not used
"
Class {
	#name : #CIEnvironmentChange,
	#superclass : #CIAbstractChange,
	#instVars : [
		'from',
		'to'
	],
	#category : #'CI-Core'
}

{ #category : #'as yet unclassified' }
CIEnvironmentChange class >> from: oldEnviroment to: newEnvironment [
	^ self new
		from: oldEnviroment;
		to: newEnvironment;
		yourself
]

{ #category : #'accessing package changes' }
CIEnvironmentChange >> addedPackages [
	^ self from packages \ self to packages
]

{ #category : #testing }
CIEnvironmentChange >> changeValidationRule [

	^ self shouldBeImplemented 
]

{ #category : #accessing }
CIEnvironmentChange >> from [
	^ from
]

{ #category : #accessing }
CIEnvironmentChange >> from: anObject [
	from := anObject
]

{ #category : #'accessing package changes' }
CIEnvironmentChange >> modifiedPackages [
	| packages |
	
	packages := Set new.
	self modifiedClasses do: [ :clazz |
		packages add: clazz package ].
	^ packages
]

{ #category : #'accessing package changes' }
CIEnvironmentChange >> removedPackages [
	^ self to packages \ self from packages
]

{ #category : #accessing }
CIEnvironmentChange >> to [
	^ to
]

{ #category : #accessing }
CIEnvironmentChange >> to: anObject [
	to := anObject
]
