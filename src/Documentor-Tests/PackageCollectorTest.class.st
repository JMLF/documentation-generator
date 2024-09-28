Class {
	#name : 'PackageCollectorTest',
	#superclass : 'TestCase',
	#category : 'Documentor-Tests',
	#package : 'Documentor-Tests'
}

{ #category : 'tests' }
PackageCollectorTest >> testCollectClasses [
    | resultClasses pc matrixClasses resultClassesName |
    matrixClasses := (OrderedCollection new) add: #AbstractMatrix; add: #Matrix; add: #MatrixElement; add: #SparseMatrix.
	resultClassesName := OrderedCollection new. 
	pc := PackageCollector named: 'Matrix-Core'.
	resultClasses := pc collectClasses.
	
	self assert: resultClasses isNotEmpty.
	resultClasses do: [:class | resultClassesName add: class name.  ] .
	self assert: ( resultClassesName includes: matrixClasses )  .

]

{ #category : 'tests' }
PackageCollectorTest >> testCollectInstanceVar [

	| pc packageClasses classInstVars |
	pc := PackageCollector named: 'Matrix-Core'.
	packageClasses := pc collectClasses.

	classInstVars := pc collectInstanceVariablesFor:
		                 (packageClasses select: [ :class |
			                  class name = #MatrixElement ]) first.

	self assert: classInstVars isNotEmpty.
	self assert: classInstVars equals: #( #row #column #value )
]
