Extension { #name : 'StDebuggerActionModel' }

{ #category : '*NewTools-DebugPoints' }
StDebuggerActionModel >> breakInContext: aContext astInterval: anInterval [

	| method node bc debugPoint |
	method := aContext method.
	node := method ast bestNodeFor: anInterval.
	bc := node methodNode bcToASTCache firstBcOffsetForNode: node.
	"aContext method at: bc put: 84"
	debugPoint := DebugPointManager
		              breakOnRunningMethod: aContext method
		              node: node
		              pc: aContext pc
		              bytecode: bc.
	method flushCache.
	^ debugPoint
]
