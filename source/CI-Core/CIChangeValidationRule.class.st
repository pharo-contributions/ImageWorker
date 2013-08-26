"
A CIChangeValidationRule is an abstract which provide default behavior to test if changes are properly defined
"
Class {
	#name : #CIChangeValidationRule,
	#superclass : #CIAbstractValidationRule,
	#category : #'CI-Core-Validation'
}

{ #category : #accessing }
CIChangeValidationRule >> source [ 
	^ self change source
]

{ #category : #tests }
CIChangeValidationRule >> testIsLoadable [
 	^ self subclassResponsibility 
]
