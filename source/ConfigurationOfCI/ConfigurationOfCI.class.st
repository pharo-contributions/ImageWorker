"
I gather all information to load the sources for the Pharo Continous Integration services.

Usage:
	ConfigurationOfCI loadStable
"
Class {
	#name : #ConfigurationOfCI,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfCI
}

{ #category : #'development support' }
ConfigurationOfCI class >> DevelopmentProcess [

"DEVELOPMENT Process
	- load current version:
	  	(self project version: #stable) load: 'ALL'.
	- open new version for development:
		self createNewDevelopmentVersion
	- do development and periodically save mcz files and configuration until ready for release
		self saveModifiedPackagesAndConfiguration: '- fixed a bug'
	- update the the development version to match mcz file versions
		self updateToLatestPackageVersions: '- fixed a bug'
	- save configuration
		self saveConfiguration: '- checkpoint configuration'
RELEASE Process
	- mark development version as release:
		self releaseDevelopmentVersion: '- release'
"
	<apiDocumentation>
]

{ #category : #private }
ConfigurationOfCI class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #'development support' }
ConfigurationOfCI class >> commit: commitMessage [
	"Release #development version: set version blessing to #release, update the #development and #stable symbolic version methods and save the configuration."

	"self releaseDevelopmentVersion: '- release version 1.0.2'"

	<apiDocumentation>
	self ensureMetacello.
	self updateConfiguration.
	self createNewDevelopmentVersion.
	self updateToLatestPackageVersions: commitMessage.
	self saveModifiedPackagesAndConfiguration: commitMessage.
	self loadDevelopment.
	self saveConfiguration: commitMessage.
]

{ #category : #'development support' }
ConfigurationOfCI class >> compareVersions [
	"Compare the #stable version to #development version"

	"self compareVersions"

	<apiDocumentation>
	self ensureMetacello.
	((Smalltalk at: #MetacelloToolBox) compareVersionsIn: self) inspect

]

{ #category : #'development support' }
ConfigurationOfCI class >> createNewBaselineVersion [
	"Create a new baseline version based upon the #stable version's baseline.
	 A new baseline should be created if new packages have been added or package dependencies have changed."

	"self createNewDevelopmentVersion"

	<apiDocumentation>
	self ensureMetacello.
	(Smalltalk at: #MetacelloToolBox) createNewBaselineVersionIn: self description: ''

]

{ #category : #'development support' }
ConfigurationOfCI class >> createNewDevelopmentVersion [
	"Create a new development version using the #stable version as model."

	"self createNewDevelopmentVersion"

	<apiDocumentation>
	self ensureMetacello.
	(Smalltalk at: #MetacelloToolBox) createNewDevelopmentVersionIn: self description: ''
]

{ #category : #private }
ConfigurationOfCI class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.15"
			self bootstrapPackage: 'Gofer-lr.83' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load latest version of Metacello, load a specific version if desired"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #loadLatestVersion ]
]

{ #category : #private }
ConfigurationOfCI class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfCI class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfCI class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfCI class >> loadDefault [
	self load
]

{ #category : #loading }
ConfigurationOfCI class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfCI class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfCI class >> releaseDevelopmentVersion: commitMessage [
	"Release #development version: set version blessing to #release, update the #development and #stable symbolic version methods and save the configuration."

	"self releaseDevelopmentVersion: '- release version 1.0.2'"

	<apiDocumentation>
	self ensureMetacello.
	self updateConfiguration.
	self loadDevelopment.
	self createNewDevelopmentVersion.
	(Smalltalk at: #MetacelloToolBox) releaseDevelopmentVersionIn: self description: commitMessage
]

{ #category : #'development support' }
ConfigurationOfCI class >> saveConfiguration: commitMessage [
	"Save mcz file that contains the configuration to it's repository."

	"self saveConfiguration: '- fixed bug'"

	<apiDocumentation>
	self ensureMetacello.
	(Smalltalk at: #MetacelloToolBox) saveConfigurationPackageFor: self name asString description: commitMessage
]

{ #category : #'development support' }
ConfigurationOfCI class >> saveModifiedPackagesAndConfiguration: commitMessage [
	"Save modified mcz files, update the #development version and then save the configuration."

	"self saveModifiedPackagesAndConfiguration: '- fixed bug'"

	<apiDocumentation>
	self ensureMetacello.
	self updateConfiguration.
	(Smalltalk at: #MetacelloToolBox) saveModifiedPackagesAndConfigurationIn: self description: commitMessage
]

{ #category : #'development support' }
ConfigurationOfCI class >> updateConfiguration [
	[[[ 
		(Smalltalk at: #Gofer) new
			package: self name;
			merge ] 	
			on: (Smalltalk at: #MCMergeOrLoadWarning ifAbsent: [ nil ]) 		do: [ :e| e resume: false ]] 		
			on: (Smalltalk at: #MCNoChangesException ifAbsent: [ nil ]) 		do: [ :e| e resume]] 
			on: (Smalltalk at: #MCMergeResolutionRequest ifAbsent: [ nil ]) 	do: [ :request |
																						request merger conflicts isEmpty
																							ifTrue: [ request resume: true ]
																							ifFalse: [ request pass ]].
]

{ #category : #'development support' }
ConfigurationOfCI class >> updateToLatestPackageVersions: descriptionString [
	"Update the #development version to match currently loaded mcz files."

	"self updateToLatestPackageVersions: '- fixed a bug'"

	<apiDocumentation>
	self ensureMetacello.
	((Smalltalk at: #MetacelloToolBox) updateToLatestPackageVersionsIn: self description: descriptionString) isEmpty
		ifTrue: [ self inform: 'All specs up to date' ]
]

{ #category : #'development support' }
ConfigurationOfCI class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfCI >> baseline106: spec [
	<version: '1.06-baseline'>

	spec for: #pharo do: [	
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/Pharo/ci/main'.
	
		self 
			soup: spec;
			fileSystemLegacy: spec;
			commandShell: spec.
				
		spec
			package:  'CI-Core';
			package: 'CI-Integration' with: [ 
				spec requires: #('Soup' 'CI-Core' 'FileSystem-Legacy' 'CommandShell')];
			package: 'CI-Loader' with: [ 
				spec requires: #('Soup' 'CI-Core')].
			
		spec 
			group: 'default' with: #('CI-Core');
			group: 'full' with: #('CI-Integration' 'CI-Loader');
			group: 'soup' with: #('Soup') "for laziliy loading the Soup packages"]
]

{ #category : #baselines }
ConfigurationOfCI >> baselineDev: spec [
	<version: 'dev-baseline'>

	spec for: #pharo do: [	
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/Pharo/ci/main'.
	
		self soup: spec;
			fileSystemLegacy: spec;
			commandShell: spec;
			zinc: spec;
			xmlWriter: spec;
			imageWorker: spec.
				
		spec
			package: 'CI-Core' with: [ 
				spec requires: #( 'FileSystem-Legacy' 'CommandShell' 'XMLWriter' 'ImageWorker')];
			package: 'CI-FogBugzAPI' with: [ 
				spec requires: #('CI-Core')];
			package: 'CI-GoogleIssueTracker' with: [
				spec requires: #('CI-Core')];
			package: 'CI-Integration' with: [ 
				spec requires: #('CI-Core' 'CI-FogBugzAPI' 'Soup' 'CommandShell')];
			package: 'CI-Loader' with: [ 
				spec requires: #('Soup' 'CI-Core')].
			
		spec 
			group: 'default' with: #('CI-Core' 'CI-Integration' 'CI-Loader');
			group: 'core'    with: #('CI-Core') ]
]

{ #category : #'symbolic versions' }
ConfigurationOfCI >> bleedingEdge: spec [  
	<symbolicVersion: #bleedingEdge >
	
	spec for: #common version: 'devBleedingEdge'.
]

{ #category : #'external projects' }
ConfigurationOfCI >> commandShell: spec [
	spec project: 'CommandShell' with: [
		spec
			repository: 'http://www.squeaksource.com/MetacelloRepository';
			className: 'ConfigurationOfCommandShell';
			version: #stable ].
]

{ #category : #'symbolic versions' }
ConfigurationOfCI >> development: spec [
	<symbolicVersion: #development >
	
	spec for: #'common' version: 'dev'.

]

{ #category : #'external projects' }
ConfigurationOfCI >> fileSystemLegacy: spec. [
		
	spec package: 'FileSystem-Legacy' with: [
		spec repository: 'http://smalltalkhub.com/mc/PharoExtras/FileSystemLegacy/main' ].
]

{ #category : #'external projects' }
ConfigurationOfCI >> imageWorker: spec [
	
	spec project: 'ImageWorker' with: [
		spec repository: 'http://smalltalkhub.com/mc/PharoExtras/ImageWorker/main';
			className: 'ConfigurationOfImageWorker'].
]

{ #category : #project }
ConfigurationOfCI >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear.
		project ]
]

{ #category : #'external projects' }
ConfigurationOfCI >> soup: spec [

	"Dependencies"
	spec project: 'Soup' with: [
		spec
			repository: 'http://www.squeaksource.com/Soup';
			className: 'ConfigurationOfSoup'].
]

{ #category : #'symbolic versions' }
ConfigurationOfCI >> stable: spec [
	<symbolicVersion: #stable >
	
	spec for: #'common' version: '1.20'.

]

{ #category : #versions }
ConfigurationOfCI >> version120: spec [
	<version: '1.20' imports: #('1.06-baseline')>

	spec for: #'common' do: [
		spec 
			description: 'command line handler';
			author: 'CamilloBruni';
			timestamp: '1/28/2013 17:55'.
		
		spec 
			project: 'Soup'              with: '1.2';
			package: 'FileSystem-Legacy' with: 'FileSystem-Legacy-CamilloBruni.1';
			package: 'CI-Core'           with: 'CI-Core-CamilloBruni.57';
			package: 'CI-Integration'    with: 'CI-Integration-CamilloBruni.32';
			package: 'CI-Loader'         with: 'CI-Loader-CamilloBruni.6' ].
]

{ #category : #versions }
ConfigurationOfCI >> versionDevelopment: spec [
	<version: 'dev' imports: #('dev-baseline')>

	spec for: #'common' do: [
		spec timestamp: 'CamilloBruni 2013-08-26'.
		
		self versionDevelopmentExternal: spec. 
		spec 
			"ErwanDouaille CamilloBruni"
			package: 'CI-Core'               with: 'CI-Core-CamilloBruni.348';
			package: 'CI-FogBugzAPI'         with: 'CI-FogBugzAPI-CamilloBruni.39';
			package: 'CI-Integration'        with: 'CI-Integration-CamilloBruni.66';
			package: 'CI-Loader'             with: 'CI-Loader-CamilloBruni.6';
			package: 'CI-GoogleIssueTracker' with: 'CI-GoogleIssueTracker-CamilloBruni.2' ].

]

{ #category : #versions }
ConfigurationOfCI >> versionDevelopmentBleedingEdge: spec [
	<version: 'devBleedingEdge' imports: #('dev-baseline')>

	spec for: #'common' do: [
		self versionDevelopmentExternal: spec.  ].

]

{ #category : #versions }
ConfigurationOfCI >> versionDevelopmentExternal: spec [
	spec 
		project: 'Soup'          with: '1.2';
		project: 'CommandShell'  with: '1.1';
		project: 'XMLWriter'     with: #stable;
		project: 'ImageWorker'   with: #stable.
	
]

{ #category : #'external projects' }
ConfigurationOfCI >> xmlWriter: spec [

	"Dependencies"
	spec project: 'XMLWriter' with: [
		spec 
			repository: 'http://smalltalkhub.com/PharoExtras/XMLWriter/main';
			className: 'ConfigurationOfXMLWriter'].
]

{ #category : #'external projects' }
ConfigurationOfCI >> zinc: spec [

	"Dependencies"
	spec project: 'Zinc' with: [
		spec 
			repository: 'http://www.squeaksource.com/ZincHTTPComponents';
			className: 'ConfigurationOfZincHTTPComponents' ].
]
