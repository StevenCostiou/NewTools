Extension { #name : 'DebugPointManager' }

{ #category : '*NewTools-DebugPoints' }
DebugPointManager class >> breakOnRunningMethod: aCompiledMethod node: aNode pc: aPC bytecode: aBytecode [

	| behavior debugPoint |
	behavior := StBreakOnStackBehavior
		            compiledMethod: aCompiledMethod
		            node: aNode
		            pc: aPC
		            bytecode: aBytecode.
	behavior priority: 1.

	debugPoint := self
		              installNew: BreakDebugPoint
		              on: aNode
		              withBehaviors: {  }.
	debugPoint addBehavior: behavior.
	^ debugPoint
]
