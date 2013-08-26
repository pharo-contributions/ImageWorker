Class {
	#name : #CIXMLPublisherTest,
	#superclass : #CIPublisherTest,
	#category : #'CI-Core-Test'
}

{ #category : #accessing }
CIXMLPublisherTest >> defaultContent [

	^ '<?xml version="1.0" encoding="UTF-8"?>
<!--Pharo CI report-->
<report>
    <name>TestEntity - report</name>
    <finality>succeed</finality>
</report>'
]

{ #category : #accessing }
CIXMLPublisherTest >> publisherClass [
	^ CIXMLPublisher 
]

{ #category : #tests }
CIXMLPublisherTest >> testContents [
	| file path directory |
	
	directory := FileSystem memory.
	file := (self publisherClass new) 
		outputDirectory: directory;
		publishValidationResult: (CIValidationResult change: (CITestChange new name: 'TestEntity')).
	path := file outputDirectory / 'TestEntity', 'xml'.
	
	self assert: (directory exists: path ) description: 'Testing the creation of xml file'.
	self assert: path readStream contents asString equals: self defaultContent.
]

{ #category : #tests }
CIXMLPublisherTest >> testEntity [
	| file directory path |
	
	directory := FileSystem memory.
	file := (self publisherClass new) 
		outputDirectory: directory;
		publishValidationResult: (CIValidationResult change: (CITestChange new name: 'TestEntity')).
	path := file outputDirectory / 'TestEntity', 'xml'.
	
	self assert: (directory exists: path ) description: 'Testing the creation of the xml file'.
]
