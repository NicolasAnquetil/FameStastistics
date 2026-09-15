Class {
	#name : 'TraitsCounting',
	#superclass : 'Object',
	#classInstVars : [
		'allTraits',
		'associationsTraits',
		'technicalTraits',
		'propertyTraits',
		'sourceEntityTraits'
	],
	#category : 'Fame-Statistics',
	#package : 'Fame-Statistics'
}

{ #category : 'querying' }
TraitsCounting class >> allTraits [

	^allTraits ifNil: [
		allTraits := Smalltalk globals values
			select: [ :e |
				e isTrait and:
				[(e name beginsWith:'FamixT') and: 
				[e name seventh isUppercase and: 
				[ (e name includesSubstring: 'Test') not ]]]]]
]

{ #category : 'querying' }
TraitsCounting class >> associationsTraits [

	^associationsTraits ifNil: [
		associationsTraits := { FamixTAssociation . FamixTDereferencedInvocation . FamixTParametricAssociation } asOrderedCollection.
		associationsTraits addAll: (associationsTraits flatCollect: #users).
		associationsTraits := associationsTraits reject: [ :t | t name includesSubstring: 'Test' ].
		associationsTraits removeDuplicates.
		associationsTraits
	]
]

{ #category : 'querying' }
TraitsCounting class >> metamodelReport: aModelClass [

	#(allTraits associationsTraits technicalTraits propertyTraits sourceEntityTraits) do: [ :k |
	k trace.
	' ' trace.
	(aModelClass metamodel countUsageOfAny: (self perform: k)) traceCr.
]
 
]

{ #category : 'querying' }
TraitsCounting class >> propertyTraits [

	^propertyTraits ifNil:[
		propertyTraits := (self allTraits select: [ :t | t name beginsWith: 'FamixTWith' ])
		          asOrderedCollection.
		propertyTraits addAll: (self allTraits select: [ :t | t name beginsWith: 'FamixTHas' ]).
		propertyTraits addAll: (self allTraits select: [ :t | t name beginsWith: 'FamixTCan' ]).
		propertyTraits addAll: {
			FamixTAccessible.
			FamixTPackageable.
			FamixTMethodMetrics.
			FamixTReferenceable.
			FamixTFileSystemEntity.
			FamixTShadowable.
			FamixTShadower.
			FamixTClassMetrics.
			FamixTDefinedInModule.
			FamixTLCOMMetrics.
			FamixTStructuralEntity.
			FamixTTraitUser.
			FamixTImplementable.
			FamixTTypedEntity.
			FamixTCohesionCouplingMetrics.
			FamixTNamedEntity.
			FamixTInvocationsReceiver.
			FamixTThrowable.
			FamixTImportable }.
		propertyTraits]
]

{ #category : 'initialization' }
TraitsCounting class >> resetAll [

	allTraits := nil.
	associationsTraits := nil.
	technicalTraits := nil.
	propertyTraits := nil.
	sourceEntityTraits := nil
]

{ #category : 'querying' }
TraitsCounting class >> sourceEntityTraits [

	^sourceEntityTraits ifNil: [
		sourceEntityTraits := self allTraits \ self associationsTraits  \ self technicalTraits \ self propertyTraits]
]

{ #category : 'querying' }
TraitsCounting class >> technicalTraits [

	^technicalTraits ifNil: [
		technicalTraits := (('Famix-Traits' asPackage) tags detect: [:p | p name = 'SourceAnchor']) classes.
		technicalTraits add: FamixTSourceLanguage.
		technicalTraits ]
]
