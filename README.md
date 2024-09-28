# documentation-generator
Small package documentation project in pharo

## Getting the baseline :

```smalltalk
Metacello new
	repository: 'github://JMLF/documentation-generator:main';
	baseline: 'Documentor';
	onConflictUseLoaded;
	load.
```

## Usage : 

```smalltalk
collector := PackageCollector named: 'Matrix-Core'.
collector generateDocumentation.
documentationString := collector generateDocumentationString.
Transcript show: documentationString.
```

Wich gives us : 

```
Documentation for package: Matrix-CoreClass: SparseMatrix  Superclass: AbstractMatrix  Subclasses: None  Instance Variables: rows columns elements  Methods:    elements    elementAtColumn:atRow:    printOn:    atColumn:atRow:    atColumn:atRow:put:    toMatrix    initializeWithRows:columns:  Instance Variable References:    elements referenced in: elements, elementAtColumn:atRow:, atColumn:atRow:put:, toMatrix, initializeWithRows:columns:    rows referenced in: printOn:, toMatrix, initializeWithRows:columns:    columns referenced in: printOn:, toMatrix, initializeWithRows:columns:  Method Senders:    printOn: called by: None    atColumn:atRow: called by: printOn:    atColumn:atRow:put: called by: toMatrix    elements called by: None    initializeWithRows:columns: called by: None    toMatrix called by: None    elementAtColumn:atRow: called by: atColumn:atRow:, atColumn:atRow:put:Class: AbstractMatrix  Superclass: Object  Subclasses: Matrix SparseMatrix  Instance Variables: rows columns  Methods:    rows:    columns    printOn:    atColumn:atRow:    columns:    atColumn:atRow:put:    rows    validateRow:column:    size  Instance Variable References:    rows referenced in: rows:, rows, validateRow:column:, size    columns referenced in: columns, columns:, validateRow:column:, size  Method Senders:    rows called by: None    atColumn:atRow: called by: toSparseMatrix, printOn:, printOn:    printOn: called by: None    validateRow:column: called by: atColumn:atRow:, atColumn:atRow:put:, atColumn:atRow:, atColumn:atRow:put:    size called by: None    rows: called by: None    columns called by: None    columns: called by: None    atColumn:atRow:put: called by: toSparseMatrix, toMatrixClass: Matrix  Superclass: AbstractMatrix  Subclasses: None  Instance Variables: rows columns data  Methods:    initializeValue:rows:columns:    toSparseMatrix    printOn:    atColumn:atRow:    atColumn:atRow:put:    data    initializeZeroMatrixRows:columns:  Instance Variable References:    data referenced in: initializeValue:rows:columns:, atColumn:atRow:, atColumn:atRow:put:, data, initializeZeroMatrixRows:columns:    rows referenced in: initializeValue:rows:columns:, toSparseMatrix, printOn:, initializeZeroMatrixRows:columns:    columns referenced in: initializeValue:rows:columns:, toSparseMatrix, printOn:, initializeZeroMatrixRows:columns:  Method Senders:    initializeValue:rows:columns: called by: None    printOn: called by: None    atColumn:atRow: called by: toSparseMatrix, printOn:    atColumn:atRow:put: called by: toSparseMatrix    toSparseMatrix called by: None    initializeZeroMatrixRows:columns: called by: None    data called by: NoneClass: MatrixElement  Superclass: Object  Subclasses: None  Instance Variables: row column value  Methods:    value    row    column:    value:    row:    column  Instance Variable References:    column referenced in: column:, column    value referenced in: value, value:    row referenced in: row, row:  Method Senders:    value called by: None    value: called by: None    row called by: None    column called by: None    row: called by: None    column: called by: None
```
