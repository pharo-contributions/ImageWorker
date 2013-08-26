"
Read methods, its contain exemples
"
Class {
	#name : #CIConfigurationExemple,
	#superclass : #Object,
	#category : #'CI-Core-Test'
}

{ #category : #tests }
CIConfigurationExemple >> exampleDefault [
	| collection arguments  |
	collection := OrderedCollection new.
	collection add: 'config'.
	collection add: 'http://smalltalkhub.com/mc/PharoExtras/Pastell/main'.	
	collection add: 'ConfigurationOfPastell'.
	
	arguments := CommandLineArguments withArguments: collection.
	CICommandLineHandler activateWith: arguments.
]

{ #category : #tests }
CIConfigurationExemple >> exampleGroup [
	| collection arguments  |
	collection := OrderedCollection new.
	collection add: 'config'.
	collection add: 'http://smalltalkhub.com/mc/PharoExtras/Pastell/main'.	
	collection add: 'ConfigurationOfPastell'.
	collection add: '--group=Tests'.

	arguments := CommandLineArguments withArguments: collection.
	CICommandLineHandler activateWith: arguments.
]

{ #category : #tests }
CIConfigurationExemple >> exampleVersion [
	| collection arguments |
	collection := OrderedCollection new.
	collection add: 'config'.
	collection add: 'http://smalltalkhub.com/mc/PharoExtras/Pastell/main'.
	collection add: 'ConfigurationOfPastell'.
	collection add: '--version=1.3'.
	
	arguments := CommandLineArguments withArguments: collection.
	CICommandLineHandler activateWith: arguments
]

{ #category : #tests }
CIConfigurationExemple >> exampleVersionGroup [
	| collection arguments  |
	collection := OrderedCollection new.
	collection add: 'config'.
	collection add: 'http://smalltalkhub.com/mc/PharoExtras/Pastell/main'.	
	collection add: 'ConfigurationOfPastell'.
	collection add: '--version=1.3'.
	"collection add: '--version=1.2'. should not work because there is no Tests package in 1.2"
	collection add: '--group=Tests'.

	arguments := CommandLineArguments withArguments: collection.
	CICommandLineHandler activateWith: arguments.
]
