Class {
	#name : #ConfigurationOfImageWorker,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfImageWorker
}

{ #category : #private }
ConfigurationOfImageWorker class >> ensureMetacello [
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

{ #category : #'metacello tool support' }
ConfigurationOfImageWorker class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfImageWorker class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfImageWorker class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfImageWorker class >> loadDefault [
	self load
]

{ #category : #loading }
ConfigurationOfImageWorker class >> loadDevelopment [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfImageWorker class >> project [

	^self new project
]

{ #category : #'unloading Metacello' }
ConfigurationOfImageWorker class >> unloadMetacello [

	Smalltalk at: #ConfigurationOfMetacello ifPresent: [:cls | cls unloadMetacello ]
]

{ #category : #'development support' }
ConfigurationOfImageWorker class >> validate [
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
ConfigurationOfImageWorker >> baseline101: spec [
	<version: '1.01-baseline'>

	spec for: #pharo do: [	
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/PharoExtras/ImageWorker/main'.
		
		self 
			seamless: spec;
			fuelMetalevel: spec;
			commandShell: spec.
			
		spec
			package: 'ImageWorker' with: [ 
				spec requires: #('CommandShell')].
			
		spec 
			group: 'default' with: #('ImageWorker');
			group: 'full'    with: #('ImageWorker')].
]

{ #category : #baselines }
ConfigurationOfImageWorker >> baselineDevelopment: spec [
	<version: 'development-baseline'>


	spec for: #pharo do: [	
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/PharoExtras/ImageWorker/main'.
		
		self
			fuelMetalevel: spec;
			osProcess: spec.
			
		spec
			package: 'ImageWorker' with: [ 
				spec requires: #('OSProcess')].
			
		spec 
			group: 'default' with: #('ImageWorker');
			group: 'full'    with: #('ImageWorker')].
]

{ #category : #'symbolic versions' }
ConfigurationOfImageWorker >> bleedingEdge: spec [  
	<symbolicVersion: #bleedingEdge >
	
	spec for: #common version: 'devBleedingEdge'.
]

{ #category : #'external projects' }
ConfigurationOfImageWorker >> commandShell: spec [
	spec project: 'CommandShell' with: [
		spec
			repository: 'http://www.squeaksource.com/MetacelloRepository';
			className: 'ConfigurationOfCommandShell';
			version: #stable ].
]

{ #category : #'symbolic versions' }
ConfigurationOfImageWorker >> development: spec [
	<symbolicVersion: #development >
	
	spec for: #'common' version: 'dev'.

]

{ #category : #'external projects' }
ConfigurationOfImageWorker >> fuelMetalevel: spec [

	"Dependencies"
	spec project: 'Fuel' with: [
		spec 
			repository: 'http://smalltalkhub.com/Pharo/Fuel/main';
			className: 'ConfigurationOfFuel'].
]

{ #category : #'external projects' }
ConfigurationOfImageWorker >> osProcess: spec [
	spec project: 'OSProcess' with: [
		spec
			repository: 'http://www.squeaksource.com/MetacelloRepository';
			className: 'ConfigurationOfOSProcess';
			version: #stable ].
]

{ #category : #accessing }
ConfigurationOfImageWorker >> project [

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
ConfigurationOfImageWorker >> seamless: spec [
	
	"Dependencies"
		spec
			repository: 'http://ss3.gemtalksystems.com/ss/Seamless';
			package:  'Seamless'  .
]

{ #category : #'symbolic versions' }
ConfigurationOfImageWorker >> stable: spec [
	<symbolicVersion: #stable >
	
	spec for: #'common' version: '1.01'.

]

{ #category : #versions }
ConfigurationOfImageWorker >> version101: spec [
	<version: '1.01' imports: #('1.01-baseline')>

	spec for: #pharo do: [	
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/PharoExtras/ImageWorker/main'.
	
		"
		ErwanDouaille
		CamilloBruni"
		spec
			package:  'ImageWorker' with: 'ImageWorker-CamilloBruni.13' ].
]

{ #category : #versions }
ConfigurationOfImageWorker >> versionDevelopment: spec [
	<version: 'dev' imports: #('development-baseline')>

	spec for: #pharo do: [	
		spec blessing: #development.
		spec repository: 'http://smalltalkhub.com/mc/PharoExtras/ImageWorker/main'.
	
		"
		ErwanDouaille
		CamilloBruni"
		spec
			package:  'ImageWorker' with: 'ImageWorker-CamilloBruni.13' ].
]

{ #category : #versions }
ConfigurationOfImageWorker >> versionDevelopmentBleedingEdge: spec [
	<version: 'devBleedingEdge' imports: #('development-baseline')>
]
