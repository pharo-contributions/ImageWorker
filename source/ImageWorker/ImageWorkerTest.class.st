Class {
	#name : #ImageWorkerTest,
	#superclass : #TestCase,
	#category : #ImageWorker
}

{ #category : #helper }
ImageWorkerTest >> do: aBlock [
	| imageWorker |
	imageWorker := ImageWorker new.
	imageWorker block: aBlock.
	
	^ [[ imageWorker value ]
		ensure: [ imageWorker cleanUp ]] 
			valueWithin: 10 seconds 
			onTimeout: [ 
				imageWorker cleanUp.
				Error signal: 'Timeout: Image worker took longer than 10 seconds to complete' ]
]

{ #category : #tests }
ImageWorkerTest >> testError [
	self 
		should: [ self do: [ 1/0 ]]
		raise: ZeroDivide
]

{ #category : #tests }
ImageWorkerTest >> testReturnArray [
	self assert: (self do: [ {1. 2. 3. 4} ]) equals: {1. 2. 3. 4}.
]

{ #category : #tests }
ImageWorkerTest >> testReturnClass [
	self assert: (self do: [ Class ]) equals: Class.
]

{ #category : #tests }
ImageWorkerTest >> testReturnFloat [
	self assert: (self do: [1.5]) equals: 1.5.
]

{ #category : #tests }
ImageWorkerTest >> testReturnInteger [
	self assert: (self do: [1]) equals: 1.
]

{ #category : #tests }
ImageWorkerTest >> testReturnNewClass [
	| newClass className |
	className := #'ImageWorkerTest_newclass'.
	newClass := self do: [ Object subclass: className ].
	self assert: newClass name equals: className.
	self deny: (Smalltalk includesKey: className)
]

{ #category : #tests }
ImageWorkerTest >> testReturnString [
	self assert: (self do: ['1.5']) equals: '1.5'.
]

{ #category : #tests }
ImageWorkerTest >> testReturnSymbol [
	self assert: (self do: [#'1.5']) equals: #'1.5'.
]
