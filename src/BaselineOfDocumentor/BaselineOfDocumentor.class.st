Class {
	#name : 'BaselineOfDocumentor',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfDocumentor',
	#package : 'BaselineOfDocumentor'
}

{ #category : 'baselines' }
BaselineOfDocumentor >> baseline: spec [

	<baseline>

	spec
		package: 'Documentor-Core';
		package: 'Documentor-Tests'
		with: [ spec requires: #( 'Documentor-Core' ) ]
]
