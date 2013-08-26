"
I am a representation of an issue tracker case mainly used to define protocol methods
"
Class {
	#name : #CISliceChange,
	#superclass : #CIAbstractChange,
	#instVars : [
		'case',
		'slice'
	],
	#category : #'CI-Core'
}

{ #category : #'instance creation' }
CISliceChange class >> source: aCISource case: aTrackerCase [
	^ (self source: aCISource)  case: aTrackerCase;yourself 
]

{ #category : #protocol }
CISliceChange >> basicLoad [	
	"testing problems in CIChangeSliceValidationRule"
	self slice merge
]

{ #category : #accessing }
CISliceChange >> case [
	^ case
]

{ #category : #accessing }
CISliceChange >> case: anObject [
	case := anObject
]

{ #category : #testing }
CISliceChange >> changeValidationRule [

	 ^ CIChangeSliceValidationRule 
]

{ #category : #updating }
CISliceChange >> fixReviewed: aMessage in: pharoReleaseNumber [
	self case 
		statusFixReviewed; 
		saveStatus: aMessage withInternetLineEndings.
	
	self case 
		tags add: 'Validated in ', pharoReleaseNumber asString.
	self case	saveTags
]

{ #category : #accessing }
CISliceChange >> id [ 
	 ^ case id
]

{ #category : #testing }
CISliceChange >> isLoadable [
	^ self slice isNotNil
]

{ #category : #accessing }
CISliceChange >> loadSlice [
	^ slice := self source sliceFor: self case
]

{ #category : #updating }
CISliceChange >> lockForValidation [
	^ self case 
		statusMonkeyIsChecking; 
		saveStatus
]

{ #category : #accessing }
CISliceChange >> name [
	^ self case title
]

{ #category : #printing }
CISliceChange >> printOn: aStream [
	aStream nextPutAll: 'SLICE '; print: self id; space.
	aStream nextPutAll: self slice url 
]

{ #category : #protocol }
CISliceChange >> publicUrl [
	^ self case publicUrl 
]

{ #category : #accessing }
CISliceChange >> slice [
	^ slice ifNil: [ self loadSlice ]
]

{ #category : #updating }
CISliceChange >> workNeeded: aMessage [
	^ self case 
		statusWorkNeeded; 
		saveStatus: aMessage
]

{ #category : #updating }
CISliceChange >> workNeededFailingTests: message [
	^ self case 
		statusWorkNeededFailingTests; 
		saveStatus: message
]

{ #category : #updating }
CISliceChange >> workNeededNoSources [
	^ self case 
		statusWorkNeededNoSources; 
		saveStatus
]
