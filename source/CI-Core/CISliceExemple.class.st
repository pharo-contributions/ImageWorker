"
Read methods, its contain exemples
"
Class {
	#name : #CISliceExemple,
	#superclass : #Object,
	#category : #'CI-Core-Test'
}

{ #category : #tests }
CISliceExemple >> exampleDefault [
	| collection arguments  |
	collection := OrderedCollection new.
	collection add: 'ci'.
	collection add: 'slice'.	
	collection add: 'test'.
	collection add: '--issue=10661'.
	
	arguments := CommandLineArguments withArguments: collection.
	CICommandLineHandler activateWith: arguments.
]
