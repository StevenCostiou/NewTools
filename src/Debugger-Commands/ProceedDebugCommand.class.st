Class {
	#name : #ProceedDebugCommand,
	#superclass : #DebugCommand,
	#category : #'Debugger-Commands'
}

{ #category : #default }
ProceedDebugCommand class >> defaultCommandName [
	<ToolbarDebugCommand>
	^ 'Proceed'
]

{ #category : #default }
ProceedDebugCommand class >> defaultDescription [
	^ 'Relinquish debugger control and proceed execution from the current point of debugger control.'
]

{ #category : #initialization }
ProceedDebugCommand class >> defaultIconName [
	^ #glamorousGo
]

{ #category : #initialization }
ProceedDebugCommand class >> defaultShortcut [
	^ PharoShortcuts current resumeExecutionShortcut
]

{ #category : #hooks }
ProceedDebugCommand >> execute [
	self session
		resume;
		clear.
	self debugger close
]
