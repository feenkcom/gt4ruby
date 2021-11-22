Trait {
	#name : #TMysqlProgramNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitColumnDefinition: aColumnDefinition [
	^ self visitProgram: aColumnDefinition
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitConstraintDefinition: aConstraintDefinition [
	^ self visitProgram: aConstraintDefinition
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitCreateTable: aCreateTable [
	^ self visitProgram: aCreateTable
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitDataType: aDataType [
	^ self visitProgram: aDataType
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitDropTable: aDropTable [
	^ self visitProgram: aDropTable
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitFile: aFile [
	^ self visitProgram: aFile
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitIndexDefinition: anIndexDefinition [
	^ self visitProgram: anIndexDefinition
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitIndexOption: anIndexOption [
	^ self visitProgram: anIndexOption
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitPartitionDefinition: aPartitionDefinition [
	^ self visitProgram: aPartitionDefinition
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitProgram: aProgram [
	^ self visitSmaCCParseNode: aProgram
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitSubpartitionDefinition: aSubpartitionDefinition [
	^ self visitProgram: aSubpartitionDefinition
]

{ #category : #generated }
TMysqlProgramNodeVisitor >> visitTableOption: aTableOption [
	^ self visitProgram: aTableOption
]
