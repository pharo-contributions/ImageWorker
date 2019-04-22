Class {
	#name : #BaselineOfImageWorker,
	#superclass : #BaselineOf,
	#category : #BaselineOfImageWorker
}

{ #category : #baselines }
BaselineOfImageWorker >> baseline: spec [
	<baseline>

	spec for: #pharo do: [			
		self 
			seamless: spec;
			commandShell: spec;
			fuelMetalevel: spec.
			
		spec
			package: 'ImageWorker' with: [ 
				spec requires: #('CommandShell' 'Fuel')].
			
		spec 
			group: 'default' with: #('ImageWorker');
			group: 'full'    with: #('ImageWorker')].
]

{ #category : #'external projects' }
BaselineOfImageWorker >> commandShell: spec [
	spec project: 'CommandShell' with: [
		spec
			repository: 'http://www.squeaksource.com/MetacelloRepository';
			className: 'ConfigurationOfCommandShell';
			version: #stable ].
]

{ #category : #baselines }
BaselineOfImageWorker >> fuelMetalevel: spec [
	spec baseline: 'Fuel' with: [ 
		spec 
			repository: 'github://theseion/Fuel/repository';
			loads: #( 'Fuel-Metalevel' ) ]
]

{ #category : #'external projects' }
BaselineOfImageWorker >> osProcess: spec [
	spec project: 'OSProcess' with: [
		spec
			repository: 'http://www.squeaksource.com/MetacelloRepository';
			className: 'ConfigurationOfOSProcess';
			version: #stable ].
]

{ #category : #'external projects' }
BaselineOfImageWorker >> seamless: spec [
	
	"Dependencies"
		spec
			repository: 'http://ss3.gemtalksystems.com/ss/Seamless';
			package:  'Seamless'  .
]
