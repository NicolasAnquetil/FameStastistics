"
Count all meta-models in the image and compute relations between them

`MMCencus report` generate a plantUML script in the Transcript


"
Class {
	#name : 'MMCensus',
	#superclass : 'Object',
	#category : 'Fame-Statistics',
	#package : 'Fame-Statistics'
}

{ #category : 'running' }
MMCensus class >> allMM [
	"we consider that each generator represents a meta-model"

	^FamixMetamodelGenerator withAllSubclasses
		reject: [ :c | (c name includesSubstring: 'Test') 
			or: [c superclass  name includesSubstring: 'Test' ] ]

]

{ #category : 'running' }
MMCensus class >> mmHierarchy [

	^self allMM flatCollect: [ :c |
		c submetamodels collect: [ :s | c -> s ]
	]
]

{ #category : 'running' }
MMCensus class >> mmHierarchy: c [

	^c submetamodels
]

{ #category : 'running' }
MMCensus class >> mmLinkType: c [

	^((self mmType: c) = #family)
		ifTrue: [ '<|..' ]
		ifFalse: [ '<--' ]
]

{ #category : 'running' }
MMCensus class >> mmType: c [

	^(c methods anySatisfy: [ :mth |
		mth sendNodes anySatisfy: [ :send |
			(send selector = #newClassNamed:comment:) or:
			[ send selector = #newClassNamed: ] ]])
		ifTrue: [ #family ]
		ifFalse: [ #linking ]
]

{ #category : 'running' }
MMCensus class >> report [

	'@startuml' traceCr.

	self allMM do: [ :c || lnk |
		lnk := self mmLinkType: c.
		(self mmHierarchy: c) do: [ :s |
			Transcript
				<< s name ;
				space ;
				<< lnk ;
				space ;
				<< c name;
				cr
		]
	].

	'@enduml' traceCr.

]
