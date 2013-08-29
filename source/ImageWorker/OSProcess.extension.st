Extension { #name : #OSProcess }

{ #category : #'*ImageWorker' }
OSProcess classSide >> osVersion [
	"After Squeak version 3.6, #osVersion was moved to SmalltalkImage. Some
	versions of Pharo move this to OSPlatform and issue deprecation warnings
	about the other usages."

	"self osVersion"

	^ Smalltalk os version
]

{ #category : #'*ImageWorker' }
OSProcess classSide >> platformName [ 
	"After Squeak version 3.6, #platformName was moved to SmalltalkImage Some
	versions of Pharo move this to OSPlatform and issue deprecation warnings
	about the other usages."

	"self platformName"

	^ Smalltalk os platformName
]

{ #category : #'*ImageWorker' }
OSProcess classSide >> vmVersion [ 
	"After Squeak version 3.6, #vmVersion was moved to SmalltalkImage "

	^ Smalltalk vm version
]
