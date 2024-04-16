Extension { #name : 'StDebuggerActionModel' }

{ #category : '*NewTools-DebugPoints' }
StDebuggerActionModel >> breakInContext: aContext astInterval: anInterval [

	| method node offset bc debugPoint |
	method := aContext method.
	node := method ast bestNodeFor: anInterval.
	offset := node methodNode bcToASTCache firstBcOffsetForNode: node.
	bc := method at: offset.
	aContext method at: offset put: self class breakOnStackBytecode.
	debugPoint := DebugPointManager
		              breakOnRunningMethod: aContext method
		              node: node
		              pc: aContext pc
		              bytecode: bc
						  offset: offset. 
	method flushCache.
	^ debugPoint
]

{ #category : '*NewTools-DebugPoints' }
StDebuggerActionModel class >> breakOnStackBytecode [
	 ^84
]
