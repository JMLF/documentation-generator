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
PackageCollector >> collectMethodsReferencingInstanceVariable: anInstanceVar forClass: aClass [
"Collect all methods that reference a given instance variable"
    | methodsReferencing |
    methodsReferencing := aClass methodDictionary select: [:method |
		"We're looking in the ast if any nodes isVarabiale & instanceVar and correpond to our name "
        method ast allChildren anySatisfy: [:node |
            node isVariable and: [
                node isInstanceVariable and: [node name = anInstanceVar]]]].
    ^methodsReferencing keys
]

{ #category : 'initialization' }
PackageCollector >> collectSendersForMethod: aMethod forClass: aClass [ 
"Collect all methods that send a message to a given method"
    | senders |
    senders := OrderedCollection new.
    "Not sure if we want all subblasses here"
    aClass withAllSubclassesDo: [:each |
        each methodsDo: [:method |
            (method ast sentMessages includes: aMethod)
                ifTrue: [senders add: method]]].
    
    ^senders
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

        "Add information about instance variable references"
        classInfo at: #instanceVariableReferences put: (
            (self collectInstanceVariablesFor: class) collect: [:var |
                var -> (self collectMethodsReferencingInstanceVariable: var forClass: class)
            ]) asDictionary.
        
        "Add information about method senders"
        classInfo at: #methodSenders put: (
            (self collectMethodsFor: class) collect: [:method |
                method -> (self collectSendersForMethod: method forClass: class)
            ]) asDictionary.

        documentation at: class name put: classInfo.
    ].
]

{ #category : 'initialization' }
PackageCollector >> generateDocumentationString [ 
"String with all documentation to display in transcript"
       | stream |
    stream := WriteStream on: String new.
    
    stream 
        nextPutAll: 'Documentation for package: ';
        nextPutAll: packageName;
        cr; cr.
    
    documentation keysAndValuesDo: [ :className :classInfo |
        stream
            nextPutAll: 'Class: ';
            nextPutAll: className;
            cr;
            nextPutAll: '  Superclass: ';
            nextPutAll: (classInfo at: #superclass);
            cr.
        
        stream nextPutAll: '  Subclasses: '.
        (classInfo at: #subclasses)
            ifEmpty: [ stream nextPutAll: 'None' ]
            ifNotEmpty: [ :subclasses | 
                subclasses 
                    do: [ :subclass | stream nextPutAll: subclass ]
                    separatedBy: [ stream space ] ].
        stream cr.
        
        stream nextPutAll: '  Instance Variables: '.
        (classInfo at: #instanceVariables)
            ifEmpty: [ stream nextPutAll: 'None' ]
            ifNotEmpty: [ :vars | 
                vars 
                    do: [ :var | stream nextPutAll: var ]
                    separatedBy: [ stream space ] ].
        stream cr.
        
        stream nextPutAll: '  Methods:'; cr.
        (classInfo at: #methods) do: [ :method |
            stream
                nextPutAll: '    ';
                nextPutAll: method;
                cr ].
        
        stream nextPutAll: '  Instance Variable References:'; cr.
        (classInfo at: #instanceVariableReferences) keysAndValuesDo: [ :var :methods |
            stream
                nextPutAll: '    ';
                nextPutAll: var;
                nextPutAll: ' referenced in: ';
                nextPutAll: (methods joinUsing: ', ');
                cr ].
        
        stream nextPutAll: '  Method Senders:'; cr.
        (classInfo at: #methodSenders) keysAndValuesDo: [ :method :senders |
            stream
                nextPutAll: '    ';
                nextPutAll: method asString;
                nextPutAll: ' called by: '.
            
            senders 
                ifEmpty: [ stream nextPutAll: 'None' ]
                ifNotEmpty: [
                    | senderNames |
                    senderNames := senders collect: [:sender | 
                        sender selector ifNotNil: [:sel | sel asString] ifNil: ['<unknown>']].
                    senderNames
                        do: [:name | stream nextPutAll: name]
                        separatedBy: [stream nextPutAll: ', ']
                ].
            stream cr.
        ].
        
        stream cr.
    ].
    
    ^stream contents

]

{ #category : 'initialization' }
PackageCollector >> initializeWithPackageNamed: aPackageName [
    packageName := aPackageName.
    documentation := Dictionary new.
]
