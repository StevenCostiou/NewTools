Extension { #name : 'StDebugger' }

{ #category : '*NewTools-DebugPoints' }
StDebugger >> breakOnCurrentASTSelection [

	self debuggerActionModel
		breakInContext: self selectedContext
		astInterval: self code selectionInterval
]

{ #category : '*NewTools-DebugPoints' }
StDebugger class >> buildBreakpointExtentionCommandsGroupWith: stDebuggerInstance forRoot: rootCommandGroup [

	<extensionCommands>
	| commands codeGroup |
	commands := { StBreakOnStackCommand } collect: [ :class |class forSpecContext: stDebuggerInstance ].


	codeGroup := rootCommandGroup
	             / StDebuggerCodeCommandTreeBuilder groupName
	             / StDebuggerCodeCommandTreeBuilder new
		             codeDebugCommandsGroupName.
	commands do: [ :c | codeGroup register: c ]
]
