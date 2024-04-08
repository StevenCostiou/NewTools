"
I allow users to put breakpoints directly on the code source in the debugger.
I delegate this behavior to the debugger directly, I am just a command.
"
Class {
	#name : 'StBreakOnStackCommand',
	#superclass : 'StDebuggerCommand',
	#category : 'NewTools-DebugPoints',
	#package : 'NewTools-DebugPoints'
}

{ #category : 'initialization' }
StBreakOnStackCommand class >> defaultIconName [

	^ #smallDebug
]

{ #category : 'initialization' }
StBreakOnStackCommand class >> defaultName [	
	^ 'Break'
]

{ #category : 'initialization' }
StBreakOnStackCommand class >> defaultShortcut [
	^ nil
]

{ #category : 'executing' }
StBreakOnStackCommand >> execute [ 
	self halt.
	self debugger breakOnCurrentASTSelection
]
