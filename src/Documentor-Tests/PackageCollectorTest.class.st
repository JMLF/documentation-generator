Class {
	#name : 'PackageCollectorTest',
	#superclass : 'TestCase',
	#category : 'Documentor-Tests',
	#package : 'Documentor-Tests'
}

{ #category : 'tests' }
PackageCollectorTest >> testCollectClasseMethods [

	| pc packageClasses classMethods |
	pc := PackageCollector named: 'Matrix-Core'.
	packageClasses := pc collectClasses.

	classMethods := pc collectMethodsFor: 
		                 (packageClasses select: [ :class |
			                  class name = #MatrixElement ]) first.

	self assert: classMethods isNotEmpty.
	self assert: classMethods equals: #( #value #row #column: #value: #row: #column ).
]

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

{ #category : 'tests' }
PackageCollectorTest >> testCollectMethodsReferencingInstanceVariable [
    | pc packageClasses class methodsReferencingValue |
    pc := PackageCollector named: 'Matrix-Core'.
    packageClasses := pc collectClasses.
    
    class := (packageClasses select: [:class | class name = #MatrixElement]) first.
    
    methodsReferencingValue := pc collectMethodsReferencingInstanceVariable: 'value' forClass: class.
    
    self assert: methodsReferencingValue isNotEmpty.
    self assert: methodsReferencingValue equals: #(#value #value:).
]

{ #category : 'tests' }
PackageCollectorTest >> testCollectSendersForMethod [
    | pc packageClasses class senders |
    pc := PackageCollector named: 'Matrix-Core'.
    packageClasses := pc collectClasses.
    
    class := (packageClasses select: [:c | c name = #Matrix]) first.
    
    senders := pc collectSendersForMethod: #validateRow:column: forClass: class.
    
    self assert: senders isNotEmpty.

]
