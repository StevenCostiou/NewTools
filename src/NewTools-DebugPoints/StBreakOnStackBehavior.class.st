"
I behave differently depending on the debug point context:
- if I am called automatically from a break debug point, I do nothing
- if I am called explicitly by a unknown bytecode hit, I manipulates bytecodes of my compiled method (that is on the stack) to simulate a breakpoint
i should be cleared once the method i instrument has been garbage collected. 
"
Class {
	#name : 'StBreakOnStackBehavior',
	#superclass : 'DebugPointSideEffectBehavior',
	#instVars : [
		'compiledMethod',
		'pc',
		'bytecode',
		'ast',
		'offset'
	],
	#category : 'NewTools-DebugPoints',
	#package : 'NewTools-DebugPoints'
}

{ #category : 'instance creation' }
StBreakOnStackBehavior class >> compiledMethod: aCompiledMethod node: aNode pc: aPC bytecode: aBytecode [

	^ self new
		  compiledMethod: aCompiledMethod;
		  ast: aNode;
		  pc: aPC;
		  bytecode: aBytecode;
		  yourself
]

{ #category : 'instance creation' }
StBreakOnStackBehavior class >> compiledMethod: aCompiledMethod node: aNode pc: aPC bytecode: aBytecode offset: anOffset [

	^ self new
		  compiledMethod: aCompiledMethod;
		  ast: aNode;
		  pc: aPC;
		  bytecode: aBytecode;
		  offset: anOffset;
		  yourself
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> ast [

	^ ast
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> ast: anObject [

	ast := anObject
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> bytecode [

	^ bytecode
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> bytecode: anObject [

	bytecode := anObject
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> compiledMethod [

	^ compiledMethod
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> compiledMethod: anObject [

	compiledMethod := anObject
]

{ #category : 'execution' }
StBreakOnStackBehavior >> execute [
	"I do nothing"
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> offset [

	^ offset
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> offset: anObject [

	offset := anObject
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> pc [

	^ pc
]

{ #category : 'accessing' }
StBreakOnStackBehavior >> pc: anObject [

	pc := anObject
]

{ #category : 'cleanup' }
StBreakOnStackBehavior >> remove [ 
	compiledMethod at: offset put: bytecode.
	^super remove
]
