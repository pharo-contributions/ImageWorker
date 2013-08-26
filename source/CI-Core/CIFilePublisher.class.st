"
I am an abstract publisher for file-based output formats.
"
Class {
	#name : #CIFilePublisher,
	#superclass : #CIAbstractPublisher,
	#instVars : [
		'outputDirectory',
		'stream',
		'fileName'
	],
	#category : #'CI-Core-Publishing'
}

{ #category : #publishing }
CIFilePublisher class >> publish: aCIValidationResult to: aFileName [
	^ self new
		fileName: aFileName;
		publishValidationResult: aCIValidationResult;
		yourself
]

{ #category : #accessing }
CIFilePublisher >> fileName [
	^ fileName
]

{ #category : #accessing }
CIFilePublisher >> fileName: aFileName [
	fileName := aFileName
]

{ #category : #'initialize-release' }
CIFilePublisher >> initialize [
	super initialize.
	self outputDirectory: FileSystem disk workingDirectory.
]

{ #category : #accessing }
CIFilePublisher >> outputDirectory [
	^ outputDirectory
]

{ #category : #accessing }
CIFilePublisher >> outputDirectory: anObject [
	outputDirectory := anObject
]

{ #category : #publishing }
CIFilePublisher >> publishBeforeValidation: aCIChange [
	"ingnored"
]

{ #category : #publishing }
CIFilePublisher >> publishChangeNotFound: aCIChange [
	"ingnored"
]

{ #category : #accessing }
CIFilePublisher >> stream [
	^ stream
]

{ #category : #accessing }
CIFilePublisher >> stream: anObject [
	stream := anObject
]

{ #category : #accessing }
CIFilePublisher >> updateFileName: aCIValidationResult [
	fileName ifNil: [ 
		fileName := aCIValidationResult change name asString ]
]
