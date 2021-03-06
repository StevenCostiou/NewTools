Class {
	#name : #StSBPackagesPanel,
	#superclass : #StSBPanel,
	#instVars : [
		'packageTree'
	],
	#category : #'NewTools-SystemBrowser-View'
}

{ #category : #specs }
StSBPackagesPanel class >> defaultSpec [

	^ SpBoxLayout newVertical 
		add: #packageTree;
		yourself
]

{ #category : #initialization }
StSBPackagesPanel >> defineInputPorts [ 

	^ { SpListItemsPort newDelegate: [ self packageTree ] }
]

{ #category : #initialization }
StSBPackagesPanel >> defineOutputPorts [ 

	^ { SpListSelectionPort newDelegate: [ self packageTree ] }
]

{ #category : #initialization }
StSBPackagesPanel >> initializeWidgets [
	
	packageTree := self newTreeTable
		hideColumnHeaders;
		addColumn: (SpCompositeTableColumn 
			with: (SpImageTableColumn evaluated: #icon) beNotExpandable
			with: (SpStringTableColumn evaluated: #name));
		roots: self model allPackages;
		children: #children;
		yourself
]

{ #category : #accessing }
StSBPackagesPanel >> packageTree [
	^ packageTree
]
