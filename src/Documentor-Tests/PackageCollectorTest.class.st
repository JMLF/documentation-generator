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
