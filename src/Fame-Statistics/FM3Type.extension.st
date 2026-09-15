Extension { #name : 'FM3Type' }

{ #category : '*Fame-Statistics' }
FM3Type >> allUsedTraits [

	| usedTraits nbTraits |
	usedTraits := self traits.
	nbTraits := 0.
	[ nbTraits < usedTraits size  ]
		whileTrue: [
			nbTraits := usedTraits size.
			usedTraits addAll: (usedTraits flatCollect: #traits) ].
	^usedTraits 
]
