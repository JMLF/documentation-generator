Class {
	#name : 'PackageCollector',
	#superclass : 'Object',
	#instVars : [
		'packageName',
		'documentation'
	],
	#category : 'Documentor-Core',
	#package : 'Documentor-Core'
}

{ #category : 'instance creation' }
PackageCollector class >> named: aPackageName [
	^self new initializeWithPackageNamed: aPackageName ; yourself 
]

{ #category : 'as yet unclassified' }
PackageCollector >> collectClasses [
"Collect all classes from a package"
    ^ (RPackageSet named: packageName) classes
]

{ #category : 'initialization' }
PackageCollector >> collectInstanceVariablesFor: aClass [
"Collect all instance variable for a class"
    | vars |
    vars := aClass allInstVarNames.
    ^vars.
]

{ #category : 'initialization' }
PackageCollector >> collectMethodsFor: aClass [
    | methods |
    methods := aClass selectors.
	^methods .
]

{ #category : 'initialization' }
PackageCollector >> generateDocumentation [
"Build the documentation array with all the package informations"
    | classes |
    classes := self collectClasses.
    classes do: [:class |
        | classInfo |
        classInfo := Dictionary new.
        classInfo at: #superclass put: class superclass name.
        classInfo at: #subclasses put: (class subclasses collect: [:subclass | subclass name]).
        classInfo at: #instanceVariables put: (self collectInstanceVariablesFor: class).
        classInfo at: #methods put: (self collectMethodsFor: class).
        documentation at: class name put: classInfo.
    ].
]

{ #category : 'initialization' }
PackageCollector >> initializeWithPackageNamed: aPackageName [
    packageName := aPackageName.
    documentation := Dictionary new.
]
