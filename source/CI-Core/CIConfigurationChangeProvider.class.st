"
I am specialized issue source that loads configurations from a monticello repository.
"
Class {
	#name : #CIConfigurationChangeProvider,
	#superclass : #CIAbstractMonticelloChangeProvider,
	#instVars : [
		'metacelloProject',
		'group'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
CIConfigurationChangeProvider class >> url: anURL [ 
	^ self basicNew 
		initializeWithUrl: anURL
]

{ #category : #'instance creation' }
CIConfigurationChangeProvider class >> url: anURL configurationName: aConfigurationName [
	^ self basicNew 
		initializeWithUrl: anURL
		configurationName: aConfigurationName
]

{ #category : #protocol }
CIConfigurationChangeProvider >> changeWithId: aVersionName [
	"Returns a CIConfigurationChange for the given version using the default group.
	aVersion might be a numeric version such as: '1.0', '1.1' or as well a symbolic version name such as: #stable, #development, #last"
	^ CIConfigurationChange 
		source: self 
		configurationPoint: (self metacelloProject version: aVersionName)
]

{ #category : #protocol }
CIConfigurationChangeProvider >> changes [
	"return all possible changes for this configuration. 
	For the configuration we only show the different top-level versions.
	Groups are handled separetly."
]

{ #category : #accessing }
CIConfigurationChangeProvider >> configuration [
	^ self metacelloProject configuration
]

{ #category : #accessing }
CIConfigurationChangeProvider >> group [
	^ group
]

{ #category : #accessing }
CIConfigurationChangeProvider >> group: anObject [
	group := anObject
]

{ #category : #'initialize-release' }
CIConfigurationChangeProvider >> initializeWithUrl: aUrl [
	super initialize.
	self url: aUrl.
	self metacelloProject: (self loadDefaultConfiguration) project
]

{ #category : #'initialize-release' }
CIConfigurationChangeProvider >> initializeWithUrl: aUrl configurationName: aString [
	super initialize.
	self url: aUrl.
	self metacelloProject: (self loadConfiguration: aString) project
]

{ #category : #private }
CIConfigurationChangeProvider >> listConfigurations [
	| finalList |
	finalList := OrderedCollection new.
	self packageNames do:[:each | 
		finalList addIfNotPresent: (((each subStrings: '-') at:1) ).
	].
	^ finalList.
]

{ #category : #private }
CIConfigurationChangeProvider >> loadConfiguration: aConfigurationName [
	self gofer
		package: aConfigurationName;
		load.
	^ Smalltalk globals at: aConfigurationName asSymbol
]

{ #category : #private }
CIConfigurationChangeProvider >> loadDefaultConfiguration [
	"Try to find a valid configuration in a repository
	1. use the repository name to deduce a valid configuration name
	2. or check all packages in the repository and use the single package starting with ConfigurationOf.."
	(self url asZnUrl lastPathSegment beginsWith: 'ConfigurationOf')
		ifTrue: [ ^ self loadConfiguration: (self url asZnUrl lastPathSegment) ].
	(self listConfigurations size = 1)
		ifFalse: [ ^ Error signal: 'The specified url does not contain a ConfigurationOf'  ].
	self loadConfiguration: (self listConfigurations at: 1).
]

{ #category : #accessing }
CIConfigurationChangeProvider >> metacelloProject [
	^ metacelloProject
]

{ #category : #accessing }
CIConfigurationChangeProvider >> metacelloProject: aMetacelloProject [
	metacelloProject := aMetacelloProject
]

{ #category : #private }
CIConfigurationChangeProvider >> packageNames [
	| names fullName aStream |
	aStream := (ZnClient new get: self url) readStream.
	names := OrderedCollection new.
	[aStream atEnd] whileFalse:
		[[aStream upTo: $<. {$a. $A. nil} includes: aStream next] whileFalse.
		aStream upTo: $".
		aStream atEnd ifFalse: [
			fullName := aStream upTo: $".
			names add: fullName unescapePercents]].
	^ names select: [:each |  '*.mcz' match: each ]
]

{ #category : #accessing }
CIConfigurationChangeProvider >> publisher [
	
	^ CICommandLinePublisher, CIHTMLPublisher, CIXMLPublisher 
]

{ #category : #accessing }
CIConfigurationChangeProvider >> validateChange: aConfiguration [
	^ self validator validateChange: aConfiguration
]
