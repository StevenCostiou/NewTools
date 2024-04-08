Class {
	#name : 'BreakOnStackTest',
	#superclass : 'TestCase',
	#instVars : [
		'debuggerModel',
		'debugPoint',
		'metalink'
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
	debuggerModel updateTopContext
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
BreakOnStackTest >> testMethodCacheFlushed [

	| method sendNode astInterval tag |
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

	| method sendNode astInterval systemMethod |
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
