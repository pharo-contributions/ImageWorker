"
I am CI source used in tests. 
I generate changes by delegating to a Block.
"
Class {
	#name : #CITestChangeProvider,
	#superclass : #CIAbstractChangeProvider,
	#instVars : [
		'changeBlock'
	],
	#category : #'CI-Core'
}

{ #category : #accessing }
CITestChangeProvider >> changeBlock [
	^ changeBlock
]

{ #category : #accessing }
CITestChangeProvider >> changeBlock: anObject [
	changeBlock := anObject
]

{ #category : #protocol }
CITestChangeProvider >> changeWithId: anId [
	^ changeBlock cull: anId
]
