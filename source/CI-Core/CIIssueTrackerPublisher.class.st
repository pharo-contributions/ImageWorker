"
I publish change results on an issue tracker.

"
Class {
	#name : #CIIssueTrackerPublisher,
	#superclass : #CIAbstractPublisher,
	#category : #'CI-Core-Publishing'
}

{ #category : #publishing }
CIIssueTrackerPublisher >> publishBeforeValidation: aCIChange [
	"lock the issue"
	aCIChange lockForValidation
]

{ #category : #publishing }
CIIssueTrackerPublisher >> publishChangeNotFound: aChange [
	aChange workNeededNoSources
]

{ #category : #publishing }
CIIssueTrackerPublisher >> publishFailure: aCIValidationResult [
	^ self 
		publishFailure: aCIValidationResult
		message: aCIValidationResult asString
]

{ #category : #publishing }
CIIssueTrackerPublisher >> publishFailure: aCIValidationResult message: aMessage [
	| hasTestFailures change |
	
	change := aCIValidationResult change.
	
	self flag: 'stupid test for now'.
	hasTestFailures := aCIValidationResult errors anySatisfy: [ :failure | 
		failure asString includesSubstring: '>>#test' ].
	
	hasTestFailures
		ifTrue: [ change workNeededFailingTests: aMessage ]
		ifFalse: [ change workNeeded: aMessage ]
]

{ #category : #publishing }
CIIssueTrackerPublisher >> publishSuccess: aCIValidationResult [

	^ self 
		publishSuccess: aCIValidationResult
		message: aCIValidationResult asString
]

{ #category : #publishing }
CIIssueTrackerPublisher >> publishSuccess: aCIValidationResult message: aString [
	| change |
	
	change := aCIValidationResult change.
	
	change 
		fixReviewed: aString
		in: SystemVersion current highestUpdate
]

{ #category : #publishing }
CIIssueTrackerPublisher >> publishValidationResult: aCIValidationResult [

	^ self 
		publishValidationResult: aCIValidationResult
		message: aCIValidationResult asString
]

{ #category : #publishing }
CIIssueTrackerPublisher >> publishValidationResult: aCIValidationResult message: aString [

	aCIValidationResult	isSuccess 
		ifTrue: [ self publishSuccess: aCIValidationResult message: aString ]
		ifFalse: [ self publishFailure: aCIValidationResult message: aString ]
]
