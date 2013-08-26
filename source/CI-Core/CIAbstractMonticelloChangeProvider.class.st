"
I am an abstract change source with a minimal interface for a gofer and monticello.
"
Class {
	#name : #CIAbstractMonticelloChangeProvider,
	#superclass : #CIAbstractChangeProvider,
	#instVars : [
		'url'
	],
	#category : #'CI-Core'
}

{ #category : #accessing }
CIAbstractMonticelloChangeProvider >> gofer [
	^ Gofer new 
		url: self url;
		yourself
]

{ #category : #accessing }
CIAbstractMonticelloChangeProvider >> url [
	^ url
]

{ #category : #accessing }
CIAbstractMonticelloChangeProvider >> url: aUrl [
	url := aUrl
]
