Extension { #name : #RBCompositeLintRule }

{ #category : #'*CI-Core-Validation' }
RBCompositeLintRule >> addResultTo: results [
	self rules do: [ :rule |
		rule addResultTo: results ].
]

{ #category : #'*CI-Core-Validation' }
RBCompositeLintRule class >> pharoHardLintRules [
	^ self rules: ({ 
		RBUndeclaredReferenceRule.
		RBUnclassifiedMethodsRule.
		RBNoClassCommentRule. 
		RBDefinesEqualNotHashRule.
		RBEquivalentSuperclassMethodsRule.
		RBJustSendsSuperRule.
		RBSubclassResponsibilityNotDefinedRule.
		RBTempVarOverridesInstVarRule.
		RBVariableNotDefinedRule.
		RBEqualNotUsedRule.
		RBOnlyReadOrWrittenTemporaryRule.
		RBPrecedenceRule.
		RBSendsDeprecatedMethodToGlobalRule.
		RBSizeCheckRule.
		RBUnconditionalRecursionRule.
		RBUnoptimizedToDoRule.
		RBBetweenAndRule.
		RBCodeCruftLeftInMethodsRule 
	} collect: [ :each | each new ])
]

{ #category : #'*CI-Core-Validation' }
RBCompositeLintRule class >> pharoSoftLintRules [	
	^ self rules: ({			
		RBInstanceVariableCapitalizationRule.
		RBClassVariableCapitalizationRule.
		RBMissingSubclassResponsibilityRule.
		RBOverridesSpecialMessageRule.
		RBRefersToClassRule.
		RBBadMessageRule.
		RBUsesTrueRule.
		RBSendsDifferentSuperRule.
		RBInconsistentMethodClassificationRule. 
		RBInstVarInSubclassesRule.
		RBSentNotImplementedRule.
		RBLongMethodsRule.
		RBCollectionProtocolRule.
		RBConsistencyCheckRule.
		RBContainsRule. RBDetectContainsRule.
		RBEmptyExceptionHandlerRule.
		RBEndTrueFalseRule.
		RBEqualsTrueRule.
		RBExtraBlockRule.
		RBFileBlocksRule.
		RBFloatEqualityComparisonRule.
		RBLiteralArrayCharactersRule.
		RBMissingYourselfRule.
		RBModifiesCollectionRule.
		RBReturnsIfTrueRule.
		RBSearchingLiteralRule.
		RBUnnecessaryAssignmentRule.
		RBNotEliminationRule.
		RBAtIfAbsentRule.
		RBAllAnyNoneSatisfyRule.
		RBClassNameInSelectorRule 
	} collect: [ :each | each new ])
]

{ #category : #'*CI-Core-Validation' }
RBCompositeLintRule >> result [
	| environment |
	rules ifEmpty: [ 
		^ RBBrowserEnvironment empty ].
	
	environment := rules first result.
	rules allButFirstDo: [ :rule|
		environment := environment | rule result ].
	^ environment

]
