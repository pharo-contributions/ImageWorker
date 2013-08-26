"
I am a change object used for testing purposes.
All my properties can be set from the outside.

CITestChange loadBlock: [ ^ true ]

Many examples in CI-Core-Tests
"
Class {
	#name : #CITestChange,
	#superclass : #CIAbstractChange,
	#instVars : [
		'id',
		'isLoadable',
		'loadBlock',
		'name',
		'publicUrl'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
CITestChange class >> loadBlock: aBlock [

	^ self new
		loadBlock: aBlock;
		yourself.
]

{ #category : #protocol }
CITestChange >> basicLoad [
	^ self loadBlock ifNotNil: [ self loadBlock value ]
]

{ #category : #testing }
CITestChange >> changeValidationRule [

	^ self shouldBeImplemented 
]

{ #category : #accessing }
CITestChange >> id [
	^ id
]

{ #category : #accessing }
CITestChange >> id: anObject [
	id := anObject
]

{ #category : #initialize }
CITestChange >> initialize [

	isLoadable := true.
]

{ #category : #accessing }
CITestChange >> isLoadable [
	^ isLoadable
]

{ #category : #accessing }
CITestChange >> isLoadable: aBoolean [
	isLoadable := aBoolean
]

{ #category : #accessing }
CITestChange >> loadBlock [
	^ loadBlock
]

{ #category : #accessing }
CITestChange >> loadBlock: aBlock [
	loadBlock := aBlock
]

{ #category : #accessing }
CITestChange >> name [
	^ name ifNil: [ 'TestChange:', self loadBlock asString ]
]

{ #category : #accessing }
CITestChange >> name: anObject [
	name := anObject
]

{ #category : #accessing }
CITestChange >> publicUrl [
	^ publicUrl
]

{ #category : #accessing }
CITestChange >> publicUrl: anObject [
	publicUrl := anObject
]
