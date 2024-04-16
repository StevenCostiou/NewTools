Class {
	#name : 'BreakOnStackTest',
	#superclass : 'TestCase',
	#instVars : [
		'debuggerModel',
		'debugPoint',
		'metalink',
		'method',
		'sendNode',
		'astInterval'
	],
	#category : 'NewTools-DebugPoints-Tests',
	#package : 'NewTools-DebugPoints-Tests'
}

{ #category : 'running' }
BreakOnStackTest >> setUp [
	super setUp.	

	debuggerModel := StTestDebuggerProvider new debuggerWithRecursiveContext debuggerActionModel.
	debuggerModel removeActionsForSession: debuggerModel session.
	debuggerModel session stepInto.
	debuggerModel session stepInto.
	debuggerModel updateTopContext.
	
	method := debuggerModel topContext method.
	sendNode := method sendNodes first.
	astInterval := sendNode start to: sendNode stop.

]

{ #category : 'running' }
BreakOnStackTest >> tearDown [

	debuggerModel clearDebugSession.
	debuggerModel clear.
	debugPoint ifNotNil:[:dp| dp remove].
	metalink ifNotNil: [ :link | link uninstall ].
	super tearDown
]

{ #category : 'tests' }
BreakOnStackTest >> testDebugPointInstallation [
	| systemMethod behavior |
	method := debuggerModel topContext method.	
	sendNode := method sendNodes first. 
	astInterval := sendNode start to: sendNode stop.
	
	debugPoint := debuggerModel
		breakInContext: debuggerModel topContext
		astInterval: astInterval.
	
	systemMethod := debuggerModel topContext receiver class
		                lookupSelector: debuggerModel topContext selector.

	behavior := debugPoint getBehavior: StBreakOnStackBehavior.

	self assert: behavior notNil.
	self assert: behavior bytecode equals: 128. "<- the bytecode that we are replacing by an unknown bytecode"
	self assert: behavior offset equals: 36. "<- the offest where we find the bytecode in the instrumented method"
	self assert: debugPoint target method identicalTo: systemMethod. "the debug point is also installed on the system method"
	self assert: (method at: 36) equals: debuggerModel class breakOnStackBytecode 
	
]

{ #category : 'tests' }
BreakOnStackTest >> testDebugPointRemoval [

	debugPoint := debuggerModel
		              breakInContext: debuggerModel topContext
		              astInterval: astInterval.

	debugPoint remove.

	self deny: (method methodClass >> method selector) hasMetaLinks.
	self assert: (method at: 36) equals: 128
]

{ #category : 'tests' }
BreakOnStackTest >> testMethodCacheFlushed [

	| tag |
	method := debuggerModel topContext method.
	sendNode := method sendNodes first.
	astInterval := sendNode start to: sendNode stop.

	metalink := MetaLink new
		        metaObject: [:rcv|  tag := rcv ];
		        selector: #value:;
		        control: #instead;
		 		  arguments: #(receiver);
		        yourself.
		
	(method class >> #flushCache) ast link: metalink.

	debugPoint := debuggerModel
		              breakInContext: debuggerModel topContext
		              astInterval: astInterval.

	self assert: tag identicalTo: method
]

{ #category : 'tests' }
BreakOnStackTest >> testStackMethodDifferentFromSystemMethod [

	| systemMethod |
	method := debuggerModel topContext method.
	systemMethod := debuggerModel topContext receiver class
		                lookupSelector: debuggerModel topContext selector.
	self assert: method identicalTo: systemMethod.
	
	sendNode := method sendNodes first.
	astInterval := sendNode start to: sendNode stop.
	debugPoint := debuggerModel
		breakInContext: debuggerModel topContext
		astInterval: astInterval.

	method := debuggerModel topContext method.
	systemMethod := debuggerModel topContext receiver class
		                lookupSelector: debuggerModel topContext selector.
	self deny: method identicalTo: systemMethod
]
