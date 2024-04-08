"
I am just a convenience object to test DebugPoints integration into NewTools.
"
Class {
	#name : 'DebugPointTestObject',
	#superclass : 'Object',
	#instVars : [
		'name'
	],
	#category : 'NewTools-DebugPoints-Tests',
	#package : 'NewTools-DebugPoints-Tests'
}

{ #category : 'accessing' }
DebugPointTestObject >> block [

	^ [ :e | name := e ]
]

{ #category : 'accessing' }
DebugPointTestObject >> name [

	^ name
]

{ #category : 'accessing' }
DebugPointTestObject >> name: anObject [
	|temp|
	temp := WriteStream on: String new.
	temp << 'Mrs.'. 
	temp space. 
	temp << anObject.
	name := temp contents
]

{ #category : 'accessing' }
DebugPointTestObject >> valueWithBlock: v [

	^ self block value: v
]
