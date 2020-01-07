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
			osProcess: spec;
			fuelMetalevel: spec.
			
		spec
			package: 'ImageWorker' with: [ 
				spec requires: #('OSProcess' 'Fuel')].
			
		spec
			group: 'default' with: #('ImageWorker') ].
]

{ #category : #baselines }
BaselineOfImageWorker >> fuelMetalevel: spec [
	spec
		baseline: 'Fuel'
		with: [
			spec
				repository: 'github://theseion/Fuel:3.0.1/repository';
				loads: #('Fuel-Metalevel') ]
]

{ #category : #'external projects' }
BaselineOfImageWorker >> osProcess: spec [
	spec
		baseline: 'OSProcess'
		with: [ spec repository: 'github://dtlewis290/OSProcess-Tonel:56030885fad6b924572260d92f9904df8bb6b502/src' ]
]
