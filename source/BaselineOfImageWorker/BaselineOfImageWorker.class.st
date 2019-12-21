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
			commandShell: spec;
			fuelMetalevel: spec.
			
		spec
			package: 'ImageWorker' with: [ 
				spec requires: #('CommandShell' 'Fuel')].
			
		spec
			group: 'default' with: #('ImageWorker') ].
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
			repository: 'github://theseion/Fuel:3.0.1/repository';
			loads: #( 'Fuel-Metalevel' ) ]
]
