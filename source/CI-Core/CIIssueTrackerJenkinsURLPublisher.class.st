"
CIIssueTrackerJenkinsURLPublisher is responsible to post a link to a jenkins report.

STILL UNDER CONSTRUCTION
"
Class {
	#name : #CIIssueTrackerJenkinsURLPublisher,
	#superclass : #CIIssueTrackerPublisher,
	#category : #'CI-Core-Publishing'
}

{ #category : #publishing }
CIIssueTrackerJenkinsURLPublisher >> buildMessage: aCIValidationResult [
	^ String streamContents: [ :str | 
		aCIValidationResult isSuccess
			ifTrue: [ str nextPutAll: 'Issue Validation Succeeded: ' ]
			ifFalse: [ str nextPutAll: 'Issue Validation Failed: ' ].
		str nextPutAll: self reportUrl ]
]

{ #category : #accessing }
CIIssueTrackerJenkinsURLPublisher >> fileName [
	^ 'validationReport'
]

{ #category : #accessing }
CIIssueTrackerJenkinsURLPublisher >> id [
	^ Smalltalk os environment at: 'BUILD_ID'
]

{ #category : #accessing }
CIIssueTrackerJenkinsURLPublisher >> name [
	^ Smalltalk os environment at: 'JOB_NAME'
]

{ #category : #accessing }
CIIssueTrackerJenkinsURLPublisher >> number [
	^ Smalltalk os environemnt at: 'BUILD_NUMBER'
]

{ #category : #publishing }
CIIssueTrackerJenkinsURLPublisher >> publishHTMLResult: aCIValidationResult [
	CIHTMLPublisher publish: aCIValidationResult to: self fileName
]

{ #category : #publishing }
CIIssueTrackerJenkinsURLPublisher >> publishValidationResult: aCIValidationResult [

	self publishHTMLResult: aCIValidationResult.
	
	super 
		publishValidationResult: aCIValidationResult
		message: (self buildMessage: aCIValidationResult)
]

{ #category : #accessing }
CIIssueTrackerJenkinsURLPublisher >> reportUrl [
	^ self url, '/artifact/', self fileName, '.html'.
]

{ #category : #accessing }
CIIssueTrackerJenkinsURLPublisher >> url [
	^ Smalltalk os environment at: 'BUILD_URL'
]
