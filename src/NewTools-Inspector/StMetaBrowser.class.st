Class {
	#name : #StMetaBrowser,
	#superclass : #StInspection,
	#instVars : [
		'classes',
		'methods',
		'source',
		'methodFilter'
	],
	#category : #'NewTools-Inspector-View'
}

{ #category : #specs }
StMetaBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				spacing: 2;
				add: #classes;
				add:
					(SpBoxLayout newVertical
						spacing: 2;
						add: #methods;
						add: #methodFilter
							withConstraints: [ :constraint | constraint height: self inputTextHeight ];
						yourself);
				yourself);
		add: #source;
		yourself
]

{ #category : #specs }
StMetaBrowser class >> title [
	^ 'Meta'
]

{ #category : #initialization }
StMetaBrowser >> initializeClassTree [
	| classHierarchy |
	classHierarchy := self model class withAllSuperclasses reversed.
	classes
		whenSelectionChangedDo: [ :classTreeSelection | self updateMethods: classTreeSelection ].
	classes
		addColumn: (SpStringTableColumn title: 'Class hierarchy' evaluated: #name).
	classes roots: {classHierarchy first}.
	classes
		children:
			[ :aClass | classHierarchy select: [ :subclass | subclass superclass == aClass ] ].
	classes selectPath: (Array new: classHierarchy size withAll: 1)
]

{ #category : #initialization }
StMetaBrowser >> initializeMethodFilter [

	methodFilter autoAccept: true.
	methodFilter acceptBlock: [:text|
		
		
		  ]
]

{ #category : #initialization }
StMetaBrowser >> initializeMethodList [
	methods
		whenSelectionChangedDo: [ :selection | 
			| method |
			method := selection selectedItem.
			method
				ifNil: [ source text: '' ]
				ifNotNil: [ source behavior: method methodClass.
					source text: method sourceCode ] ].
	methods displayBlock: #selector
]

{ #category : #initialization }
StMetaBrowser >> initializePresenter [
	self initializeMethodList.
	self initializeClassTree
]

{ #category : #initialization }
StMetaBrowser >> initializeWidgets [
	classes := self newTreeTable.
	methods := self newList.
	methodFilter := self newTextInput.
	source := self newCode
]

{ #category : #updating }
StMetaBrowser >> updateMethods: classTreeSelection [
	| class |
	class := classTreeSelection selectedItem.
	class
		ifNil: [ methods items: SortedCollection new ]
		ifNotNil: [ | sortedMethods |
			sortedMethods := SortedCollection
				sortBlock: [ :a :b | a selector <= b selector ].
			sortedMethods addAll: class methods.
			methods items: sortedMethods ].
	methods unselectAll
]
