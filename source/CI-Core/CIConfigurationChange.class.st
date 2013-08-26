"
I am an abstract representation for a configuration.
Loading this change will the load the code associated with an attached configuration.
"
Class {
	#name : #CIConfigurationChange,
	#superclass : #CIAbstractChange,
	#instVars : [
		'impactedPackages',
		'configurationPoint'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
CIConfigurationChange class >> source: aCISource configurationPoint: aMetacelloVersion [
	
	^ (self source: aCISource) 
		configurationPoint: aMetacelloVersion;
		yourself.
]

{ #category : #protocol }
CIConfigurationChange >> basicLoad [
	"should look if empty string works"
	(self group isNil )
		ifTrue: [ self configurationPoint  load ]
		ifFalse: [ self configurationPoint load: self group] .
	self impactedPackages: self resolveImpactedPackages.
]

{ #category : #testing }
CIConfigurationChange >> changeValidationRule [

	 ^ CIChangeConfigurationValidationRule 
]

{ #category : #accessing }
CIConfigurationChange >> configurationPoint [
	^ configurationPoint
]

{ #category : #accessing }
CIConfigurationChange >> configurationPoint: aMetacelloVersion [
	configurationPoint := aMetacelloVersion
]

{ #category : #accessing }
CIConfigurationChange >> group [
	^ self source group
]

{ #category : #accessing }
CIConfigurationChange >> id [
	^self configurationPoint name
]

{ #category : #accessing }
CIConfigurationChange >> impactedPackages [
	^ impactedPackages
]

{ #category : #accessing }
CIConfigurationChange >> impactedPackages: anObject [
	impactedPackages := anObject
]

{ #category : #testing }
CIConfigurationChange >> isLoadable [
	^ configurationPoint notNil
]

{ #category : #accessing }
CIConfigurationChange >> name [
	^ self configurationPoint spec projectLabel asString, '-', self version asString
]

{ #category : #protocol }
CIConfigurationChange >> publicUrl [
	^ self source url
]

{ #category : #accessing }
CIConfigurationChange >> resolveImpactedPackages [
	| aSet |
	aSet := OrderedCollection new.
	RPackage organizer packageNames do: [ :packageName|
		((self name,'-.*') asRegex matches: packageName)
			ifTrue: [ aSet add: packageName ]].
	^ aSet
	
]

{ #category : #accessing }
CIConfigurationChange >> version [	

	^ self configurationPoint versionNumber
]
