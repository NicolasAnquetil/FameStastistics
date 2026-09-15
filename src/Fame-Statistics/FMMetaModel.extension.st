Extension { #name : 'FMMetaModel' }

{ #category : '*Fame-Statistics' }
FMMetaModel >> countUsageOfAny: aTraitCollection [

	^self classes count: [ :fm3Type |
		fm3Type allUsedTraits anySatisfy: [ :t | aTraitCollection includes: t implementingClass ]
	]
]
