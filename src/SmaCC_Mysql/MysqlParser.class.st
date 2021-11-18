Class {
	#name : #MysqlParser,
	#superclass : #SmaCCGLRParser,
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlParser class >> ambiguousTransitions [
^#(
#[ 1 162 5 137] 
#[ 3 6 8 169] 
#[ 3 6 8 173] 
#[ 3 30 9 9] 
#[ 3 126 10 213] 
#[ 3 130 10 217] 
#[ 4 18 12 37] 
#[ 4 22 12 105] 
#[ 4 38 12 141]
	).
]

{ #category : #'generated-accessing' }
MysqlParser class >> cacheId [
	^'2021-11-18T12:23:14.957502-06:00'
]

{ #category : #generated }
MysqlParser class >> definitionComment [
"%ignorecase;

%glr;
%root Program;
%prefix Mysql;
%suffix Node;

<string>
	: (\' [^\']* \')+
	;
<integer>
	: \d+
	;
<number>
	: [\+\-]? <integer> (\. <integer>)?
	;
<name>
	: \` [^\`]+ \`
	;
<comment>
	: \-\- [^\r\n]*
	| (\/\* [^\*]* \*+ ([^\/\*] [^\*]* \*+)* \/)
	;
<whitespace>
	: \s+
	;
<simple_name>
	: (<isLetter>|_) ((<isLetter>|_) | \d)*
	;
File
	: Statements {{}}
	;
Statements
	: (Statement 'statement' "";"" 'semicolon')* Statement 'statement' {{File}}
	;
Statement
	:
	| CreateTable
	;
CreateTable
	: ""CREATE"" 'createToken' ""TEMPORARY"" 'temporaryToken'? ""TABLE"" 'tableToken' (""IF"" 'ifToken' ""NOT"" 'notToken' ""EXISTS"" 'existsToken')? tbl_name 'tableName'
		""("" 'leftParen' create_definition 'definition' ("","" 'comma' create_definition 'definition')* "")"" 'rightParen'
		table_options?
		partition_options? {{}}
	| ""CREATE"" 'createToken' ""TEMPORARY"" 'temporaryToken'? ""TABLE"" 'tableToken' (""IF"" 'ifToken' ""NOT"" 'notToken' ""EXISTS"" 'existsToken')? tbl_name 'tableName'
		(""("" 'leftParen' create_definition 'definition' ("","" 'comma' create_definition 'definition')* "")"" 'rightParen')?
		table_options?
		partition_options?
		(""IGNORE"" 'ignoreToken' | ""REPLACE"" 'replaceToken')?
		""AS"" 'asToken'? query_expression 'query' {{}}
	| ""CREATE"" 'createToken' ""TEMPORARY"" 'temporaryToken'? ""TABLE"" 'tableToken' (""IF"" 'ifToken' ""NOT"" 'notToken' ""EXISTS"" 'existsToken')? tbl_name 'tableName'
    	(""LIKE"" 'likeToken' tbl_name 'likeTableName' | ""("" 'leftParen' ""LIKE"" 'likeToken' tbl_name 'likeTableName' "")"" 'rightParen') {{}}
	;
create_definition
	: col_name 'columnName' column_definition {{ColumnDefinition}}
	| (""INDEX"" 'indexToken' | ""KEY"" 'keyToken') index_name 'indexName'? index_type? ""("" 'leftParen' key_part ("","" 'comma' key_part)*"")"" 'rightParen'
		index_option 'option'? {{IndexDefinition}}
	| (""FULLTEXT"" 'fulltextToken' | ""SPATIAL"" 'spatialToken') (""INDEX"" 'indexToken' | ""KEY"" 'keyToken')? index_name 'indexName'? ""("" 'leftParen' key_part ("","" 'comma' key_part)*"")"" 'rightParen'
		index_option 'option'? {{IndexDefinition}}
	| (""CONSTRAINT"" 'constraintToken' symbol 'constraintName'?)? ""PRIMARY"" 'primaryToken' ""KEY"" 'keyToken'
		index_type? ""("" 'leftParen' key_part ("","" 'comma' key_part)*"")"" 'rightParen'
		index_option 'option'? {{ConstraintDefinition}}
	| (""CONSTRAINT"" 'constraintToken' symbol 'constraintName'?)? ""UNIQUE"" 'uniqueToken' (""INDEX"" 'indexToken' | ""KEY"" 'keyToken')?
		index_name 'indexName'? index_type? ""("" 'leftParen' key_part ("","" 'comma' key_part)*"")"" 'rightParen'
		index_option 'option'? {{ConstraintDefinition}}
	| (""CONSTRAINT"" 'constraintToken' symbol 'constraintName'?)? ""FOREIGN"" 'foreignToken' ""KEY"" 'keyToken'
		index_name 'indexName'? ""("" 'leftParen' col_name 'columnName' ("","" 'comma' col_name 'columnName')* "")"" 'rightParen'
		reference_definition {{ConstraintDefinition}}
	| check_constraint_definition {{ConstraintDefinition}}
	;
column_definition
	: data_type 'dataType' (""NOT"" 'notToken' ""NULL"" 'nullToken' | ""NULL"" 'nullToken')? (""DEFAULT"" 'defaultToken' (literal 'value' | ""("" 'leftParen' expr 'value' "")"" 'rightParen'))?
		(""ON"" 'onToken' ""UPDATE"" 'updateToken' (literal 'value' | ""("" 'leftParen' expr 'value' "")"" 'rightParen'))?
		(""VISIBLE"" 'visibleToken' | ""INVISIBLE"" 'invisibleToken')?
		""AUTO_INCREMENT"" 'autoIncrementToken'? (""UNIQUE"" 'uniqueToken' ""KEY"" 'keyToken'?)? (""PRIMARY"" 'primaryToken'? ""KEY"" 'keyToken')?
		(""COMMENT"" 'commentToken' <string>)?		
		(""COLLATE"" 'collateToken' collation_name 'collationName')?
		(""COLUMN_FORMAT"" 'columnFormatToken' (""FIXED"" 'columnFormat' | ""DYNAMIC"" 'columnFormat' | ""DEFAULT"" 'columnFormat'))?
		(""ENGINE_ATTRIBUTE"" 'engineAttributeToken' ""="" 'equals'? <string> 'engineAttribute')?
		(""SECONDARY_ENGINE_ATTRIBUTE"" 'secondaryToken' ""="" 'equals'? <string> 'secondaryEngineAttribute')?
		(""STORAGE"" 'storageToken' (""DISK"" 'diskToken' | ""MEMORY"" 'memoryToken'))?
		reference_definition?
		check_constraint_definition?
	| data_type 'dataType'
		(""COLLATE"" 'collateToken' collation_name 'collationName')?
		(""GENERATED"" 'generatedToken' ""ALWAYS"" 'alwaysToken')? ""AS"" 'asToken' ""("" 'leftParen' expr 'generated' "")"" 'rightParen'
		(""VIRTUAL"" 'virtualToken' | ""STORED"" 'storedToken') (""NOT"" 'notToken' ""NULL"" 'nullToken' | ""NULL"" 'nullToken')?
		(""VISIBLE"" 'visibleToken' | ""INVISIBLE"" 'invisibleToken')?
		(""UNIQUE"" 'uniqueToken' ""KEY"" 'keyToken'?)? (""PRIMARY"" 'primaryToken'? ""KEY"" 'keyToken')?
		(""COMMENT"" 'commentToken' <string>)?
		reference_definition?
		check_constraint_definition?
	;
data_type
	: data_type_name 'typeName' (""("" 'leftParen' <integer> 'length' ("","" 'comma' <integer> 'precision')? "")"" 'rightParen')? ""unsigned"" 'unsignedToken'? ""zerofill"" 'zerofillToken'? (((""CHARACTER"" 'characterToken' ""SET"" 'setToken' | ""CHARSET"" 'charsetToken') ""="" 'equals'? charset_name 'charsetName') (""COLLATE"" 'collateToken' collation_name 'collationName')?)? {{DataType}}
	| ""ENUM"" 'typeName' ""("" 'leftParen' enum_values "")"" 'rightParen'? (((""CHARACTER"" 'characterToken' ""SET"" 'setToken' | ""CHARSET"" 'charsetToken') ""="" 'equals'? charset_name 'charsetName') (""COLLATE"" 'collateToken' collation_name 'collationName')?)?  {{DataType}}
	;
enum_values
	: literal 'enumValue'
	| enum_values "","" 'comma' literal 'enumValue'
	;
 data_type_name
	: ""BIGINT""
	| ""BLOB""
	| ""CHAR""
	| ""DATE""
	| ""DATETIME""
	| ""DECIMAL""
	| ""DOUBLE""
	| ""FLOAT""
	| ""INT""
	| ""JSON""
	| ""LONGBLOB""
	| ""LONGTEXT""
	| ""MEDIUMBLOB""
	| ""MEDIUMTEXT""
	| ""SMALLINT""
	| ""TEXT""
	| ""TIMESTAMP""
	| ""TINYINT""
	| ""TINYTEXT""
	| ""VARBINARY""
	| ""VARCHAR""
	;
key_part
	: (col_name 'refColumnName' (""("" 'leftParen' length 'length' "")"" 'rightParen')? | ""("" 'leftParen' expr 'expr' "")"" 'rightParen') (""ASC"" 'direction' | ""DESC"" 'direction')?
	;
index_type
	: ""USING"" 'usingToken' (""BTREE"" 'btreeToken' | ""HASH"" 'hashToken')
	;
index_option
	: ""KEY_BLOCK_SIZE"" 'keyBlockSizeToken' ""="" 'equals'? value 'value' {{}}
	| index_type {{}}
	| ""WITH"" 'withToken' ""PARSER"" 'parserToken' parser_name 'value' {{}}
	| ""COMMENT"" 'commentToken' <string> 'value' {{}}
	| (""VISIBLE"" 'visibleToken' | ""INVISIBLE"" 'invisibleToken') {{}}
	| ""ENGINE_ATTRIBUTE"" 'engineAttributeToken' ""="" 'equals'? <string> 'value' {{}}
	| ""SECONDARY_ENGINE_ATTRIBUTE"" 'secondaryToken' ""="" 'equals'? <string> 'value' {{}}
	;
check_constraint_definition
	: (""CONSTRAINT"" 'constraintToken' symbol 'constraintName'?)? ""CHECK"" 'checkToken' ""("" 'leftParen' expr 'check' "")"" 'rightParen' (""NOT"" 'notToken'? ""ENFORCED"" 'enforcedToken')?
	;
reference_definition
	: ""REFERENCES"" 'referencesToken' tbl_name 'tableName' ""("" 'leftParen' key_part ("","" 'comma' key_part)* "")"" 'rightParen'
		(""MATCH"" 'matchToken' ""FULL"" 'fullToken' | ""MATCH"" 'matchToken' ""PARTIAL"" 'partialToken' | ""MATCH"" 'matchToken' ""SIMPLE"" 'simpleToken')?
		(""ON"" 'onToken' ""DELETE"" 'deleteToken' reference_option)?
		(""ON"" 'onToken' ""UPDATE"" 'updateToken' reference_option)?
	;
reference_option
	: ""RESTRICT"" 'restrictToken' | ""CASCADE"" 'cascadeToken' | ""SET"" 'setToken' ""NULL"" 'nullToken' | ""NO"" 'noToken' ""ACTION"" 'actionToken' | ""SET"" 'setToken' ""DEFAULT"" 'defaultToken'
	;
table_options
	: table_option 'option' ("","" 'comma'? table_option 'option')*
	;
table_option
	: ""AUTOEXTEND_SIZE"" 'autoextendSizeToken' ""="" 'equals'? value 'value' {{}}
	| ""AUTO_INCREMENT"" 'autoIncrementToken' ""="" 'equals'? value 'value' {{}}
	| ""AVG_ROW_LENGTH"" 'avgRowLengthToken' ""="" 'equals'? value 'value' {{}}
	| ""DEFAULT"" 'defaultToken'? (""CHARACTER"" 'characterToken' ""SET"" 'setToken' | ""CHARSET"" 'charsetToken') ""="" 'equals'? charset_name 'value' {{}}
	| ""CHECKSUM"" 'checksumToken' ""="" 'equals'? (""0"" 'value' | ""1"" 'value') {{}}
	| ""DEFAULT"" 'defaultToken'? ""COLLATE"" 'collateToken' ""="" 'equals'? collation_name 'value' {{}}
	| ""COMMENT"" 'commentToken' ""="" 'equals'? <string> 'value' {{}}
	| ""COMPRESSION"" 'compressionToken' ""="" 'equals'? (""'ZLIB'"" 'value' | ""'LZ4'"" 'value' | ""'NONE'"" 'value') {{}}
	| ""CONNECTION"" 'connectionToken' ""="" 'equals'? <string> 'value' {{}}
	| (""DATA"" 'dataToken' | ""INDEX"" 'indexToken') ""DIRECTORY"" 'directoryToken' ""="" 'equals'? <string> 'value' {{}}
	| ""DELAY_KEY_WRITE"" 'delayKeyWriteToken' ""="" 'equals'? (""0"" 'value' | ""1"" 'value') {{}}
	| ""ENCRYPTION"" 'encryptionToken' ""="" 'equals'? (""'Y'"" 'value' | ""'N'"" 'value') {{}}
	| ""ENGINE"" 'engineToken' ""="" 'equals'? engine_name 'value' {{}}
	| ""ENGINE_ATTRIBUTE"" 'engineAttributeToken' ""="" 'equals'? <string> 'value' {{}}
	| ""INSERT_METHOD"" 'insertMethodToken' ""="" 'equals'? ( ""NO"" 'value' | ""FIRST"" 'value' | ""LAST"" 'value' ) {{}}
	| ""KEY_BLOCK_SIZE"" 'keyBlockSizeToken' ""="" 'equals'? value 'value' {{}}
	| ""MAX_ROWS"" 'maxRowsToken' ""="" 'equals'? value 'value' {{}}
	| ""MIN_ROWS"" 'minRowsToken' ""="" 'equals'? value 'value' {{}}
	| ""PACK_KEYS"" 'packKeysToken' ""="" 'equals'? (""0"" 'value' | ""1"" 'value' | ""DEFAULT"" 'value') {{}}
	| ""PASSWORD"" 'passwordToken' ""="" 'equals'? <string> 'value' {{}}
	| ""ROW_FORMAT"" 'rowFormatToken' ""="" 'equals'? (""DEFAULT"" 'value' | ""DYNAMIC"" 'value' | ""FIXED"" 'value' | ""COMPRESSED"" 'value' | ""REDUNDANT"" 'value' | ""COMPACT"" 'value') {{}}
	| ""SECONDARY_ENGINE_ATTRIBUTE"" 'secondaryToken' ""="" 'equals'? <string> 'value' {{}}
	| ""STATS_AUTO_RECALC"" 'statsToken' ""="" 'equals'? (""DEFAULT"" 'value' | ""0"" 'value' | ""1"" 'value') {{}}
	| ""STATS_PERSISTENT"" 'statsToken' ""="" 'equals'? (""DEFAULT"" 'value' | ""0"" 'value' | ""1"" 'value') {{}}
	| ""STATS_SAMPLE_PAGES"" 'statsToken' ""="" 'equals'? value 'value' {{}}
	| ""TABLESPACE"" 'tableSpaceToken' tablespace_name 'tablespaceName' (""STORAGE"" 'storageToken' (""DISK"" 'diskToken' | ""MEMORY"" 'memoryToken'))? {{}}
	| ""UNION"" 'unionToken' ""="" 'equals'? ""("" 'leftParen' tbl_name 'tableName' ("","" 'comma' tbl_name 'tableName')* "")"" 'rightParen' {{}}
	;
partition_options
	: ""PARTITION"" 'partitionToken' ""BY"" 'byToken'
			( ""LINEAR"" 'linearToken'? ""HASH"" 'hashToken' ""("" 'leftParen' expr 'hash' "")"" 'rightParen'
			| ""LINEAR"" 'linearToken'? ""KEY"" 'keyToken' (""ALGORITHM"" 'algorithmToken' ""="" 'equals' (""1"" 'value' | ""2"" 'value'))? ""("" 'leftParen' column_list "")"" 'rightParen'				| ""RANGE"" 'rangeToken' (""("" 'leftParen' expr 'range' "")"" 'rightParen' | ""COLUMNS"" 'columnsToken' ""("" 'leftParen' column_list "")"" 'rightParen')
					| ""LIST"" 'listToken' (""("" 'leftParen' expr 'list' "")"" 'rightParen' | ""COLUMNS"" 'columnsToken' ""("" 'leftParen' column_list "")"" 'rightParen')
		(""PARTITIONS"" 'partitionsToken' num 'partitions')?
		(""SUBPARTITION"" 'subpartitionToken' ""BY"" 'byToken'
			( ""LINEAR"" 'linearToken'? ""HASH"" 'hashToken' ""("" 'leftParen' expr 'hash' "")"" 'rightParen'
				| ""LINEAR"" 'linearToken' ""KEY"" 'keyToken' (""ALGORITHM"" 'algorithmToken' ""="" 'equals' (""1"" 'value' | ""2"" 'value'))? ""("" 'leftParen' column_list "")"" 'rightParen')
			(""SUBPARTITIONS"" 'subpartitionsToken' num 'subpartitions')?
		)
		(""("" 'leftParen' partition_definition 'definition' ("","" 'comma' partition_definition 'definition')* "")"" 'rightParen'))?
	;
partition_definition
	: ""PARTITION"" 'partitionToken' partition_name 'partitionName'
		(""VALUES"" 'valueToken'
			(""LESS"" 'lessToken' ""THAN"" 'thanToken' (""("" 'leftParen' expr 'value' | value_list "")"" 'rightParen' | ""MAXVALUE"" 'maxvalueToken')
			|
			""IN"" 'inToken' ""("" 'leftParen' value_list "")"" 'rightParen' ))?
        (""STORAGE"" 'storageToken'? ""ENGINE"" 'engineToken' ""="" 'equals'? engine_name 'engineName')?
		(""COMMENT"" 'commentToken' ""="" 'equals'? <string> 'comment')?
        (""DATA"" 'dataToken' ""DIRECTORY"" 'directoryToken' ""="" 'equals'? <string> 'dataDirectory')?
        (""INDEX"" 'indexToken' ""DIRECTORY"" 'directoryToken' ""="" 'equals'? <string> 'indexDirectory')?
        (""MAX_ROWS"" 'maxRowsToken' ""="" 'equals'? <integer> 'maxRows')?
        (""MIN_ROWS"" 'minRowsToken' ""="" 'equals'? <integer> 'minRows')?
        (""TABLESPACE"" 'tableSpaceToken' ""="" 'equals'? tablespace_name 'tablespaceName')?
        (""("" 'leftParen' subpartition_definition 'definition' ("","" 'comma' subpartition_definition 'definition')* "")"" 'rightParen')? {{}}
	;
subpartition_definition
	: ""SUBPARTITION"" 'subpartitionToken' logical_name 'subpartion'
        (""STORAGE"" 'storageToken'? ""ENGINE"" 'engineToken' ""="" 'equals'? engine_name 'engineName')?
		(""COMMENT"" 'commentToken' ""="" 'equals'? <string> 'comment')?
        (""DATA"" 'dataToken' ""DIRECTORY"" 'directoryToken' ""="" 'equals'? <string> 'dataDirectory')?
        (""INDEX"" 'indexToken' ""DIRECTORY"" 'directoryToken' ""="" 'equals'? <string> 'indexDirectory')?
        (""MAX_ROWS"" 'maxRowsToken' ""="" 'equals'? <integer> 'maxRows')?
        (""MIN_ROWS"" 'minRowsToken' ""="" 'equals'? <integer> 'minRows')?
        (""TABLESPACE"" 'tableSpaceToken' ""="" 'equals'? tablespace_name 'tablespaceName')? {{}}
	;
tbl_name
	: <name>
	;
col_name
	: <name>
	;
literal
	: ""NULL"" 'value'
	| <string>
	| <number>
	| ""CURRENT_TIMESTAMP"" 'value' (""("" 'leftParen' "")"" 'rightParen')?
	;
index_name
	: <name>
	;
engine_name
	: ""InnoDB"" 'name'
	;
charset_name
	: <simple_name>
	;
length
	: <integer>
	;
collation_name
	: <simple_name>
	;
query_expression
	: error #not defined yet
	;
expr
	: error #not defined yet
	;
value_list
	: expr 'value' ("","" 'comma' expr 'value')*
	|
	;
column_list
	: col_name 'columnName' ("","" 'comma' col_name 'columnName')
	;
symbol
	: error #not defined yet
	;
parser_name
	: <simple_name>
	;
tablespace_name
	: error #not defined yet
	;
num
	: <integer>
	;
partition_name
	: error #not defined yet
	;
logical_name
	: error #not defined yet
	;
value
	: literal
	| error #not defined yet
	;"
]

{ #category : #accessing }
MysqlParser class >> fileExtension [
	^ '.sql'
]

{ #category : #generated }
MysqlParser class >> reduceTable [
^#(
	#(154 0 #reduceActionFor_Statement__statement_______semicolon___1: 399361 false) 
	#(151 1 #reduceActionForFile1: 357377 false) 
	#(155 0 #nil 476161 false) 
	#(154 2 #reduceActionFor_Statement__statement_______semicolon___2: 399362 false) 
	#(152 2 #reduceActionForStatements1: 385025 false) 
	#(155 1 #liftFirstValue: 476162 false) 
	#(153 2 #reduceActionFor_Statement__statement_______semicolon__1: 399361 false) 
	#(245 1 #liftFirstValue: 12836865 false) 
	#(159 0 #reduceActionForpartition_options_1: 1135617 false) 
	#(161 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 1157121 false) 
	#(210 0 #reduceActionFor_Statement__statement_______semicolon___1: 7244801 false) 
	#(159 1 #reduceActionForFile1: 1135618 false) 
	#(167 0 #nil 2454529 false) 
	#(246 1 #liftFirstValue: 12859393 false) 
	#(158 0 #reduceActionFor_Statement__statement_______semicolon___1: 730113 false) 
	#(163 1 #reduceActionForcreate_definition57: 1561657 false) 
	#(247 1 #liftFirstValue: 12881924 false) 
	#(247 1 #liftFirstValue: 12881921 false) 
	#(247 1 #liftFirstValue: 12881922 false) 
	#(247 1 #liftFirstValue: 12881923 false) 
	#(265 1 #liftFirstValue: 13603841 false) 
	#(211 2 #reduceActionFortable_option1: 7286785 false) 
	#(265 1 #liftFirstValue: 13603842 false) 
	#(211 2 #reduceActionFortable_option3: 7286787 false) 
	#(211 2 #reduceActionFortable_option5: 7286789 false) 
	#(250 1 #liftFirstValue: 13064193 false) 
	#(211 2 #reduceActionFortable_option9: 7286793 false) 
	#(211 2 #reduceActionFortable_option15: 7286799 false) 
	#(211 2 #reduceActionFortable_option15: 7286800 false) 
	#(252 1 #liftFirstValue: 13121537 false) 
	#(211 2 #reduceActionFortable_option19: 7286803 false) 
	#(211 2 #reduceActionFortable_option23: 7286807 false) 
	#(211 2 #reduceActionFortable_option26: 7286810 false) 
	#(211 2 #reduceActionFortable_option26: 7286811 false) 
	#(211 2 #reduceActionFortable_option26: 7286809 false) 
	#(211 2 #reduceActionFortable_option31: 7286815 false) 
	#(211 2 #reduceActionFortable_option37: 7286821 false) 
	#(211 2 #reduceActionFortable_option37: 7286822 false) 
	#(211 2 #reduceActionFortable_option42: 7286826 false) 
	#(211 2 #reduceActionFortable_option42: 7286825 false) 
	#(249 1 #liftFirstValue: 13029377 false) 
	#(211 2 #reduceActionFortable_option45: 7286829 false) 
	#(211 2 #reduceActionFortable_option47: 7286831 false) 
	#(211 2 #reduceActionFortable_option50: 7286834 false) 
	#(211 2 #reduceActionFortable_option50: 7286835 false) 
	#(211 2 #reduceActionFortable_option50: 7286833 false) 
	#(211 2 #reduceActionFortable_option55: 7286839 false) 
	#(156 5 #reduceActionForCreateTable33: 507937 false) 
	#(211 2 #reduceActionFortable_option57: 7286841 false) 
	#(211 2 #reduceActionFortable_option59: 7286843 false) 
	#(211 2 #reduceActionFortable_option61: 7286845 false) 
	#(211 2 #reduceActionFortable_option61: 7286846 false) 
	#(211 2 #reduceActionFortable_option61: 7286847 false) 
	#(214 2 #reduceActionForpartition_options1: 9865217 false) 
	#(215 0 #nil 10032129 false) 
	#(211 2 #reduceActionFortable_option67: 7286851 false) 
	#(211 2 #reduceActionFortable_option74: 7286858 false) 
	#(211 2 #reduceActionFortable_option74: 7286856 false) 
	#(211 2 #reduceActionFortable_option74: 7286853 false) 
	#(211 2 #reduceActionFortable_option74: 7286854 false) 
	#(211 2 #reduceActionFortable_option74: 7286855 false) 
	#(211 2 #reduceActionFortable_option74: 7286857 false) 
	#(211 2 #reduceActionFortable_option81: 7286865 false) 
	#(211 2 #reduceActionFortable_option84: 7286868 false) 
	#(211 2 #reduceActionFortable_option84: 7286869 false) 
	#(211 2 #reduceActionFortable_option84: 7286867 false) 
	#(211 2 #reduceActionFortable_option84: 7286874 false) 
	#(211 2 #reduceActionFortable_option84: 7286875 false) 
	#(211 2 #reduceActionFortable_option84: 7286873 false) 
	#(211 2 #reduceActionFortable_option84: 7286879 false) 
	#(211 2 #reduceActionFortable_option97: 7286881 false) 
	#(261 1 #liftFirstValue: 13449217 false) 
	#(160 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 1157121 false) 
	#(160 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__2: 1157122 false) 
	#(161 1 #reduceActionForFile1: 1157122 false) 
	#(162 0 #nil 1213441 false) 
	#(208 2 #reduceActionFortable_options1: 7204865 false) 
	#(259 1 #liftFirstValue: 13379585 false) 
	#(248 1 #liftFirstValue: 13004801 false) 
	#(168 0 #reduceActionForindex_type_1: 2479105 false) 
	#(167 1 #liftFirstValue: 2454530 false) 
	#(199 1 #liftFirstValue: 5342209 false) 
	#(199 1 #liftFirstValue: 5342210 false) 
	#(199 1 #liftFirstValue: 5342211 false) 
	#(199 1 #liftFirstValue: 5342212 false) 
	#(199 1 #liftFirstValue: 5342213 false) 
	#(199 1 #liftFirstValue: 5342214 false) 
	#(199 1 #liftFirstValue: 5342215 false) 
	#(199 1 #liftFirstValue: 5342216 false) 
	#(199 1 #liftFirstValue: 5342217 false) 
	#(199 1 #liftFirstValue: 5342218 false) 
	#(199 1 #liftFirstValue: 5342219 false) 
	#(199 1 #liftFirstValue: 5342220 false) 
	#(199 1 #liftFirstValue: 5342221 false) 
	#(199 1 #liftFirstValue: 5342222 false) 
	#(199 1 #liftFirstValue: 5342223 false) 
	#(199 1 #liftFirstValue: 5342224 false) 
	#(199 1 #liftFirstValue: 5342225 false) 
	#(199 1 #liftFirstValue: 5342226 false) 
	#(199 1 #liftFirstValue: 5342227 false) 
	#(199 1 #liftFirstValue: 5342228 false) 
	#(199 1 #liftFirstValue: 5342229 false) 
	#(163 2 #reduceActionForcreate_definition1: 1561601 false) 
	#(173 0 #reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen____1: 3148801 false) 
	#(197 0 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName_____1: 4786177 false) 
	#(211 3 #reduceActionFortable_option2: 7286786 false) 
	#(211 3 #reduceActionFortable_option4: 7286788 false) 
	#(211 3 #reduceActionFortable_option6: 7286790 false) 
	#(211 3 #reduceActionFortable_option7: 7286791 false) 
	#(211 3 #reduceActionFortable_option10: 7286794 false) 
	#(211 3 #reduceActionFortable_option17: 7286801 false) 
	#(211 3 #reduceActionFortable_option17: 7286802 false) 
	#(211 3 #reduceActionFortable_option20: 7286804 false) 
	#(211 3 #reduceActionFortable_option24: 7286808 false) 
	#(211 3 #reduceActionFortable_option29: 7286813 false) 
	#(211 3 #reduceActionFortable_option29: 7286814 false) 
	#(211 3 #reduceActionFortable_option29: 7286812 false) 
	#(211 3 #reduceActionFortable_option32: 7286816 false) 
	#(211 3 #reduceActionFortable_option33: 7286817 false) 
	#(211 3 #reduceActionFortable_option13: 7286797 false) 
	#(211 3 #reduceActionFortable_option21: 7286805 false) 
	#(211 3 #reduceActionFortable_option39: 7286823 false) 
	#(211 3 #reduceActionFortable_option39: 7286824 false) 
	#(211 3 #reduceActionFortable_option44: 7286828 false) 
	#(211 3 #reduceActionFortable_option44: 7286827 false) 
	#(211 3 #reduceActionFortable_option46: 7286830 false) 
	#(211 3 #reduceActionFortable_option48: 7286832 false) 
	#(211 3 #reduceActionFortable_option35: 7286819 false) 
	#(211 3 #reduceActionFortable_option53: 7286837 false) 
	#(211 3 #reduceActionFortable_option53: 7286838 false) 
	#(211 3 #reduceActionFortable_option53: 7286836 false) 
	#(211 3 #reduceActionFortable_option56: 7286840 false) 
	#(211 3 #reduceActionFortable_option58: 7286842 false) 
	#(211 3 #reduceActionFortable_option60: 7286844 false) 
	#(211 3 #reduceActionFortable_option64: 7286848 false) 
	#(211 3 #reduceActionFortable_option64: 7286849 false) 
	#(211 3 #reduceActionFortable_option64: 7286850 false) 
	#(215 1 #liftFirstValue: 10032130 false) 
	#(211 3 #reduceActionFortable_option68: 7286852 false) 
	#(211 3 #reduceActionFortable_option80: 7286864 false) 
	#(211 3 #reduceActionFortable_option80: 7286862 false) 
	#(211 3 #reduceActionFortable_option80: 7286859 false) 
	#(211 3 #reduceActionFortable_option80: 7286860 false) 
	#(211 3 #reduceActionFortable_option80: 7286861 false) 
	#(211 3 #reduceActionFortable_option80: 7286863 false) 
	#(211 3 #reduceActionFortable_option82: 7286866 false) 
	#(211 3 #reduceActionFortable_option87: 7286871 false) 
	#(211 3 #reduceActionFortable_option87: 7286872 false) 
	#(211 3 #reduceActionFortable_option87: 7286870 false) 
	#(211 3 #reduceActionFortable_option87: 7286877 false) 
	#(211 3 #reduceActionFortable_option87: 7286878 false) 
	#(211 3 #reduceActionFortable_option87: 7286876 false) 
	#(211 3 #reduceActionFortable_option87: 7286880 false) 
	#(213 0 #reduceActionFor_Statement__statement_______semicolon___1: 9802753 false) 
	#(162 1 #liftFirstValue: 1213442 false) 
	#(210 2 #reduceActionFor_Statement__statement_______semicolon___2: 7244802 false) 
	#(209 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 7244801 false) 
	#(156 6 #reduceActionForCreateTable37: 507941 false) 
	#(254 1 #liftFirstValue: 13204481 false) 
	#(165 0 #reduceActionFor______comma__key_part__1: 1754113 false) 
	#(200 1 #reduceActionForkey_part1: 5632001 false) 
	#(201 2 #reduceActionForindex_type1: 5819393 false) 
	#(201 2 #reduceActionForindex_type2: 5819394 false) 
	#(156 7 #reduceActionForCreateTable34: 507938 false) 
	#(168 1 #reduceActionForFile1: 2479106 false) 
	#(156 7 #reduceActionForCreateTable1: 507905 false) 
	#(158 2 #reduceActionFor_Statement__statement_______semicolon___2: 730114 false) 
	#(173 1 #reduceActionForFile1: 3148802 false) 
	#(175 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3260417 false) 
	#(197 1 #reduceActionForFile1: 4786178 false) 
	#(195 2 #reduceActionFordata_type1: 4594689 false) 
	#(247 3 #liftFirstValue: 12881925 false) 
	#(211 4 #reduceActionFortable_option8: 7286792 false) 
	#(211 4 #reduceActionFortable_option34: 7286818 false) 
	#(211 4 #reduceActionFortable_option11: 7286795 false) 
	#(211 4 #reduceActionFortable_option14: 7286798 false) 
	#(211 4 #reduceActionFortable_option22: 7286806 false) 
	#(211 4 #reduceActionFortable_option36: 7286820 false) 
	#(217 0 #reduceActionForindex_type_1: 10074113 false) 
	#(211 4 #reduceActionFortable_option98: 7286882 false) 
	#(211 4 #reduceActionFortable_option99: 7286883 false) 
	#(156 7 #reduceActionForCreateTable17: 507921 false) 
	#(253 1 #liftFirstValue: 13157377 false) 
	#(209 2 #reduceActionFor______comma___table_option__option__2: 7244802 false) 
	#(156 8 #reduceActionForCreateTable35: 507939 false) 
	#(203 4 #reduceActionForcheck_constraint_definition1: 6374401 false) 
	#(170 0 #reduceActionFor_Statement__statement_______semicolon___1: 2781185 false) 
	#(200 2 #reduceActionForkey_part2: 5632002 false) 
	#(200 2 #reduceActionForkey_part2: 5632003 false) 
	#(156 8 #reduceActionForCreateTable3: 507907 false) 
	#(156 8 #reduceActionForCreateTable2: 507906 false) 
	#(157 2 #reduceActionFor_Statement__statement_______semicolon__1: 730113 false) 
	#(195 3 #reduceActionFordata_type13: 4594701 false) 
	#(198 1 #reduceActionForenum_values1: 5254145 false) 
	#(174 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__2: 3260418 false) 
	#(174 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3260417 false) 
	#(175 1 #reduceActionForFile1: 3260418 false) 
	#(176 0 #nil 3322881 false) 
	#(196 2 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____5: 4786181 false) 
	#(195 3 #reduceActionFordata_type3: 4594691 false) 
	#(195 3 #reduceActionFordata_type2: 4594690 false) 
	#(211 5 #reduceActionFortable_option12: 7286796 false) 
	#(217 1 #reduceActionForFile1: 10074114 false) 
	#(211 5 #reduceActionFortable_option100: 7286884 false) 
	#(213 2 #reduceActionFor_Statement__statement_______semicolon___2: 9802754 false) 
	#(156 8 #reduceActionForCreateTable18: 507922 false) 
	#(156 8 #reduceActionForCreateTable38: 507942 false) 
	#(156 8 #reduceActionForCreateTable9: 507913 false) 
	#(156 8 #reduceActionForCreateTable25: 507929 false) 
	#(203 5 #reduceActionForcheck_constraint_definition2: 6374402 false) 
	#(203 5 #reduceActionForcheck_constraint_definition4: 6374404 false) 
	#(200 3 #reduceActionForkey_part7: 5632007 false) 
	#(166 0 #nil 2038785 false) 
	#(165 2 #reduceActionFor______comma__key_part__2: 1754114 false) 
	#(251 1 #liftFirstValue: 13097985 false) 
	#(163 5 #reduceActionForcreate_definition2: 1561602 false) 
	#(163 5 #reduceActionForcreate_definition10: 1561610 false) 
	#(156 9 #reduceActionForCreateTable4: 507908 false) 
	#(195 4 #reduceActionFordata_type18: 4594706 false) 
	#(172 3 #reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen___1: 3148801 false) 
	#(176 1 #liftFirstValue: 3322882 false) 
	#(178 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3362817 false) 
	#(196 3 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____1: 4786177 false) 
	#(196 3 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____7: 4786183 false) 
	#(195 4 #reduceActionFordata_type4: 4594692 false) 
	#(214 6 #reduceActionForpartition_options2: 9865218 false) 
	#(219 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 10494977 false) 
	#(214 6 #reduceActionForpartition_options5: 9865221 false) 
	#(212 2 #reduceActionFor_Statement__statement_______semicolon__1: 9802753 false) 
	#(211 6 #reduceActionFortable_option101: 7286885 false) 
	#(156 9 #reduceActionForCreateTable39: 507943 false) 
	#(156 9 #reduceActionForCreateTable11: 507915 false) 
	#(156 9 #reduceActionForCreateTable10: 507914 false) 
	#(156 9 #reduceActionForCreateTable26: 507930 false) 
	#(156 10 #reduceActionForCreateTable36: 507940 false) 
	#(156 10 #reduceActionForCreateTable5: 507909 false) 
	#(156 10 #reduceActionForCreateTable21: 507925 false) 
	#(203 6 #reduceActionForcheck_constraint_definition3: 6374403 false) 
	#(203 6 #reduceActionForcheck_constraint_definition5: 6374405 false) 
	#(203 6 #reduceActionForcheck_constraint_definition7: 6374407 false) 
	#(170 2 #reduceActionFor_Statement__statement_______semicolon___2: 2781186 false) 
	#(200 4 #reduceActionForkey_part8: 5632008 false) 
	#(200 4 #reduceActionForkey_part8: 5632009 false) 
	#(202 1 #reduceActionForindex_option7: 5903367 false) 
	#(202 1 #reduceActionForindex_option6: 5903366 false) 
	#(163 6 #reduceActionForcreate_definition18: 1561618 false) 
	#(202 1 #reduceActionForindex_option3: 5903363 false) 
	#(166 1 #liftFirstValue: 2038786 false) 
	#(164 2 #reduceActionFor______comma__key_part_1: 1754113 false) 
	#(200 4 #reduceActionForkey_part4: 5632004 false) 
	#(163 6 #reduceActionForcreate_definition3: 1561603 false) 
	#(163 6 #reduceActionForcreate_definition4: 1561604 false) 
	#(163 6 #reduceActionForcreate_definition6: 1561606 false) 
	#(163 6 #reduceActionForcreate_definition11: 1561611 false) 
	#(163 6 #reduceActionForcreate_definition12: 1561612 false) 
	#(163 6 #reduceActionForcreate_definition14: 1561614 false) 
	#(163 6 #reduceActionForcreate_definition30: 1561630 false) 
	#(163 6 #reduceActionForcreate_definition24: 1561624 false) 
	#(198 3 #reduceActionForenum_values2: 5254146 false) 
	#(184 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3499009 false) 
	#(177 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3362817 false) 
	#(178 1 #reduceActionForFile1: 3362818 false) 
	#(180 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3407873 false) 
	#(195 5 #reduceActionFordata_type5: 4594693 false) 
	#(196 4 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____3: 4786179 false) 
	#(196 4 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____6: 4786182 false) 
	#(214 7 #reduceActionForpartition_options3: 9865219 false) 
	#(219 1 #reduceActionForFile1: 10494978 false) 
	#(214 7 #reduceActionForpartition_options6: 9865222 false) 
	#(216 3 #reduceActionFor__ALGORITHM___algorithmToken_______equals____1___value_____2___value___1: 10074113 false) 
	#(216 3 #reduceActionFor__ALGORITHM___algorithmToken_______equals____1___value_____2___value___1: 10074114 false) 
	#(156 10 #reduceActionForCreateTable12: 507916 false) 
	#(156 11 #reduceActionForCreateTable7: 507911 false) 
	#(156 11 #reduceActionForCreateTable6: 507910 false) 
	#(156 11 #reduceActionForCreateTable22: 507926 false) 
	#(203 7 #reduceActionForcheck_constraint_definition6: 6374406 false) 
	#(163 7 #reduceActionForcreate_definition34: 1561634 false) 
	#(203 7 #reduceActionForcheck_constraint_definition8: 6374408 false) 
	#(163 7 #reduceActionForcreate_definition51: 1561651 false) 
	#(169 2 #reduceActionFor_Statement__statement_______semicolon__1: 2781185 false) 
	#(202 2 #reduceActionForindex_option5: 5903365 false) 
	#(202 2 #reduceActionForindex_option8: 5903368 false) 
	#(202 2 #reduceActionForindex_option1: 5903361 false) 
	#(202 2 #reduceActionForindex_option10: 5903370 false) 
	#(200 5 #reduceActionForkey_part5: 5632005 false) 
	#(200 5 #reduceActionForkey_part5: 5632006 false) 
	#(163 7 #reduceActionForcreate_definition20: 1561620 false) 
	#(163 7 #reduceActionForcreate_definition22: 1561622 false) 
	#(163 7 #reduceActionForcreate_definition19: 1561619 false) 
	#(163 7 #reduceActionForcreate_definition5: 1561605 false) 
	#(163 7 #reduceActionForcreate_definition7: 1561607 false) 
	#(163 7 #reduceActionForcreate_definition8: 1561608 false) 
	#(163 7 #reduceActionForcreate_definition13: 1561613 false) 
	#(163 7 #reduceActionForcreate_definition15: 1561615 false) 
	#(163 7 #reduceActionForcreate_definition16: 1561616 false) 
	#(163 7 #reduceActionForcreate_definition31: 1561631 false) 
	#(163 7 #reduceActionForcreate_definition32: 1561632 false) 
	#(163 7 #reduceActionForcreate_definition26: 1561626 false) 
	#(163 7 #reduceActionForcreate_definition28: 1561628 false) 
	#(163 7 #reduceActionForcreate_definition25: 1561625 false) 
	#(156 11 #reduceActionForCreateTable19: 507923 false) 
	#(184 1 #reduceActionForFile1: 3499010 false) 
	#(195 6 #reduceActionFordata_type16: 4594704 false) 
	#(172 5 #reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen___2: 3148802 false) 
	#(177 2 #reduceActionFor_Statement__statement_______semicolon__1: 3362818 false) 
	#(179 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3407873 false) 
	#(180 1 #reduceActionForFile1: 3407874 false) 
	#(182 0 #nil 3457025 false) 
	#(195 6 #reduceActionFordata_type7: 4594695 false) 
	#(195 6 #reduceActionFordata_type6: 4594694 false) 
	#(196 5 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____2: 4786178 false) 
	#(196 5 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____8: 4786184 false) 
	#(262 1 #liftFirstValue: 13495297 false) 
	#(218 2 #reduceActionFor_Statement__statement_______semicolon__1: 10494977 false) 
	#(258 3 #reduceActionForcolumn_list1: 13301761 false) 
	#(214 8 #reduceActionForpartition_options4: 9865220 false) 
	#(156 11 #reduceActionForCreateTable40: 507944 false) 
	#(156 11 #reduceActionForCreateTable13: 507917 false) 
	#(156 11 #reduceActionForCreateTable29: 507933 false) 
	#(156 12 #reduceActionForCreateTable8: 507912 false) 
	#(163 8 #reduceActionForcreate_definition53: 1561653 false) 
	#(163 8 #reduceActionForcreate_definition35: 1561635 false) 
	#(163 8 #reduceActionForcreate_definition36: 1561636 false) 
	#(203 8 #reduceActionForcheck_constraint_definition9: 6374409 false) 
	#(163 8 #reduceActionForcreate_definition38: 1561638 false) 
	#(163 8 #reduceActionForcreate_definition52: 1561652 false) 
	#(202 3 #reduceActionForindex_option9: 5903369 false) 
	#(202 3 #reduceActionForindex_option2: 5903362 false) 
	#(202 3 #reduceActionForindex_option11: 5903371 false) 
	#(260 1 #liftFirstValue: 13416449 false) 
	#(202 3 #reduceActionForindex_option4: 5903364 false) 
	#(163 8 #reduceActionForcreate_definition21: 1561621 false) 
	#(163 8 #reduceActionForcreate_definition23: 1561623 false) 
	#(163 8 #reduceActionForcreate_definition9: 1561609 false) 
	#(163 8 #reduceActionForcreate_definition17: 1561617 false) 
	#(163 8 #reduceActionForcreate_definition33: 1561633 false) 
	#(163 8 #reduceActionForcreate_definition27: 1561627 false) 
	#(163 8 #reduceActionForcreate_definition29: 1561629 false) 
	#(163 8 #reduceActionForcreate_definition42: 1561642 false) 
	#(156 12 #reduceActionForCreateTable20: 507924 false) 
	#(195 7 #reduceActionFordata_type21: 4594709 false) 
	#(195 7 #reduceActionFordata_type14: 4594702 false) 
	#(195 7 #reduceActionFordata_type17: 4594705 false) 
	#(183 2 #reduceActionFor_Statement__statement_______semicolon__1: 3499009 false) 
	#(179 2 #reduceActionFor______comma___table_option__option__2: 3407874 false) 
	#(182 1 #liftFirstValue: 3457026 false) 
	#(195 7 #reduceActionFordata_type8: 4594696 false) 
	#(195 7 #reduceActionFordata_type9: 4594697 false) 
	#(196 6 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____4: 4786180 false) 
	#(156 12 #reduceActionForCreateTable15: 507919 false) 
	#(156 12 #reduceActionForCreateTable14: 507918 false) 
	#(156 12 #reduceActionForCreateTable30: 507934 false) 
	#(156 12 #reduceActionForCreateTable27: 507931 false) 
	#(163 9 #reduceActionForcreate_definition54: 1561654 false) 
	#(163 9 #reduceActionForcreate_definition37: 1561637 false) 
	#(163 9 #reduceActionForcreate_definition45: 1561645 false) 
	#(163 9 #reduceActionForcreate_definition55: 1561655 false) 
	#(163 9 #reduceActionForcreate_definition39: 1561639 false) 
	#(163 9 #reduceActionForcreate_definition40: 1561640 false) 
	#(163 9 #reduceActionForcreate_definition43: 1561643 false) 
	#(163 9 #reduceActionForcreate_definition44: 1561644 false) 
	#(195 8 #reduceActionFordata_type19: 4594707 false) 
	#(195 8 #reduceActionFordata_type22: 4594710 false) 
	#(195 8 #reduceActionFordata_type15: 4594703 false) 
	#(181 2 #liftFirstValue: 3457025 false) 
	#(186 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3561473 false) 
	#(195 8 #reduceActionFordata_type11: 4594699 false) 
	#(195 8 #reduceActionFordata_type10: 4594698 false) 
	#(156 13 #reduceActionForCreateTable16: 507920 false) 
	#(156 13 #reduceActionForCreateTable28: 507932 false) 
	#(156 14 #reduceActionForCreateTable23: 507927 false) 
	#(163 10 #reduceActionForcreate_definition46: 1561646 false) 
	#(163 10 #reduceActionForcreate_definition47: 1561647 false) 
	#(163 10 #reduceActionForcreate_definition56: 1561656 false) 
	#(163 10 #reduceActionForcreate_definition41: 1561641 false) 
	#(163 10 #reduceActionForcreate_definition48: 1561648 false) 
	#(195 9 #reduceActionFordata_type20: 4594708 false) 
	#(186 1 #reduceActionForFile1: 3561474 false) 
	#(188 0 #reduceActionForindex_type_1: 3684353 false) 
	#(195 9 #reduceActionFordata_type12: 4594700 false) 
	#(156 15 #reduceActionForCreateTable24: 507928 false) 
	#(163 11 #reduceActionForcreate_definition49: 1561649 false) 
	#(163 11 #reduceActionForcreate_definition50: 1561650 false) 
	#(193 0 #reduceActionForreference_definition_1: 3955713 false) 
	#(185 2 #reduceActionFor_Statement__statement_______semicolon__1: 3561475 false) 
	#(185 2 #reduceActionFor_Statement__statement_______semicolon__1: 3561474 false) 
	#(185 2 #reduceActionFor_Statement__statement_______semicolon__1: 3561473 false) 
	#(188 1 #reduceActionForFile1: 3684354 false) 
	#(190 0 #reduceActionForindex_type_1: 3774465 false) 
	#(156 15 #reduceActionForCreateTable31: 507935 false) 
	#(206 0 #reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option__1: 6938625 false) 
	#(194 0 #reduceActionForcheck_constraint_definition_1: 3980289 false) 
	#(193 1 #reduceActionForFile1: 3955714 false) 
	#(187 2 #reduceActionForindex_type1: 3684353 false) 
	#(190 1 #reduceActionForFile1: 3774466 false) 
	#(192 0 #reduceActionForindex_type_1: 3877889 false) 
	#(156 16 #reduceActionForCreateTable32: 507936 false) 
	#(206 1 #reduceActionForFile1: 6938626 false) 
	#(204 7 #reduceActionForreference_definition1: 6587393 false) 
	#(171 12 #reduceActionForcolumn_definition13: 2946061 false) 
	#(194 1 #reduceActionForFile1: 3980290 false) 
	#(171 12 #reduceActionForcolumn_definition10: 2946058 false) 
	#(187 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 3684354 false) 
	#(189 2 #reduceActionForindex_type1: 3774465 false) 
	#(192 1 #reduceActionForFile1: 3877890 false) 
	#(221 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 10868737 false) 
	#(171 13 #reduceActionForcolumn_definition15: 2946063 false) 
	#(171 13 #reduceActionForcolumn_definition12: 2946060 false) 
	#(189 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 3774466 false) 
	#(191 2 #reduceActionForindex_type1: 3877889 false) 
	#(191 2 #reduceActionForindex_type2: 3877890 false) 
	#(221 1 #reduceActionForFile1: 10868738 false) 
	#(204 9 #reduceActionForreference_definition3: 6587395 false) 
	#(204 9 #reduceActionForreference_definition5: 6587397 false) 
	#(204 9 #reduceActionForreference_definition7: 6587399 false) 
	#(207 1 #reduceActionForreference_option2: 7001090 false) 
	#(207 1 #reduceActionForreference_option1: 7001089 false) 
	#(205 3 #reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option_1: 6938625 false) 
	#(171 14 #reduceActionForcolumn_definition14: 2946062 false) 
	#(171 14 #reduceActionForcolumn_definition11: 2946059 false) 
	#(171 14 #reduceActionForcolumn_definition25: 2946073 false) 
	#(171 14 #reduceActionForcolumn_definition22: 2946070 false) 
	#(171 14 #reduceActionForcolumn_definition19: 2946067 false) 
	#(171 14 #reduceActionForcolumn_definition16: 2946064 false) 
	#(171 14 #reduceActionForcolumn_definition1: 2946049 false) 
	#(220 2 #reduceActionFor_Statement__statement_______semicolon__1: 10868737 false) 
	#(207 2 #reduceActionForreference_option4: 7001092 false) 
	#(207 2 #reduceActionForreference_option5: 7001093 false) 
	#(207 2 #reduceActionForreference_option3: 7001091 false) 
	#(204 10 #reduceActionForreference_definition2: 6587394 false) 
	#(171 15 #reduceActionForcolumn_definition27: 2946075 false) 
	#(171 15 #reduceActionForcolumn_definition24: 2946072 false) 
	#(171 15 #reduceActionForcolumn_definition21: 2946069 false) 
	#(171 15 #reduceActionForcolumn_definition18: 2946066 false) 
	#(171 15 #reduceActionForcolumn_definition7: 2946055 false) 
	#(223 0 #reduceActionFor_Statement__statement_______semicolon___1: 10988545 false) 
	#(171 16 #reduceActionForcolumn_definition26: 2946074 false) 
	#(171 16 #reduceActionForcolumn_definition23: 2946071 false) 
	#(171 16 #reduceActionForcolumn_definition31: 2946079 false) 
	#(171 16 #reduceActionForcolumn_definition28: 2946076 false) 
	#(171 16 #reduceActionForcolumn_definition2: 2946050 false) 
	#(171 16 #reduceActionForcolumn_definition20: 2946068 false) 
	#(171 16 #reduceActionForcolumn_definition17: 2946065 false) 
	#(171 16 #reduceActionForcolumn_definition4: 2946052 false) 
	#(226 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 11389953 false) 
	#(263 1 #liftFirstValue: 13515777 false) 
	#(204 12 #reduceActionForreference_definition4: 6587396 false) 
	#(204 12 #reduceActionForreference_definition6: 6587398 false) 
	#(204 12 #reduceActionForreference_definition8: 6587400 false) 
	#(171 17 #reduceActionForcolumn_definition33: 2946081 false) 
	#(171 17 #reduceActionForcolumn_definition30: 2946078 false) 
	#(171 17 #reduceActionForcolumn_definition8: 2946056 false) 
	#(226 1 #reduceActionForFile1: 11389954 false) 
	#(228 0 #reduceActionForindex_type_1: 11485185 false) 
	#(214 19 #reduceActionForpartition_options7: 9865223 false) 
	#(223 2 #reduceActionFor_Statement__statement_______semicolon___2: 10988546 false) 
	#(171 18 #reduceActionForcolumn_definition32: 2946080 false) 
	#(171 18 #reduceActionForcolumn_definition29: 2946077 false) 
	#(171 18 #reduceActionForcolumn_definition3: 2946051 false) 
	#(171 18 #reduceActionForcolumn_definition5: 2946053 false) 
	#(214 20 #reduceActionForpartition_options8: 9865224 false) 
	#(225 2 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__1: 11389953 false) 
	#(228 1 #reduceActionForFile1: 11485186 false) 
	#(230 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 11555841 false) 
	#(222 2 #reduceActionFor_Statement__statement_______semicolon__1: 10988545 false) 
	#(214 20 #reduceActionForpartition_options9: 9865225 false) 
	#(171 19 #reduceActionForcolumn_definition9: 2946057 false) 
	#(225 3 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__2: 11389954 false) 
	#(225 3 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__3: 11389955 false) 
	#(255 0 #reduceActionFor_Statement__statement_______semicolon___1: 13239298 false) 
	#(227 2 #reduceActionForindex_type1: 11485185 false) 
	#(230 1 #reduceActionForFile1: 11555842 false) 
	#(232 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 11656193 false) 
	#(214 21 #reduceActionForpartition_options10: 9865226 false) 
	#(171 20 #reduceActionForcolumn_definition6: 2946054 false) 
	#(225 4 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__4: 11389956 false) 
	#(257 0 #reduceActionFor_Statement__statement_______semicolon___1: 13266945 false) 
	#(227 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11485186 false) 
	#(232 1 #reduceActionForFile1: 11656194 false) 
	#(234 0 #reduceActionForindex_type_1: 11759617 false) 
	#(255 2 #reduceActionForvalue_list1: 13239297 false) 
	#(229 3 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__1: 11555841 false) 
	#(234 1 #reduceActionForFile1: 11759618 false) 
	#(236 0 #reduceActionForindex_type_1: 11832321 false) 
	#(257 2 #reduceActionFor_Statement__statement_______semicolon___2: 13266946 false) 
	#(229 4 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__2: 11555842 false) 
	#(231 3 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__1: 11656193 false) 
	#(233 2 #reduceActionForindex_type1: 11759617 false) 
	#(236 1 #reduceActionForFile1: 11832322 false) 
	#(238 0 #reduceActionForindex_type_1: 11905025 false) 
	#(256 2 #reduceActionFor_Statement__statement_______semicolon__1: 13266945 false) 
	#(231 4 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__2: 11656194 false) 
	#(233 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11759618 false) 
	#(235 2 #reduceActionForindex_type1: 11832321 false) 
	#(238 1 #reduceActionForFile1: 11905026 false) 
	#(240 0 #reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen___1: 11996161 false) 
	#(235 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11832322 false) 
	#(237 2 #reduceActionForindex_type1: 11905025 false) 
	#(240 1 #reduceActionForFile1: 11996162 false) 
	#(224 10 #reduceActionForpartition_definition1: 11062273 false) 
	#(237 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11905026 false) 
	#(242 0 #reduceActionFor_Statement__statement_______semicolon___1: 12051457 false) 
	#(264 1 #liftFirstValue: 13560833 false) 
	#(244 0 #nil 12352513 false) 
	#(239 4 #reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen__1: 11996161 false) 
	#(242 2 #reduceActionFor_Statement__statement_______semicolon___2: 12051458 false) 
	#(224 14 #reduceActionForpartition_definition4: 11062276 false) 
	#(244 1 #liftFirstValue: 12352514 false) 
	#(241 2 #reduceActionFor_Statement__statement_______semicolon__1: 12051457 false) 
	#(224 15 #reduceActionForpartition_definition5: 11062277 false) 
	#(224 15 #reduceActionForpartition_definition2: 11062274 false) 
	#(224 15 #reduceActionForpartition_definition3: 11062275 false) 
	#(243 7 #reduceActionForsubpartition_definition1: 12132353 false) 
	#(243 9 #reduceActionForsubpartition_definition3: 12132355 false) 
	#(243 10 #reduceActionForsubpartition_definition2: 12132354 false) 
	#(243 10 #reduceActionForsubpartition_definition5: 12132357 false) 
	#(243 10 #reduceActionForsubpartition_definition7: 12132359 false) 
	#(243 11 #reduceActionForsubpartition_definition9: 12132361 false) 
	#(243 12 #reduceActionForsubpartition_definition4: 12132356 false) 
	#(243 13 #reduceActionForsubpartition_definition6: 12132358 false) 
	#(243 13 #reduceActionForsubpartition_definition8: 12132360 false) 
	#(243 14 #reduceActionForsubpartition_definition10: 12132362 false)
	).
]

{ #category : #generated }
MysqlParser class >> scannerClass [
	^MysqlScanner
]

{ #category : #generated }
MysqlParser class >> startingStateForFile [
	^ 1
]

{ #category : #generated }
MysqlParser class >> symbolNames [
	^ #('"''LZ4''"' '"''N''"' '"''NONE''"' '"''Y''"' '"''ZLIB''"' '"("' '")"' '","' '"0"' '"1"' '"2"' '";"' '"="' '"ACTION"' '"ALGORITHM"' '"ALWAYS"' '"AS"' '"ASC"' '"AUTOEXTEND_SIZE"' '"AUTO_INCREMENT"' '"AVG_ROW_LENGTH"' '"BIGINT"' '"BLOB"' '"BTREE"' '"BY"' '"CASCADE"' '"CHAR"' '"CHARACTER"' '"CHARSET"' '"CHECK"' '"CHECKSUM"' '"COLLATE"' '"COLUMNS"' '"COLUMN_FORMAT"' '"COMMENT"' '"COMPACT"' '"COMPRESSED"' '"COMPRESSION"' '"CONNECTION"' '"CONSTRAINT"' '"CREATE"' '"CURRENT_TIMESTAMP"' '"DATA"' '"DATE"' '"DATETIME"' '"DECIMAL"' '"DEFAULT"' '"DELAY_KEY_WRITE"' '"DELETE"' '"DESC"' '"DIRECTORY"' '"DISK"' '"DOUBLE"' '"DYNAMIC"' '"ENCRYPTION"' '"ENFORCED"' '"ENGINE"' '"ENGINE_ATTRIBUTE"' '"ENUM"' '"EXISTS"' '"FIRST"' '"FIXED"' '"FLOAT"' '"FOREIGN"' '"FULL"' '"FULLTEXT"' '"GENERATED"' '"HASH"' '"IF"' '"IGNORE"' '"IN"' '"INDEX"' '"INSERT_METHOD"' '"INT"' '"INVISIBLE"' '"InnoDB"' '"JSON"' '"KEY"' '"KEY_BLOCK_SIZE"' '"LAST"' '"LESS"' '"LIKE"' '"LINEAR"' '"LIST"' '"LONGBLOB"' '"LONGTEXT"' '"MATCH"' '"MAXVALUE"' '"MAX_ROWS"' '"MEDIUMBLOB"' '"MEDIUMTEXT"' '"MEMORY"' '"MIN_ROWS"' '"NO"' '"NOT"' '"NULL"' '"ON"' '"PACK_KEYS"' '"PARSER"' '"PARTIAL"' '"PARTITION"' '"PARTITIONS"' '"PASSWORD"' '"PRIMARY"' '"RANGE"' '"REDUNDANT"' '"REFERENCES"' '"REPLACE"' '"RESTRICT"' '"ROW_FORMAT"' '"SECONDARY_ENGINE_ATTRIBUTE"' '"SET"' '"SIMPLE"' '"SMALLINT"' '"SPATIAL"' '"STATS_AUTO_RECALC"' '"STATS_PERSISTENT"' '"STATS_SAMPLE_PAGES"' '"STORAGE"' '"STORED"' '"SUBPARTITION"' '"SUBPARTITIONS"' '"TABLE"' '"TABLESPACE"' '"TEMPORARY"' '"TEXT"' '"THAN"' '"TIMESTAMP"' '"TINYINT"' '"TINYTEXT"' '"UNION"' '"UNIQUE"' '"UPDATE"' '"USING"' '"VALUES"' '"VARBINARY"' '"VARCHAR"' '"VIRTUAL"' '"VISIBLE"' '"WITH"' '"unsigned"' '"zerofill"' '<string>' '<integer>' '<number>' '<name>' '<comment>' '<whitespace>' '<simple_name>' 'B e g i n' 'File' 'Statements' '(Statement ''statement'' ";" ''semicolon'')' '(Statement ''statement'' ";" ''semicolon'')*' 'Statement' 'CreateTable' '("," ''comma'' create_definition ''definition'')' '("," ''comma'' create_definition ''definition'')*' 'partition_options?' '("IGNORE" ''ignoreToken'' | "REPLACE" ''replaceToken'')' '("IGNORE" ''ignoreToken'' | "REPLACE" ''replaceToken'')?' '"AS" ''asToken''?' 'create_definition' '("," ''comma'' key_part)' '("," ''comma'' key_part)*' 'index_option ''option''?' 'index_name ''indexName''?' 'index_type?' '("," ''comma'' col_name ''columnName'')' '("," ''comma'' col_name ''columnName'')*' 'column_definition' '("ON" ''onToken'' "UPDATE" ''updateToken'' (literal ''value'' | "(" ''leftParen'' expr ''value'' ")" ''rightParen''))' '("ON" ''onToken'' "UPDATE" ''updateToken'' (literal ''value'' | "(" ''leftParen'' expr ''value'' ")" ''rightParen''))?' '("VISIBLE" ''visibleToken'' | "INVISIBLE" ''invisibleToken'')' '("VISIBLE" ''visibleToken'' | "INVISIBLE" ''invisibleToken'')?' '"AUTO_INCREMENT" ''autoIncrementToken''?' '("UNIQUE" ''uniqueToken'' "KEY" ''keyToken''?)' '("UNIQUE" ''uniqueToken'' "KEY" ''keyToken''?)?' '("PRIMARY" ''primaryToken''? "KEY" ''keyToken'')' '("PRIMARY" ''primaryToken''? "KEY" ''keyToken'')?' '("COMMENT" ''commentToken'' <string>)' '("COMMENT" ''commentToken'' <string>)?' '("COLLATE" ''collateToken'' collation_name ''collationName'')' '("COLLATE" ''collateToken'' collation_name ''collationName'')?' '("COLUMN_FORMAT" ''columnFormatToken'' ("FIXED" ''columnFormat'' | "DYNAMIC" ''columnFormat'' | "DEFAULT" ''columnFormat''))' '("COLUMN_FORMAT" ''columnFormatToken'' ("FIXED" ''columnFormat'' | "DYNAMIC" ''columnFormat'' | "DEFAULT" ''columnFormat''))?' '("ENGINE_ATTRIBUTE" ''engineAttributeToken'' "=" ''equals''? <string> ''engineAttribute'')' '("ENGINE_ATTRIBUTE" ''engineAttributeToken'' "=" ''equals''? <string> ''engineAttribute'')?' '("SECONDARY_ENGINE_ATTRIBUTE" ''secondaryToken'' "=" ''equals''? <string> ''secondaryEngineAttribute'')' '("SECONDARY_ENGINE_ATTRIBUTE" ''secondaryToken'' "=" ''equals''? <string> ''secondaryEngineAttribute'')?' '("STORAGE" ''storageToken'' ("DISK" ''diskToken'' | "MEMORY" ''memoryToken''))' '("STORAGE" ''storageToken'' ("DISK" ''diskToken'' | "MEMORY" ''memoryToken''))?' 'reference_definition?' 'check_constraint_definition?' 'data_type' '((("CHARACTER" ''characterToken'' "SET" ''setToken'' | "CHARSET" ''charsetToken'') "=" ''equals''? charset_name ''charsetName'') ("COLLATE" ''collateToken'' collation_name ''collationName'')?)' '((("CHARACTER" ''characterToken'' "SET" ''setToken'' | "CHARSET" ''charsetToken'') "=" ''equals''? charset_name ''charsetName'') ("COLLATE" ''collateToken'' collation_name ''collationName'')?)?' 'enum_values' 'data_type_name' 'key_part' 'index_type' 'index_option' 'check_constraint_definition' 'reference_definition' '("ON" ''onToken'' "UPDATE" ''updateToken'' reference_option)' '("ON" ''onToken'' "UPDATE" ''updateToken'' reference_option)?' 'reference_option' 'table_options' '("," ''comma''? table_option ''option'')' '("," ''comma''? table_option ''option'')*' 'table_option' '("," ''comma'' tbl_name ''tableName'')' '("," ''comma'' tbl_name ''tableName'')*' 'partition_options' '"LINEAR" ''linearToken''?' '("ALGORITHM" ''algorithmToken'' "=" ''equals'' ("1" ''value'' | "2" ''value''))' '("ALGORITHM" ''algorithmToken'' "=" ''equals'' ("1" ''value'' | "2" ''value''))?' '("PARTITIONS" ''partitionsToken'' num ''partitions'')' '("PARTITIONS" ''partitionsToken'' num ''partitions'')?' '("SUBPARTITIONS" ''subpartitionsToken'' num ''subpartitions'')' '("SUBPARTITIONS" ''subpartitionsToken'' num ''subpartitions'')?' '("," ''comma'' partition_definition ''definition'')' '("," ''comma'' partition_definition ''definition'')*' 'partition_definition' '("STORAGE" ''storageToken''? "ENGINE" ''engineToken'' "=" ''equals''? engine_name ''engineName'')' '("STORAGE" ''storageToken''? "ENGINE" ''engineToken'' "=" ''equals''? engine_name ''engineName'')?' '("COMMENT" ''commentToken'' "=" ''equals''? <string> ''comment'')' '("COMMENT" ''commentToken'' "=" ''equals''? <string> ''comment'')?' '("DATA" ''dataToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''dataDirectory'')' '("DATA" ''dataToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''dataDirectory'')?' '("INDEX" ''indexToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''indexDirectory'')' '("INDEX" ''indexToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''indexDirectory'')?' '("MAX_ROWS" ''maxRowsToken'' "=" ''equals''? <integer> ''maxRows'')' '("MAX_ROWS" ''maxRowsToken'' "=" ''equals''? <integer> ''maxRows'')?' '("MIN_ROWS" ''minRowsToken'' "=" ''equals''? <integer> ''minRows'')' '("MIN_ROWS" ''minRowsToken'' "=" ''equals''? <integer> ''minRows'')?' '("TABLESPACE" ''tableSpaceToken'' "=" ''equals''? tablespace_name ''tablespaceName'')' '("TABLESPACE" ''tableSpaceToken'' "=" ''equals''? tablespace_name ''tablespaceName'')?' '("(" ''leftParen'' subpartition_definition ''definition'' ("," ''comma'' subpartition_definition ''definition'')* ")" ''rightParen'')' '("(" ''leftParen'' subpartition_definition ''definition'' ("," ''comma'' subpartition_definition ''definition'')* ")" ''rightParen'')?' '("," ''comma'' subpartition_definition ''definition'')' '("," ''comma'' subpartition_definition ''definition'')*' 'subpartition_definition' '"=" ''equals''?' 'tbl_name' 'col_name' 'literal' 'index_name' 'engine_name' 'charset_name' 'length' 'collation_name' 'query_expression' 'expr' 'value_list' '("," ''comma'' expr ''value'')' '("," ''comma'' expr ''value'')*' 'column_list' 'symbol' 'parser_name' 'tablespace_name' 'num' 'partition_name' 'logical_name' 'value' 'E O F' 'error')
]

{ #category : #generated }
MysqlParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #MysqlFileNode #MysqlFileNode #MysqlFileNode #OrderedCollection #OrderedCollection #MysqlCreateTableNode #MysqlCreateTableNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #MysqlProgramNode #OrderedCollection #OrderedCollection #MysqlIndexOptionNode #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlDataTypeNode #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #MysqlIndexOptionNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlTableOptionNode #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlPartitionDefinitionNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlSubpartitionDefinitionNode #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode #SmaCCErrorNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCErrorNode #SmaCCToken #SmaCCErrorNode #SmaCCToken #SmaCCErrorNode #SmaCCErrorNode #Object #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
MysqlParser class >> transitionTable [
^#(
#[1 0 6 0 12 0 6 0 41 0 9 0 151 0 13 0 152 0 17 0 154 0 6 1 10] 
#[0 0 0 1 10] 
#[0 0 10 1 10] 
#[1 0 14 0 12 0 21 0 41 0 25 0 153 0 29 0 155 0 29 0 156 0 14 1 10] 
#[1 0 37 0 123 0 41 0 125] 
#[0 0 18 0 12 0 41 1 10] 
#[1 0 45 0 12 0 22 1 10] 
#[0 0 26 0 12 1 10] 
#[1 0 49 0 69 0 57 0 146 0 57 0 245] 
#[0 0 61 0 123] 
#[0 0 30 0 12 0 41 1 10] 
#[0 0 65 0 95] 
#[0 0 34 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 82 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 0 69 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 0 149 0 82 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 0 201 0 159 0 205 0 208 0 209 0 211 0 213 0 214 0 38 1 11] 
#[1 0 217 0 69 0 221 0 146 0 221 0 245] 
#[0 0 225 0 60] 
#[1 0 229 0 30 0 233 0 40 0 237 0 64 0 241 0 66 0 245 0 72 0 249 0 78 0 253 0 82 1 1 0 104 1 5 0 115 1 9 0 132 1 25 0 146 1 17 0 163 1 21 0 203 1 25 0 246] 
#[1 1 29 0 13 1 33 0 42 1 53 0 96 1 53 0 143 1 53 0 145 1 53 0 247 1 53 1 9 1 53 1 11] 
#[1 1 61 0 13 1 33 0 42 1 65 0 96 1 65 0 143 1 65 0 145 1 65 0 247 1 65 1 9 1 65 1 11] 
#[1 1 69 0 13 1 33 0 42 1 73 0 96 1 73 0 143 1 73 0 145 1 73 0 247 1 73 1 9 1 73 1 11] 
#[0 1 77 0 112] 
#[1 1 81 0 13 1 89 0 149 1 89 0 250] 
#[1 1 93 0 9 1 97 0 10 1 101 0 13] 
#[1 1 105 0 13 1 113 0 149 1 113 0 252] 
#[1 1 117 0 13 1 121 0 143] 
#[1 1 125 0 1 1 129 0 3 1 133 0 5 1 137 0 13] 
#[1 1 141 0 13 1 145 0 143] 
#[0 1 149 0 51] 
#[1 1 153 0 28 1 157 0 29 1 161 0 32] 
#[1 1 165 0 9 1 169 0 10 1 173 0 13] 
#[1 1 177 0 2 1 181 0 4 1 185 0 13] 
#[1 1 189 0 13 1 197 0 76 1 197 0 249] 
#[1 1 201 0 13 1 205 0 143] 
#[0 1 209 0 51] 
#[1 1 213 0 13 1 217 0 61 1 221 0 80 1 225 0 94] 
#[1 1 229 0 13 1 33 0 42 1 233 0 96 1 233 0 143 1 233 0 145 1 233 0 247 1 233 1 9 1 233 1 11] 
#[0 1 237 0 146 0 245] 
#[1 1 241 0 13 1 33 0 42 1 245 0 96 1 245 0 143 1 245 0 145 1 245 0 247 1 245 1 9 1 245 1 11] 
#[1 1 249 0 13 1 33 0 42 1 253 0 96 1 253 0 143 1 253 0 145 1 253 0 247 1 253 1 9 1 253 1 11] 
#[1 2 1 0 9 2 5 0 10 2 9 0 13 2 13 0 47] 
#[0 2 17 0 25] 
#[1 2 21 0 13 2 25 0 143] 
#[1 2 29 0 13 2 33 0 36 2 37 0 37 2 41 0 47 2 45 0 54 2 49 0 62 2 53 0 106] 
#[1 2 57 0 13 2 61 0 143] 
#[1 2 65 0 9 2 69 0 10 2 73 0 13 2 77 0 47] 
#[1 2 81 0 9 2 85 0 10 2 89 0 13 2 93 0 47] 
#[1 2 97 0 13 1 33 0 42 2 101 0 96 2 101 0 143 2 101 0 145 2 101 0 247 2 101 1 9 2 101 1 11] 
#[0 2 105 1 5 1 11] 
#[1 2 113 0 6 2 117 0 13] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 2 133 0 161 0 42 1 11] 
#[1 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 2 137 0 159 0 213 0 214 0 38 1 11] 
#[1 0 46 0 8 0 46 0 12 0 46 0 17 0 46 0 19 0 46 0 20 0 46 0 21 0 46 0 28 0 46 0 29 0 46 0 31 0 46 0 32 0 46 0 35 0 46 0 38 0 46 0 39 0 46 0 43 0 46 0 47 0 46 0 48 0 46 0 55 0 46 0 57 0 46 0 58 0 46 0 70 0 46 0 72 0 46 0 73 0 46 0 79 0 46 0 89 0 46 0 93 0 46 0 98 0 46 0 101 0 46 0 103 0 46 0 108 0 46 0 110 0 46 0 111 0 46 0 116 0 46 0 117 0 46 0 118 0 46 0 124 0 46 0 131 2 141 0 210 0 46 1 10 0 46 1 11] 
#[0 0 50 0 17 0 70 0 108 1 11] 
#[0 2 145 0 95] 
#[1 2 149 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 2 153 0 82 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 2 157 0 159 2 161 0 208 0 209 0 211 0 213 0 214 0 38 1 11] 
#[0 2 165 0 146 0 245] 
#[0 2 169 0 6] 
#[1 2 173 0 30 2 177 0 64 2 181 0 104 2 185 0 132 2 189 1 3 2 189 1 11] 
#[0 2 197 0 78] 
#[1 2 201 0 6 2 205 0 72 2 209 0 78 2 217 0 146 2 217 0 248] 
#[1 2 221 0 6 2 225 0 134 2 233 0 146 2 229 0 201 2 233 0 248] 
#[1 2 237 0 6 2 225 0 134 2 245 0 146 2 241 0 201 2 245 0 248] 
#[0 2 249 0 146 0 245] 
#[0 2 253 0 78] 
#[1 3 1 0 6 3 5 0 72 3 9 0 78 3 13 0 146 3 13 0 248] 
#[1 0 54 0 6 3 17 0 72 3 21 0 78 0 54 0 134 3 25 0 146 3 25 0 167 3 25 0 248] 
#[0 0 58 0 6 0 7 0 8 0 18 0 22 0 23 0 27 0 44 0 45 0 46 0 50 0 53 0 59 0 63 0 74 0 77 0 85 0 86 0 90 0 91 0 114 0 126 0 128 0 129 0 130 0 136 0 137] 
#[1 0 62 0 7 0 62 0 8 3 33 0 158] 
#[0 0 66 0 7 0 8] 
#[1 3 133 0 22 3 133 0 23 3 133 0 27 3 133 0 44 3 133 0 45 3 133 0 46 3 133 0 53 3 65 0 59 3 133 0 63 3 133 0 74 3 133 0 77 3 133 0 85 3 133 0 86 3 133 0 90 3 133 0 91 3 133 0 114 3 133 0 126 3 133 0 128 3 133 0 129 3 133 0 130 3 133 0 136 3 133 0 137 3 125 0 171 3 129 0 195 3 133 0 199] 
#[1 1 33 0 42 3 137 0 96 3 137 0 143 3 137 0 145 3 137 0 247 3 137 1 9 3 137 1 11] 
#[1 3 141 0 6 0 70 0 7 0 70 0 8 0 70 0 12 0 70 0 17 0 70 0 19 0 70 0 20 0 70 0 21 0 70 0 28 0 70 0 29 0 70 0 30 0 70 0 31 0 70 0 32 0 70 0 34 0 70 0 35 0 70 0 38 0 70 0 39 0 70 0 40 0 70 0 43 0 70 0 47 0 70 0 48 0 70 0 55 0 70 0 57 0 70 0 58 0 70 0 67 0 70 0 70 0 70 0 72 0 70 0 73 0 70 0 75 0 70 0 78 0 70 0 79 0 70 0 89 0 70 0 93 0 70 0 95 0 70 0 96 0 70 0 97 0 70 0 98 0 70 0 101 0 70 0 103 0 70 0 104 0 70 0 107 0 70 0 108 0 70 0 110 0 70 0 111 0 70 0 116 0 70 0 117 0 70 0 118 0 70 0 119 0 70 0 124 0 70 0 131 0 70 0 132 0 70 0 139 0 70 1 10 0 70 1 11] 
#[0 0 74 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 55 0 57 0 58 0 67 0 70 0 72 0 73 0 75 0 78 0 79 0 89 0 93 0 95 0 96 0 97 0 98 0 101 0 103 0 104 0 107 0 108 0 110 0 111 0 116 0 117 0 118 0 119 0 124 0 131 0 132 0 139 1 10 1 11] 
#[0 0 78 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 55 0 57 0 58 0 67 0 70 0 72 0 73 0 75 0 78 0 79 0 89 0 93 0 95 0 96 0 97 0 98 0 101 0 103 0 104 0 107 0 108 0 110 0 111 0 116 0 117 0 118 0 119 0 124 0 131 0 132 0 139 1 10 1 11] 
#[0 0 82 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 55 0 57 0 58 0 67 0 70 0 72 0 73 0 75 0 78 0 79 0 89 0 93 0 95 0 96 0 97 0 98 0 101 0 103 0 104 0 107 0 108 0 110 0 111 0 116 0 117 0 118 0 119 0 124 0 131 0 132 0 139 1 10 1 11] 
#[0 0 86 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 90 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 94 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 1 33 0 42 3 145 0 96 3 145 0 143 3 145 0 145 3 145 0 247 3 145 1 9 3 145 1 11] 
#[0 0 98 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 1 33 0 42 3 149 0 96 3 149 0 143 3 149 0 145 3 149 0 247 3 149 1 9 3 149 1 11] 
#[0 0 102 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 3 153 0 13 3 157 0 149 3 157 0 250] 
#[0 3 161 0 149 0 250] 
#[0 0 106 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 55 0 57 0 58 0 67 0 70 0 72 0 73 0 75 0 78 0 79 0 89 0 93 0 95 0 96 0 97 0 98 0 101 0 103 0 104 0 107 0 108 0 110 0 111 0 116 0 117 0 118 0 119 0 124 0 131 0 132 0 139 1 10 1 11] 
#[0 0 110 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 114 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 118 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 3 165 0 9 3 169 0 10] 
#[0 3 173 0 149 0 252] 
#[0 0 122 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 55 0 57 0 58 0 67 0 70 0 72 0 73 0 75 0 78 0 79 0 89 0 93 0 95 0 96 0 97 0 98 0 101 0 103 0 104 0 107 0 108 0 110 0 111 0 116 0 117 0 118 0 119 0 124 0 131 0 132 0 139 1 10 1 11] 
#[0 0 126 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 3 177 0 143] 
#[0 0 130 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 134 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 138 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 142 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 3 181 0 1 3 185 0 3 3 189 0 5] 
#[0 3 193 0 143] 
#[0 0 146 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 3 197 0 13 3 201 0 143] 
#[0 3 205 0 112] 
#[1 3 209 0 13 3 213 0 149 3 213 0 250] 
#[1 3 217 0 13 3 221 0 149 3 221 0 252] 
#[0 0 150 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 154 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 3 225 0 9 3 229 0 10] 
#[0 0 158 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 162 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 3 233 0 2 3 237 0 4] 
#[0 3 241 0 76 0 249] 
#[0 0 166 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 170 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 3 245 0 143] 
#[0 0 174 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 3 249 0 13 3 253 0 143] 
#[1 4 1 0 61 4 5 0 80 4 9 0 94] 
#[0 0 178 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 182 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 186 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 1 33 0 42 4 13 0 96 4 13 0 143 4 13 0 145 4 13 0 247 4 13 1 9 4 13 1 11] 
#[0 0 190 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 194 0 12 1 10] 
#[1 1 33 0 42 4 17 0 96 4 17 0 143 4 17 0 145 4 17 0 247 4 17 1 9 4 17 1 11] 
#[0 0 198 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 1 33 0 42 4 21 0 96 4 21 0 143 4 21 0 145 4 21 0 247 4 21 1 9 4 21 1 11] 
#[0 0 202 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 206 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 210 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 4 25 0 9 4 29 0 10 4 33 0 47] 
#[0 0 214 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 0 218 0 12 0 218 0 17 4 37 0 68 0 218 0 70 0 222 0 78 4 41 0 83 4 45 0 84 4 49 0 105 0 218 0 108 4 53 0 215 0 218 1 10 0 218 1 11] 
#[0 4 57 0 143] 
#[0 0 226 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 4 61 0 36 4 65 0 37 4 69 0 47 4 73 0 54 4 77 0 62 4 81 0 106] 
#[0 0 230 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 234 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 238 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 242 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 246 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 0 250 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 4 85 0 143] 
#[0 0 254 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 2 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 6 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 4 89 0 9 4 93 0 10 4 97 0 47] 
#[0 1 10 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 14 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 18 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 4 101 0 9 4 105 0 10 4 109 0 47] 
#[0 1 22 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 1 33 0 42 4 113 0 96 4 113 0 143 4 113 0 145 4 113 0 247 4 113 1 9 4 113 1 11] 
#[0 1 26 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 1 30 0 8 1 30 0 12 1 30 0 17 1 30 0 19 1 30 0 20 1 30 0 21 1 30 0 28 1 30 0 29 1 30 0 31 1 30 0 32 1 30 0 35 1 30 0 38 1 30 0 39 1 30 0 43 1 30 0 47 1 30 0 48 1 30 0 55 1 30 0 57 1 30 0 58 1 30 0 70 1 30 0 72 1 30 0 73 1 30 0 79 1 30 0 89 1 30 0 93 1 30 0 98 1 30 0 101 1 30 0 103 1 30 0 108 1 30 0 110 1 30 0 111 1 30 0 116 1 30 0 117 1 30 0 118 4 117 0 119 1 30 0 124 1 30 0 131 1 30 1 10 1 30 1 11] 
#[0 1 34 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 119 0 124 0 131 1 10 1 11] 
#[0 4 121 0 146 0 245] 
#[0 4 125 0 6] 
#[0 1 38 0 17 1 11] 
#[0 1 42 0 17 1 11] 
#[0 1 46 0 17 1 11] 
#[1 4 133 0 17 4 133 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 4 137 0 161 0 42 1 11] 
#[1 4 141 0 8 1 54 0 12 1 54 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 1 54 0 70 0 137 0 72 0 141 0 73 0 145 0 79 0 153 0 89 0 157 0 93 0 161 0 98 1 54 0 101 0 169 0 103 1 54 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 4 145 0 209 4 149 0 211 1 54 1 10 1 54 1 11] 
#[0 4 153 0 60] 
#[1 0 229 0 30 0 233 0 40 0 237 0 64 0 241 0 66 0 245 0 72 0 249 0 78 4 157 0 82 1 1 0 104 1 5 0 115 1 9 0 132 1 25 0 146 4 161 0 163 1 21 0 203 1 25 0 246] 
#[0 4 165 0 146 0 245] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 4 169 0 161 0 42 1 11] 
#[1 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 4 173 0 159 0 213 0 214 0 38 1 11] 
#[1 4 177 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 4 181 0 82 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 4 185 0 159 4 189 0 208 0 209 0 211 0 213 0 214 0 38 1 11] 
#[0 4 193 0 254 1 11] 
#[0 4 201 0 6] 
#[0 4 205 0 78] 
#[0 4 209 0 78] 
#[1 0 54 0 6 4 213 0 72 4 217 0 78 0 54 0 134 4 221 0 146 4 221 0 167 4 221 0 248] 
#[1 4 225 0 30 4 229 0 64 4 233 0 104 4 237 0 132] 
#[0 1 58 0 30 0 64 0 104 0 132] 
#[1 4 241 0 6 4 245 0 146 4 245 0 248] 
#[1 4 249 0 6 5 1 0 146 4 253 0 200 5 1 0 246] 
#[1 5 5 0 6 5 9 0 146 5 9 0 248] 
#[1 5 13 0 6 5 17 0 146 5 17 0 248] 
#[0 1 62 0 6 0 134] 
#[0 5 21 0 6] 
#[1 4 249 0 6 5 1 0 146 5 25 0 200 5 1 0 246] 
#[1 5 29 0 24 5 33 0 68] 
#[0 5 37 0 6] 
#[1 5 41 0 6 2 225 0 134 5 45 0 201] 
#[1 4 249 0 6 5 1 0 146 5 49 0 200 5 1 0 246] 
#[0 5 53 0 6] 
#[1 5 57 0 6 2 225 0 134 5 61 0 201] 
#[0 5 65 0 7] 
#[1 5 69 0 6 2 225 0 134 5 73 0 201] 
#[1 4 249 0 6 5 1 0 146 5 77 0 200 5 1 0 246] 
#[1 5 81 0 6 5 85 0 146 5 85 0 248] 
#[1 5 89 0 6 5 93 0 146 5 93 0 248] 
#[0 5 97 0 6] 
#[1 0 54 0 6 0 54 0 134 5 101 0 146 5 101 0 167 5 101 0 248] 
#[1 0 54 0 6 0 54 0 134 5 105 0 146 5 105 0 167 5 105 0 248] 
#[1 1 66 0 6 2 225 0 134 5 109 0 168 5 113 0 201] 
#[0 1 70 0 6 0 134] 
#[1 5 117 0 7 5 121 0 8 5 125 0 157] 
#[0 1 74 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 78 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 82 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 86 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 90 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 94 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 98 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 5 129 0 6] 
#[0 1 102 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 106 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 110 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 114 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 118 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 122 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 126 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 130 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 134 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 138 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 142 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 146 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 150 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 154 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139 0 141 0 142] 
#[0 1 158 0 7 0 8] 
#[1 1 162 0 7 1 162 0 8 5 133 0 17 1 162 0 20 1 162 0 30 0 7 0 32 1 162 0 34 1 162 0 35 1 162 0 40 5 141 0 47 1 162 0 58 5 145 0 67 1 162 0 75 1 162 0 78 5 149 0 95 5 153 0 96 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 5 165 0 173] 
#[1 5 169 0 6 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 5 181 0 141 5 185 0 142 5 189 0 196 5 193 0 197] 
#[0 1 170 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 5 197 0 7] 
#[0 1 174 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 178 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 5 201 0 149 0 250] 
#[0 1 182 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 186 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 190 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 194 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 198 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 202 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 206 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 210 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 214 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 218 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 5 205 0 143] 
#[0 1 222 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 5 209 0 13 5 213 0 149 5 213 0 250] 
#[0 5 217 0 149 0 250] 
#[0 1 226 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 5 221 0 149 0 252] 
#[0 1 230 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 234 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 238 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 242 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 246 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 250 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 1 254 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 5 225 0 143] 
#[0 2 2 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 6 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 10 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 14 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 18 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 22 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 26 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 30 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 34 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 38 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 5 229 0 6] 
#[1 5 233 0 68 2 42 0 78] 
#[1 5 237 0 6 5 241 0 33] 
#[1 5 245 0 6 5 249 0 33] 
#[0 5 253 0 78] 
#[0 2 46 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 50 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 54 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 58 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 62 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 66 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 70 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 74 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 78 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 82 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 86 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 90 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 94 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 98 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 102 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 6 1 0 52 6 5 0 92] 
#[1 2 106 0 7 2 106 0 8 6 9 0 213] 
#[0 6 13 0 146 0 245] 
#[0 2 110 1 11] 
#[0 6 17 0 253 1 11] 
#[1 6 25 0 17 6 25 0 162 1 50 1 11] 
#[1 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 137 0 72 0 141 0 73 0 145 0 79 0 153 0 89 0 157 0 93 0 161 0 98 0 169 0 103 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 6 29 0 211] 
#[0 2 114 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 118 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 6 33 0 146 0 245] 
#[0 6 37 0 146 0 245] 
#[1 0 62 0 7 0 62 0 8 6 41 0 158] 
#[0 2 122 0 12 1 10] 
#[1 6 45 0 17 6 45 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 6 49 0 161 0 42 1 11] 
#[1 0 229 0 30 0 233 0 40 0 237 0 64 0 241 0 66 0 245 0 72 0 249 0 78 6 53 0 82 1 1 0 104 1 5 0 115 1 9 0 132 1 25 0 146 6 57 0 163 1 21 0 203 1 25 0 246] 
#[0 6 61 0 146 0 245] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 6 65 0 161 0 42 1 11] 
#[1 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 6 69 0 159 0 213 0 214 0 38 1 11] 
#[0 6 73 0 7] 
#[0 2 126 0 6 0 7 0 8 0 35 0 43 0 57 0 72 0 89 0 93 0 119 0 124] 
#[0 6 77 0 254 1 11] 
#[1 6 81 0 6 6 85 0 146 6 85 0 248] 
#[1 6 89 0 6 2 225 0 134 6 93 0 201] 
#[1 0 54 0 6 0 54 0 134 6 97 0 146 6 97 0 167 6 97 0 248] 
#[1 0 54 0 6 0 54 0 134 6 101 0 146 6 101 0 167 6 101 0 248] 
#[1 1 66 0 6 2 225 0 134 6 105 0 168 5 113 0 201] 
#[0 6 109 0 6] 
#[0 6 113 0 78] 
#[0 6 117 0 78] 
#[1 0 54 0 6 6 121 0 72 6 125 0 78 0 54 0 134 6 129 0 146 6 129 0 167 6 129 0 248] 
#[0 6 133 0 146 0 246] 
#[0 6 137 0 6] 
#[0 6 141 0 254 1 11] 
#[1 2 130 0 7 2 130 0 8 6 145 0 165] 
#[1 6 149 0 6 2 134 0 7 2 134 0 8 6 153 0 18 6 157 0 50] 
#[1 4 249 0 6 5 1 0 146 6 161 0 200 5 1 0 246] 
#[0 6 165 0 6] 
#[1 4 249 0 6 5 1 0 146 6 169 0 200 5 1 0 246] 
#[0 6 173 0 6] 
#[1 4 249 0 6 5 1 0 146 6 177 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 6 181 0 165] 
#[0 2 138 0 6 0 7 0 8] 
#[0 2 142 0 6 0 7 0 8] 
#[1 4 249 0 6 5 1 0 146 6 185 0 200 5 1 0 246] 
#[1 4 249 0 6 5 1 0 146 6 189 0 200 5 1 0 246] 
#[0 6 193 0 6] 
#[1 2 130 0 7 2 130 0 8 6 197 0 165] 
#[1 4 249 0 6 5 1 0 146 6 201 0 200 5 1 0 246] 
#[1 4 249 0 6 5 1 0 146 6 205 0 200 5 1 0 246] 
#[0 6 209 0 6] 
#[0 2 146 0 12 1 10] 
#[1 4 249 0 6 5 1 0 146 6 213 0 200 5 1 0 246] 
#[0 6 217 0 6] 
#[1 2 130 0 7 2 130 0 8 6 221 0 165] 
#[1 4 249 0 6 5 1 0 146 6 225 0 200 5 1 0 246] 
#[0 6 229 0 6] 
#[1 4 249 0 6 5 1 0 146 6 233 0 200 5 1 0 246] 
#[0 6 237 0 6] 
#[1 4 249 0 6 5 1 0 146 6 241 0 200 5 1 0 246] 
#[1 1 66 0 6 2 225 0 134 6 245 0 168 5 113 0 201] 
#[1 1 66 0 6 2 225 0 134 6 249 0 168 5 113 0 201] 
#[0 6 253 0 6] 
#[0 2 150 0 6] 
#[1 2 154 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 7 1 0 159 7 5 0 208 0 209 0 211 7 9 0 214 2 154 1 10 0 38 1 11] 
#[1 0 229 0 30 0 233 0 40 0 237 0 64 0 241 0 66 0 245 0 72 0 249 0 78 1 1 0 104 1 5 0 115 1 9 0 132 1 25 0 146 7 13 0 163 1 21 0 203 1 25 0 246] 
#[0 2 158 0 7 0 8] 
#[1 1 33 0 42 7 21 0 96 7 21 0 143 7 21 0 145 7 17 0 198 7 21 0 247] 
#[0 7 25 0 6] 
#[0 7 29 0 149 0 252] 
#[1 7 33 0 6 1 33 0 42 7 37 0 96 7 37 0 143 7 37 0 145 7 37 0 247] 
#[0 7 41 0 16] 
#[0 7 45 0 96] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 7 49 0 47 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 7 53 0 173] 
#[0 7 57 0 133] 
#[0 2 162 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 58 0 75 0 78 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 7 73 0 175] 
#[0 7 77 0 144] 
#[0 7 81 0 112] 
#[1 7 85 0 13 7 89 0 149 7 89 0 250] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 7 93 0 142 5 189 0 196 7 97 0 197] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 5 189 0 196 7 101 0 197] 
#[0 2 170 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 2 174 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 2 178 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 55 0 57 0 58 0 67 0 70 0 72 0 73 0 75 0 78 0 79 0 89 0 93 0 95 0 96 0 97 0 98 0 101 0 103 0 104 0 107 0 108 0 110 0 111 0 116 0 117 0 118 0 119 0 124 0 131 0 132 0 139 1 10 1 11] 
#[0 2 182 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 186 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 7 105 0 149 0 250] 
#[0 2 190 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 194 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 198 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 202 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 7 109 0 254 1 11] 
#[0 7 113 0 6] 
#[0 7 117 0 254 1 11] 
#[0 7 121 0 6] 
#[0 7 125 0 254 1 11] 
#[0 7 129 0 6] 
#[1 2 206 0 6 7 133 0 15 7 137 0 216 7 141 0 217] 
#[0 2 210 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 2 214 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 7 145 0 7 7 149 0 8 7 153 0 212] 
#[1 2 106 0 7 2 106 0 8 7 157 0 213] 
#[0 2 218 0 12 1 10] 
#[0 2 222 0 12 1 10] 
#[0 7 161 0 253 1 11] 
#[0 2 226 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[1 7 165 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 7 169 0 82 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 7 173 0 159 7 177 0 208 0 209 0 211 0 213 0 214 0 38 1 11] 
#[0 7 181 0 7] 
#[1 7 185 0 7 5 121 0 8 5 125 0 157] 
#[0 7 189 0 253 1 11] 
#[1 7 193 0 17 7 193 0 162 1 50 1 11] 
#[0 7 197 0 146 0 245] 
#[1 0 62 0 7 0 62 0 8 7 201 0 158] 
#[0 2 230 0 12 1 10] 
#[1 7 205 0 17 7 205 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 7 209 0 161 0 42 1 11] 
#[1 2 234 0 7 2 234 0 8 7 213 0 56 7 217 0 95] 
#[0 7 221 0 7] 
#[0 7 225 0 146 0 246] 
#[0 7 229 0 6] 
#[1 4 249 0 6 5 1 0 146 7 233 0 200 5 1 0 246] 
#[0 7 237 0 6] 
#[1 1 66 0 6 2 225 0 134 7 241 0 168 5 113 0 201] 
#[1 1 66 0 6 2 225 0 134 7 245 0 168 5 113 0 201] 
#[0 7 249 0 6] 
#[0 7 253 0 254 1 11] 
#[1 8 1 0 6 8 5 0 146 8 5 0 248] 
#[1 8 9 0 6 2 225 0 134 8 13 0 201] 
#[1 0 54 0 6 0 54 0 134 8 17 0 146 8 17 0 167 8 17 0 248] 
#[1 0 54 0 6 0 54 0 134 8 21 0 146 8 21 0 167 8 21 0 248] 
#[1 1 66 0 6 2 225 0 134 8 25 0 168 5 113 0 201] 
#[1 2 238 0 7 2 238 0 8 8 29 0 170] 
#[0 8 33 0 146 0 246] 
#[0 8 37 0 7] 
#[1 8 41 0 7 8 45 0 8 8 49 0 164] 
#[0 8 57 0 144 0 251] 
#[0 2 242 0 7 0 8] 
#[0 2 246 0 7 0 8] 
#[1 2 130 0 7 2 130 0 8 8 61 0 165] 
#[1 4 249 0 6 5 1 0 146 8 65 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 8 69 0 165] 
#[1 4 249 0 6 5 1 0 146 8 73 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 8 77 0 165] 
#[1 8 81 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 8 85 0 165] 
#[1 2 130 0 7 2 130 0 8 8 89 0 165] 
#[1 4 249 0 6 5 1 0 146 8 93 0 200 5 1 0 246] 
#[1 8 97 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 8 101 0 165] 
#[1 2 130 0 7 2 130 0 8 8 105 0 165] 
#[1 4 249 0 6 5 1 0 146 8 109 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 8 113 0 165] 
#[1 4 249 0 6 5 1 0 146 8 117 0 200 5 1 0 246] 
#[1 8 121 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 8 125 0 165] 
#[1 4 249 0 6 5 1 0 146 8 129 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 8 133 0 165] 
#[1 4 249 0 6 5 1 0 146 8 137 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 8 141 0 165] 
#[0 8 145 0 6] 
#[0 8 149 0 6] 
#[1 4 249 0 6 5 1 0 146 8 153 0 200 5 1 0 246] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 8 157 0 161 0 42 1 11] 
#[1 2 250 0 12 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 8 161 0 159 8 165 0 214 2 250 1 10 0 38 1 11] 
#[1 2 254 0 12 0 50 0 17 0 50 0 70 0 50 0 108 2 254 1 10 0 50 1 11] 
#[0 3 2 0 7 0 8] 
#[1 0 11 0 7 0 15 0 8 3 6 0 17 3 6 0 20 8 177 0 28 8 181 0 29 3 6 0 30 3 6 0 32 3 6 0 34 3 6 0 35 3 6 0 40 3 6 0 47 3 6 0 58 3 6 0 67 3 6 0 75 3 6 0 78 3 6 0 95 3 6 0 96 3 6 0 97 3 6 0 104 3 6 0 107 3 6 0 111 3 6 0 119 3 6 0 132 3 6 0 139] 
#[0 3 10 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 8 185 0 254 1 11] 
#[1 8 189 0 17 8 193 0 67] 
#[0 8 197 0 254 1 11] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 8 201 0 173] 
#[0 8 205 0 17] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 8 209 0 47 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 8 213 0 173] 
#[1 8 217 0 6 1 33 0 42 8 221 0 96 8 221 0 143 8 221 0 145 8 221 0 247] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 8 225 0 175] 
#[1 8 229 0 6 1 33 0 42 8 233 0 96 8 233 0 143 8 233 0 145 8 233 0 247] 
#[0 3 14 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 58 0 78 0 104 0 107 0 111 0 119 0 132] 
#[0 3 18 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 58 0 78 0 104 0 107 0 111 0 119 0 132] 
#[0 3 22 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 58 0 78 0 104 0 107 0 111 0 119 0 132] 
#[1 3 26 0 7 3 26 0 8 8 241 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 8 241 0 176] 
#[1 8 245 0 7 8 249 0 8] 
#[1 8 253 0 13 9 1 0 149 9 1 0 250] 
#[0 9 5 0 149 0 250] 
#[1 3 30 0 7 3 30 0 8 3 30 0 17 3 30 0 20 3 30 0 30 0 19 0 32 3 30 0 34 3 30 0 35 3 30 0 40 3 30 0 47 3 30 0 58 3 30 0 67 3 30 0 75 3 30 0 78 3 30 0 95 3 30 0 96 3 30 0 97 3 30 0 104 3 30 0 107 3 30 0 111 3 30 0 119 3 30 0 132 3 30 0 139] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 5 189 0 196 9 13 0 197] 
#[0 3 34 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 3 38 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 3 42 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 9 17 0 7] 
#[0 9 21 0 254 1 11] 
#[0 9 25 0 7] 
#[1 9 29 0 146 9 29 0 246 9 33 1 2] 
#[0 9 37 0 7] 
#[1 9 29 0 146 9 29 0 246 9 41 1 2] 
#[0 9 45 0 13] 
#[0 3 46 0 6] 
#[0 9 49 0 6] 
#[0 3 50 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 9 53 0 146 0 245] 
#[0 3 54 0 7 0 8] 
#[1 9 57 0 7 7 149 0 8 7 153 0 212] 
#[0 3 58 0 12 1 10] 
#[1 0 229 0 30 0 233 0 40 0 237 0 64 0 241 0 66 0 245 0 72 0 249 0 78 9 61 0 82 1 1 0 104 1 5 0 115 1 9 0 132 1 25 0 146 9 65 0 163 1 21 0 203 1 25 0 246] 
#[0 9 69 0 146 0 245] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 9 73 0 161 0 42 1 11] 
#[1 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 9 77 0 159 0 213 0 214 0 38 1 11] 
#[0 3 62 0 12 1 10] 
#[1 3 66 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 9 81 0 159 9 85 0 208 0 209 0 211 9 89 0 214 3 66 1 10 0 38 1 11] 
#[0 3 70 0 12 1 10] 
#[0 9 93 0 253 1 11] 
#[0 9 97 0 7] 
#[1 9 101 0 7 5 121 0 8 5 125 0 157] 
#[0 9 105 0 253 1 11] 
#[1 9 109 0 17 9 109 0 162 1 50 1 11] 
#[0 3 74 0 7 0 8] 
#[0 9 113 0 56] 
#[1 3 78 0 7 3 78 0 8 9 117 0 56 9 121 0 95] 
#[1 2 238 0 7 2 238 0 8 9 125 0 170] 
#[0 9 129 0 146 0 246] 
#[1 2 130 0 7 2 130 0 8 9 133 0 165] 
#[1 4 249 0 6 5 1 0 146 9 137 0 200 5 1 0 246] 
#[0 9 141 0 6] 
#[0 9 145 0 6] 
#[1 4 249 0 6 5 1 0 146 9 149 0 200 5 1 0 246] 
#[0 9 153 0 7] 
#[0 9 157 0 146 0 246] 
#[0 9 161 0 6] 
#[1 4 249 0 6 5 1 0 146 9 165 0 200 5 1 0 246] 
#[0 9 169 0 6] 
#[1 1 66 0 6 2 225 0 134 9 173 0 168 5 113 0 201] 
#[1 1 66 0 6 2 225 0 134 9 177 0 168 5 113 0 201] 
#[0 9 181 0 6] 
#[1 9 185 0 7 9 189 0 8 9 193 0 169] 
#[1 2 238 0 7 2 238 0 8 9 197 0 170] 
#[1 3 82 0 7 3 82 0 8 9 201 0 18 9 205 0 50] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 237 0 166 9 241 0 201 9 237 0 202] 
#[1 4 249 0 6 5 1 0 146 9 249 0 200 5 1 0 246] 
#[0 3 90 0 7 0 8] 
#[0 3 94 0 7] 
#[0 9 253 0 7] 
#[1 10 1 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 10 5 0 165] 
#[1 10 9 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 10 13 0 165] 
#[1 10 17 0 7 8 45 0 8 8 49 0 164] 
#[1 3 98 0 7 3 98 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 10 21 0 202] 
#[1 10 25 0 7 8 45 0 8 8 49 0 164] 
#[1 10 29 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 10 33 0 165] 
#[1 3 102 0 7 3 102 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 10 37 0 202] 
#[1 10 41 0 7 8 45 0 8 8 49 0 164] 
#[1 10 45 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 10 49 0 165] 
#[1 10 53 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 10 57 0 165] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 10 61 0 166 9 241 0 201 10 61 0 202] 
#[1 10 65 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 10 69 0 165] 
#[1 10 73 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 10 77 0 165] 
#[1 10 81 0 7 8 45 0 8 8 49 0 164] 
#[1 4 249 0 6 5 1 0 146 10 85 0 200 5 1 0 246] 
#[1 4 249 0 6 5 1 0 146 10 89 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 10 93 0 165] 
#[1 10 97 0 17 10 97 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 10 101 0 161 0 42 1 11] 
#[1 3 106 0 12 0 50 0 17 0 50 0 70 0 50 0 108 3 106 1 10 0 50 1 11] 
#[1 3 110 0 7 3 110 0 8 3 110 0 17 3 110 0 20 10 105 0 28 10 109 0 29 3 110 0 30 3 110 0 32 3 110 0 34 3 110 0 35 3 110 0 40 3 110 0 47 3 110 0 58 3 110 0 67 3 110 0 75 3 110 0 78 3 110 0 95 3 110 0 96 3 110 0 97 3 110 0 104 3 110 0 107 3 110 0 111 3 110 0 119 3 110 0 132 3 110 0 139] 
#[1 1 33 0 42 10 113 0 96 10 113 0 143 10 113 0 145 10 113 0 247] 
#[0 10 117 0 112] 
#[1 10 121 0 13 10 125 0 149 10 125 0 250] 
#[0 10 129 0 7] 
#[0 10 133 0 6] 
#[0 10 137 0 16] 
#[0 10 141 0 7] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 10 145 0 175] 
#[0 10 149 0 6] 
#[1 10 153 0 6 1 33 0 42 10 157 0 96 10 157 0 143 10 157 0 145 10 157 0 247] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 10 161 0 175] 
#[0 10 165 0 254 1 11] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 10 169 0 173] 
#[1 3 26 0 7 3 26 0 8 10 173 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 10 173 0 176] 
#[0 10 177 0 254 1 11] 
#[0 3 114 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 58 0 75 0 78 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 3 118 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 58 0 78 0 104 0 107 0 111 0 119 0 132] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 10 189 0 178] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 10 193 0 141 10 197 0 142 5 189 0 196 10 201 0 197] 
#[0 10 205 0 144] 
#[0 10 209 0 149 0 250] 
#[1 3 126 0 7 3 126 0 8 3 126 0 17 3 126 0 20 3 126 0 30 0 23 0 32 3 126 0 34 3 126 0 35 3 126 0 40 3 126 0 47 3 126 0 58 3 126 0 67 3 126 0 75 3 126 0 78 3 126 0 95 3 126 0 96 3 126 0 97 3 126 0 104 3 126 0 107 3 126 0 111 3 126 0 119 3 126 0 132 3 126 0 139] 
#[1 3 130 0 7 3 130 0 8 3 130 0 17 3 130 0 20 3 130 0 30 0 27 0 32 3 130 0 34 3 130 0 35 3 130 0 40 3 130 0 47 3 130 0 58 3 130 0 67 3 130 0 75 3 130 0 78 3 130 0 95 3 130 0 96 3 130 0 97 3 130 0 104 3 130 0 107 3 130 0 111 3 130 0 119 3 130 0 132 3 130 0 139] 
#[0 10 221 0 149 0 252] 
#[0 3 134 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 3 138 0 12 0 17 0 70 0 108 1 10 1 11] 
#[0 10 225 0 7] 
#[1 10 229 0 102 3 142 0 121 10 233 0 218 10 237 0 219] 
#[0 10 241 0 8] 
#[0 10 245 0 7] 
#[0 3 146 0 12 0 17 0 70 0 108 1 10 1 11] 
#[0 10 249 0 7] 
#[1 10 253 0 10 11 1 0 11] 
#[1 9 29 0 146 9 29 0 246 11 5 1 2] 
#[0 3 150 0 7 0 8] 
#[0 3 154 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 55 0 57 0 58 0 70 0 72 0 73 0 79 0 89 0 93 0 98 0 101 0 103 0 108 0 110 0 111 0 116 0 117 0 118 0 124 0 131 1 10 1 11] 
#[0 11 9 0 146 0 245] 
#[1 0 62 0 7 0 62 0 8 11 13 0 158] 
#[0 3 158 0 12 1 10] 
#[1 11 17 0 17 11 17 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 11 21 0 161 0 42 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 11 25 0 161 0 42 1 11] 
#[1 3 162 0 12 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 11 29 0 159 11 33 0 214 3 162 1 10 0 38 1 11] 
#[1 3 166 0 12 0 50 0 17 0 50 0 70 0 50 0 108 3 166 1 10 0 50 1 11] 
#[0 3 170 0 12 1 10] 
#[0 3 174 0 12 1 10] 
#[1 3 178 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 11 37 0 159 11 41 0 208 0 209 0 211 11 45 0 214 3 178 1 10 0 38 1 11] 
#[0 3 182 0 12 1 10] 
#[0 11 49 0 253 1 11] 
#[0 3 186 0 7 0 8] 
#[0 3 190 0 7 0 8] 
#[0 11 53 0 56] 
#[1 11 57 0 7 9 189 0 8 9 193 0 169] 
#[1 2 238 0 7 2 238 0 8 11 61 0 170] 
#[1 11 65 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 11 69 0 165] 
#[1 4 249 0 6 5 1 0 146 11 73 0 200 5 1 0 246] 
#[1 4 249 0 6 5 1 0 146 11 77 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 11 81 0 165] 
#[1 3 194 0 7 3 194 0 8 11 85 0 56 11 89 0 95] 
#[1 2 238 0 7 2 238 0 8 11 93 0 170] 
#[0 11 97 0 146 0 246] 
#[1 2 130 0 7 2 130 0 8 11 101 0 165] 
#[1 4 249 0 6 5 1 0 146 11 105 0 200 5 1 0 246] 
#[0 11 109 0 6] 
#[0 11 113 0 6] 
#[1 4 249 0 6 5 1 0 146 11 117 0 200 5 1 0 246] 
#[1 11 121 0 107 11 125 0 204] 
#[0 11 129 0 146 0 246] 
#[0 3 198 0 7 0 8] 
#[1 11 133 0 7 9 189 0 8 9 193 0 169] 
#[0 3 202 0 7 0 8] 
#[0 3 206 0 7 0 8] 
#[0 11 137 0 143] 
#[1 11 141 0 13 11 145 0 143] 
#[0 3 210 0 7 0 8] 
#[1 11 149 0 13 1 33 0 42 11 153 0 96 11 153 0 143 11 153 0 145 11 153 0 247 11 153 1 9 11 153 1 11] 
#[1 11 157 0 13 11 161 0 143] 
#[0 3 214 0 7 0 8] 
#[0 11 165 0 99] 
#[0 3 218 0 7 0 8] 
#[0 3 222 0 7 0 8] 
#[0 3 226 0 7 0 8] 
#[0 3 230 0 7 0 8] 
#[1 3 234 0 7 3 234 0 8 11 169 0 18 11 173 0 50] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 11 177 0 166 9 241 0 201 11 177 0 202] 
#[1 11 181 0 7 8 45 0 8 8 49 0 164] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 11 185 0 166 9 241 0 201 11 185 0 202] 
#[1 11 189 0 7 8 45 0 8 8 49 0 164] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 11 193 0 166 9 241 0 201 11 193 0 202] 
#[0 3 238 0 7 0 8] 
#[1 3 242 0 7 3 242 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 11 197 0 202] 
#[1 3 246 0 7 3 246 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 11 201 0 202] 
#[1 11 205 0 7 8 45 0 8 8 49 0 164] 
#[0 3 250 0 7 0 8] 
#[1 3 254 0 7 3 254 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 11 209 0 202] 
#[1 4 2 0 7 4 2 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 11 213 0 202] 
#[1 11 217 0 7 8 45 0 8 8 49 0 164] 
#[1 4 6 0 7 4 6 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 11 221 0 202] 
#[1 11 225 0 7 8 45 0 8 8 49 0 164] 
#[0 4 10 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 11 229 0 166 9 241 0 201 11 229 0 202] 
#[1 11 233 0 7 8 45 0 8 8 49 0 164] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 11 237 0 166 9 241 0 201 11 237 0 202] 
#[1 11 241 0 7 8 45 0 8 8 49 0 164] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 11 245 0 166 9 241 0 201 11 245 0 202] 
#[1 2 130 0 7 2 130 0 8 11 249 0 165] 
#[1 2 130 0 7 2 130 0 8 11 253 0 165] 
#[1 12 1 0 7 8 45 0 8 8 49 0 164] 
#[0 12 5 0 253 1 11] 
#[1 12 9 0 17 12 9 0 162 1 50 1 11] 
#[0 12 13 0 112] 
#[1 12 17 0 13 12 21 0 149 12 21 0 250] 
#[0 4 14 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 12 25 0 13 12 29 0 149 12 29 0 250] 
#[0 12 33 0 149 0 250] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 12 45 0 184] 
#[1 12 49 0 120 12 53 0 138] 
#[0 12 57 0 254 1 11] 
#[0 12 61 0 17] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 12 65 0 173] 
#[1 3 26 0 7 3 26 0 8 12 69 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 12 69 0 176] 
#[0 12 73 0 254 1 11] 
#[0 12 77 0 254 1 11] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 12 81 0 173] 
#[1 3 26 0 7 3 26 0 8 12 85 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 12 85 0 176] 
#[0 12 89 0 7] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 12 93 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 12 97 0 178] 
#[0 12 101 0 7] 
#[1 4 22 0 7 4 22 0 8 4 22 0 30 4 22 0 32 4 22 0 34 4 22 0 35 4 22 0 40 4 22 0 58 0 35 0 78 4 22 0 104 4 22 0 107 4 22 0 111 4 22 0 119] 
#[0 4 26 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 58 0 78 0 104 0 107 0 111 0 119] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 12 121 0 180] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 12 125 0 142 5 189 0 196 12 129 0 197] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 5 189 0 196 12 133 0 197] 
#[0 4 34 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 12 137 0 7] 
#[1 4 38 0 7 4 38 0 8 4 38 0 17 4 38 0 20 4 38 0 30 0 39 0 32 4 38 0 34 4 38 0 35 4 38 0 40 4 38 0 47 4 38 0 58 4 38 0 67 4 38 0 75 4 38 0 78 4 38 0 95 4 38 0 96 4 38 0 97 4 38 0 104 4 38 0 107 4 38 0 111 4 38 0 119 4 38 0 132 4 38 0 139] 
#[0 12 145 0 149 0 252] 
#[0 12 149 0 149 0 252] 
#[0 4 42 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 4 46 0 12 0 17 0 70 0 108 1 10 1 11] 
#[0 12 157 0 144 1 6] 
#[0 4 50 0 121] 
#[0 12 161 0 121] 
#[0 12 165 0 146 0 246] 
#[1 10 229 0 102 3 142 0 121 10 233 0 218 12 169 0 219] 
#[0 4 54 0 12 0 17 0 70 0 108 1 10 1 11] 
#[0 4 58 0 6] 
#[0 4 62 0 6] 
#[0 12 173 0 7] 
#[0 12 177 0 7] 
#[1 12 181 0 7 5 121 0 8 5 125 0 157] 
#[0 12 185 0 253 1 11] 
#[1 12 189 0 17 12 189 0 162 1 50 1 11] 
#[1 12 193 0 17 12 193 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 12 197 0 161 0 42 1 11] 
#[1 4 66 0 12 0 50 0 17 0 50 0 70 0 50 0 108 4 66 1 10 0 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 12 201 0 161 0 42 1 11] 
#[1 4 70 0 12 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 12 205 0 159 12 209 0 214 4 70 1 10 0 38 1 11] 
#[1 4 74 0 12 0 50 0 17 0 50 0 70 0 50 0 108 4 74 1 10 0 50 1 11] 
#[0 4 78 0 12 1 10] 
#[0 4 82 0 7 0 8] 
#[1 11 121 0 107 12 213 0 204] 
#[1 12 217 0 7 9 189 0 8 9 193 0 169] 
#[1 4 86 0 7 4 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 12 221 0 202] 
#[1 12 225 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 12 229 0 165] 
#[1 2 130 0 7 2 130 0 8 12 233 0 165] 
#[1 12 237 0 7 8 45 0 8 8 49 0 164] 
#[0 4 90 0 7 0 8] 
#[0 12 241 0 56] 
#[1 12 245 0 7 9 189 0 8 9 193 0 169] 
#[1 2 238 0 7 2 238 0 8 12 249 0 170] 
#[1 12 253 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 13 1 0 165] 
#[1 4 249 0 6 5 1 0 146 13 5 0 200 5 1 0 246] 
#[1 4 249 0 6 5 1 0 146 13 9 0 200 5 1 0 246] 
#[1 2 130 0 7 2 130 0 8 13 13 0 165] 
#[0 13 17 0 146 0 245] 
#[0 4 94 0 7 0 8] 
#[0 4 98 0 7 0 8] 
#[1 11 121 0 107 13 21 0 204] 
#[0 4 102 0 7 0 8] 
#[0 13 25 0 143] 
#[0 4 106 0 7 0 8] 
#[1 1 33 0 42 13 29 0 96 13 29 0 143 13 29 0 145 13 29 0 247 13 29 1 9 13 29 1 11] 
#[0 4 110 0 7 0 8] 
#[0 13 33 0 143] 
#[0 4 114 0 7 0 8] 
#[0 13 41 0 149 1 4] 
#[0 4 118 0 7 0 8] 
#[0 4 122 0 7 0 8] 
#[0 4 126 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 13 45 0 166 9 241 0 201 13 45 0 202] 
#[0 4 130 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 13 49 0 166 9 241 0 201 13 49 0 202] 
#[0 4 134 0 7 0 8] 
#[0 4 138 0 7 0 8] 
#[0 4 142 0 7 0 8] 
#[1 4 146 0 7 4 146 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 13 53 0 202] 
#[0 4 150 0 7 0 8] 
#[0 4 154 0 7 0 8] 
#[1 4 158 0 7 4 158 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 13 57 0 202] 
#[0 4 162 0 7 0 8] 
#[1 4 166 0 7 4 166 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 13 61 0 202] 
#[0 4 170 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 13 65 0 166 9 241 0 201 13 65 0 202] 
#[0 4 174 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 13 69 0 166 9 241 0 201 13 69 0 202] 
#[0 4 178 0 7 0 8] 
#[1 13 73 0 7 8 45 0 8 8 49 0 164] 
#[1 13 77 0 7 8 45 0 8 8 49 0 164] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 13 81 0 166 9 241 0 201 13 81 0 202] 
#[0 4 182 0 12 1 10] 
#[0 13 85 0 253 1 11] 
#[1 13 89 0 13 13 93 0 149 13 93 0 250] 
#[0 13 97 0 149 0 250] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 13 101 0 184] 
#[0 13 105 0 149 0 250] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 13 109 0 184] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 13 113 0 184] 
#[0 13 117 0 149 0 252] 
#[0 4 186 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 4 190 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 13 121 0 95 13 125 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 13 129 0 175] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 13 133 0 95 13 137 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 13 141 0 175] 
#[0 13 145 0 7] 
#[0 13 149 0 6] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 13 153 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 13 157 0 178] 
#[0 13 161 0 7] 
#[0 13 165 0 7] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 13 169 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 13 173 0 178] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 13 177 0 173] 
#[1 3 26 0 7 3 26 0 8 13 181 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 13 181 0 176] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 13 185 0 180] 
#[0 4 194 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 58 0 75 0 78 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 4 198 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 58 0 78 0 104 0 107 0 111 0 119] 
#[0 4 202 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 58 0 107 0 111 0 119] 
#[0 13 189 0 78] 
#[0 4 206 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 58 0 107 0 111 0 119] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 13 201 0 181 13 201 0 182] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 5 189 0 196 13 205 0 197] 
#[0 4 214 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 4 218 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 13 209 0 141 13 213 0 142 5 189 0 196 13 217 0 197] 
#[0 13 221 0 149 0 252] 
#[0 4 222 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 4 226 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 4 230 0 6 0 121] 
#[0 4 234 0 121] 
#[0 13 225 0 25] 
#[0 4 238 0 7] 
#[0 13 229 0 121] 
#[0 4 242 0 12 0 17 0 70 0 108 1 10 1 11] 
#[0 4 246 0 12 1 10] 
#[1 4 250 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 28 0 89 0 29 0 93 0 31 0 97 0 32 0 101 0 35 0 105 0 38 0 109 0 39 0 113 0 43 0 117 0 47 0 121 0 48 0 125 0 55 0 129 0 57 0 133 0 58 0 38 0 70 0 137 0 72 0 141 0 73 0 145 0 79 0 153 0 89 0 157 0 93 0 161 0 98 0 165 0 101 0 169 0 103 0 38 0 108 0 173 0 110 0 177 0 111 0 181 0 116 0 185 0 117 0 189 0 118 0 193 0 124 0 197 0 131 13 233 0 159 13 237 0 208 0 209 0 211 13 241 0 214 4 250 1 10 0 38 1 11] 
#[0 4 254 0 12 1 10] 
#[0 13 245 0 253 1 11] 
#[0 13 249 0 253 1 11] 
#[1 13 253 0 17 13 253 0 162 1 50 1 11] 
#[1 14 1 0 17 14 1 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 14 5 0 161 0 42 1 11] 
#[1 5 2 0 12 0 50 0 17 0 50 0 70 0 50 0 108 5 2 1 10 0 50 1 11] 
#[0 5 6 0 7 0 8] 
#[1 11 121 0 107 14 9 0 204] 
#[0 5 10 0 7 0 8] 
#[1 5 14 0 7 5 14 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 14 13 0 202] 
#[1 14 17 0 7 8 45 0 8 8 49 0 164] 
#[1 14 21 0 7 8 45 0 8 8 49 0 164] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 14 25 0 166 9 241 0 201 14 25 0 202] 
#[0 5 18 0 7 0 8] 
#[1 11 121 0 107 14 29 0 204] 
#[1 14 33 0 7 9 189 0 8 9 193 0 169] 
#[1 5 22 0 7 5 22 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 14 37 0 202] 
#[1 14 41 0 7 8 45 0 8 8 49 0 164] 
#[1 2 130 0 7 2 130 0 8 14 45 0 165] 
#[1 2 130 0 7 2 130 0 8 14 49 0 165] 
#[1 14 53 0 7 8 45 0 8 8 49 0 164] 
#[0 14 57 0 6] 
#[0 5 26 0 7 0 8] 
#[0 5 30 0 7 0 8] 
#[0 5 34 0 7 0 8] 
#[0 5 38 0 7 0 8] 
#[0 5 42 0 7 0 8] 
#[0 5 46 0 7 0 8] 
#[0 5 50 0 7 0 8] 
#[0 5 54 0 7 0 8] 
#[0 5 58 0 7 0 8] 
#[0 5 62 0 7 0 8] 
#[0 5 66 0 7 0 8] 
#[0 5 70 0 7 0 8] 
#[0 5 74 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 14 61 0 166 9 241 0 201 14 61 0 202] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 14 65 0 166 9 241 0 201 14 65 0 202] 
#[0 5 78 0 7 0 8] 
#[0 5 82 0 12 1 10] 
#[0 14 69 0 149 0 250] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 14 73 0 184] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 14 77 0 184] 
#[0 5 86 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 14 81 0 184] 
#[0 5 90 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 5 94 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 5 98 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 14 85 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 14 89 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 14 93 0 178] 
#[0 14 97 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 14 101 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 14 105 0 178] 
#[1 14 109 0 120 14 113 0 138] 
#[0 14 117 0 254 1 11] 
#[1 3 26 0 7 3 26 0 8 14 121 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 14 121 0 176] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 14 125 0 180] 
#[1 14 129 0 120 14 133 0 138] 
#[1 1 162 0 7 1 162 0 8 1 162 0 20 1 162 0 30 1 162 0 32 1 162 0 34 1 162 0 35 1 162 0 40 1 162 0 58 1 162 0 75 1 162 0 78 5 157 0 97 1 162 0 104 1 162 0 107 1 162 0 111 1 162 0 119 1 162 0 132 1 162 0 139 5 161 0 172 14 137 0 173] 
#[1 3 26 0 7 3 26 0 8 14 141 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 14 141 0 176] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 14 145 0 180] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 14 149 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 14 153 0 178] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 14 157 0 181 14 157 0 182] 
#[0 5 102 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 58 0 107 0 111 0 119] 
#[0 14 161 0 143] 
#[0 5 106 0 7 0 8 0 30 0 32 0 34 0 40 0 58 0 107 0 111 0 119] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 14 165 0 184] 
#[0 5 110 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 14 169 0 142 5 189 0 196 14 173 0 197] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 5 189 0 196 14 177 0 197] 
#[0 5 114 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 5 118 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 0 222 0 68 14 181 0 83 14 185 0 215] 
#[0 14 189 0 25] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 14 193 0 161 0 42 1 11] 
#[1 5 122 0 12 0 38 0 17 0 38 0 70 0 165 0 101 0 38 0 108 14 197 0 159 14 201 0 214 5 122 1 10 0 38 1 11] 
#[1 5 126 0 12 0 50 0 17 0 50 0 70 0 50 0 108 5 126 1 10 0 50 1 11] 
#[0 5 130 0 12 1 10] 
#[0 5 134 0 12 1 10] 
#[0 14 205 0 253 1 11] 
#[0 14 209 0 253 1 11] 
#[1 14 213 0 17 14 213 0 162 1 50 1 11] 
#[0 5 138 0 7 0 8] 
#[0 5 142 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 14 217 0 166 9 241 0 201 14 217 0 202] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 14 221 0 166 9 241 0 201 14 221 0 202] 
#[0 5 146 0 7 0 8] 
#[0 5 150 0 7 0 8] 
#[1 11 121 0 107 14 225 0 204] 
#[0 5 154 0 7 0 8] 
#[1 5 158 0 7 5 158 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 9 241 0 201 14 229 0 202] 
#[1 14 233 0 7 8 45 0 8 8 49 0 164] 
#[1 14 237 0 7 8 45 0 8 8 49 0 164] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 14 241 0 166 9 241 0 201 14 241 0 202] 
#[1 4 249 0 6 5 1 0 146 14 245 0 200 5 1 0 246] 
#[0 5 162 0 7 0 8] 
#[0 5 166 0 7 0 8] 
#[1 4 18 0 7 4 18 0 8 4 18 0 17 4 18 0 20 4 18 0 30 0 31 0 32 4 18 0 34 4 18 0 35 4 18 0 40 4 18 0 47 4 18 0 58 4 18 0 67 4 18 0 75 4 18 0 78 4 18 0 95 4 18 0 96 4 18 0 97 4 18 0 104 4 18 0 107 4 18 0 111 4 18 0 119 4 18 0 132 4 18 0 139 12 41 0 183 14 249 0 184] 
#[0 5 170 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 5 174 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 5 178 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 14 253 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 1 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 15 5 0 180] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 9 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 13 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 15 17 0 180] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 15 21 0 95 15 25 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 29 0 175] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 15 33 0 95 15 37 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 41 0 175] 
#[0 15 45 0 7] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 15 49 0 178] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 15 53 0 181 15 53 0 182] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 15 57 0 95 15 61 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 65 0 175] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 15 69 0 95 15 73 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 77 0 175] 
#[1 2 166 0 7 2 166 0 8 2 166 0 20 2 166 0 30 2 166 0 32 2 166 0 34 2 166 0 35 2 166 0 40 2 166 0 58 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 111 2 166 0 119 2 166 0 132 7 65 0 139 7 69 0 174 15 81 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 15 85 0 178] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 15 89 0 181 15 89 0 182] 
#[1 3 26 0 7 3 26 0 8 15 93 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 15 93 0 176] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 15 97 0 180] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 15 101 0 184] 
#[0 5 182 0 7 0 8 0 30 0 32 0 34 0 40 0 58 0 107 0 111 0 119] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 15 113 0 186] 
#[1 1 166 0 7 1 166 0 8 1 166 0 17 1 166 0 20 5 173 0 28 5 177 0 29 1 166 0 30 1 166 0 32 1 166 0 34 1 166 0 35 1 166 0 40 1 166 0 47 1 166 0 58 1 166 0 67 1 166 0 75 1 166 0 78 1 166 0 95 1 166 0 96 1 166 0 97 1 166 0 104 1 166 0 107 1 166 0 111 1 166 0 119 1 166 0 132 1 166 0 139 5 189 0 196 15 117 0 197] 
#[0 5 190 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[0 5 194 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 2 42 0 68 15 121 0 78] 
#[0 15 125 0 68] 
#[1 0 222 0 68 15 129 0 83 15 133 0 215] 
#[1 15 137 0 17 15 137 0 162 1 50 1 11] 
#[1 0 42 0 17 2 121 0 70 2 125 0 108 2 129 0 160 15 141 0 161 0 42 1 11] 
#[1 5 198 0 12 0 50 0 17 0 50 0 70 0 50 0 108 5 198 1 10 0 50 1 11] 
#[0 5 202 0 12 1 10] 
#[0 5 206 0 12 1 10] 
#[0 15 145 0 253 1 11] 
#[0 5 210 0 7 0 8] 
#[0 5 214 0 7 0 8] 
#[0 5 218 0 7 0 8] 
#[0 5 222 0 7 0 8] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 15 149 0 166 9 241 0 201 15 149 0 202] 
#[1 3 86 0 7 3 86 0 8 9 209 0 35 9 213 0 58 9 217 0 75 9 221 0 79 9 225 0 111 2 225 0 134 9 229 0 139 9 233 0 140 15 153 0 166 9 241 0 201 15 153 0 202] 
#[0 5 226 0 7 0 8] 
#[1 2 130 0 7 2 130 0 8 15 157 0 165] 
#[0 5 230 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 161 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 15 165 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 15 169 0 181 15 169 0 182] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 173 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 15 177 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 15 181 0 181 15 181 0 182] 
#[0 15 185 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 189 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 193 0 178] 
#[0 15 197 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 201 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 205 0 178] 
#[1 15 209 0 120 15 213 0 138] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 15 217 0 180] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 15 221 0 184] 
#[0 15 225 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 229 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 233 0 178] 
#[0 15 237 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 15 241 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 15 245 0 178] 
#[1 3 26 0 7 3 26 0 8 15 249 0 20 3 26 0 30 3 26 0 32 3 26 0 34 3 26 0 35 3 26 0 40 3 26 0 58 3 26 0 78 3 26 0 104 3 26 0 107 3 26 0 111 3 26 0 119 3 26 0 132 15 249 0 176] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 15 253 0 180] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 16 1 0 184] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 16 5 0 178] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 16 9 0 181 16 9 0 182] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 16 13 0 186] 
#[1 16 17 0 47 16 21 0 54 16 25 0 62] 
#[0 5 234 0 7 0 8 0 30 0 40 0 58 0 107 0 111 0 119] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 16 37 0 188] 
#[0 5 242 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 58 0 67 0 75 0 78 0 95 0 96 0 97 0 104 0 107 0 111 0 119 0 132 0 139] 
#[1 2 206 0 6 7 133 0 15 7 137 0 216 16 41 0 217] 
#[0 16 45 0 6] 
#[1 2 42 0 68 16 49 0 78] 
#[0 16 53 0 68] 
#[0 16 57 0 253 1 11] 
#[1 16 61 0 17 16 61 0 162 1 50 1 11] 
#[0 5 246 0 12 1 10] 
#[0 5 250 0 7 0 8] 
#[0 5 254 0 7 0 8] 
#[1 16 65 0 7 8 45 0 8 8 49 0 164] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 16 69 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 16 73 0 181 16 73 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 16 77 0 193 16 81 0 204] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 16 85 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 16 89 0 181 16 89 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 16 93 0 193 16 81 0 204] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 16 97 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 16 101 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 16 105 0 180] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 16 109 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 16 113 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 16 117 0 180] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 16 121 0 95 16 125 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 16 129 0 175] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 16 133 0 95 16 137 0 96 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 16 141 0 175] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 16 145 0 181 16 145 0 182] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 16 149 0 186] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 16 153 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 16 157 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 16 161 0 180] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 16 165 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 16 169 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 16 173 0 180] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 32 3 122 0 34 3 122 0 35 3 122 0 40 3 122 0 58 3 122 0 78 3 122 0 104 3 122 0 107 3 122 0 111 3 122 0 119 10 181 0 132 10 185 0 177 16 177 0 178] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 16 181 0 181 16 181 0 182] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 16 185 0 186] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 16 189 0 180] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 16 193 0 184] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 16 197 0 188] 
#[0 6 6 0 7 0 8 0 30 0 40 0 58 0 107 0 111 0 119] 
#[0 6 10 0 7 0 8 0 30 0 40 0 58 0 107 0 111 0 119] 
#[0 6 14 0 7 0 8 0 30 0 40 0 58 0 107 0 111 0 119] 
#[1 16 201 0 13 16 205 0 143] 
#[0 6 18 0 7 0 8 0 30 0 40 0 107 0 111 0 119] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 16 217 0 190] 
#[0 16 221 0 6] 
#[0 16 225 0 254 1 11] 
#[1 2 206 0 6 7 133 0 15 7 137 0 216 16 229 0 217] 
#[0 16 233 0 6] 
#[0 6 26 0 12 1 10] 
#[0 16 237 0 253 1 11] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 16 241 0 87 16 245 0 97 16 249 0 205 16 253 0 206] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 1 0 181 17 1 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 17 5 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 17 13 0 194 17 17 0 203] 
#[0 6 38 0 7 0 8 0 30 0 40] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 21 0 181 17 21 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 17 25 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 17 29 0 194 17 17 0 203] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 17 33 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 17 37 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 41 0 181 17 41 0 182] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 17 45 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 17 49 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 53 0 181 17 53 0 182] 
#[0 17 57 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 17 61 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 17 65 0 178] 
#[0 17 69 0 96] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 17 73 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 17 77 0 178] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 17 81 0 184] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 17 85 0 188] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 17 89 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 17 93 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 97 0 181 17 97 0 182] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 17 101 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 17 105 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 109 0 181 17 109 0 182] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 32 4 30 0 34 4 30 0 35 4 30 0 40 4 30 0 58 12 109 0 78 12 113 0 104 4 30 0 107 4 30 0 111 4 30 0 119 12 117 0 179 17 113 0 180] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 17 117 0 184] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 17 121 0 188] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 17 125 0 181 17 125 0 182] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 17 129 0 186] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 17 133 0 190] 
#[0 17 137 0 143] 
#[0 6 42 0 7 0 8 0 30 0 40 0 107 0 111 0 119] 
#[1 17 141 0 13 17 145 0 143] 
#[0 6 46 0 7 0 8 0 30 0 40 0 107 0 119] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 17 157 0 192] 
#[1 9 29 0 146 9 29 0 246 17 161 1 2] 
#[0 17 165 0 7] 
#[0 17 169 0 6] 
#[0 17 173 0 254 1 11] 
#[0 6 54 0 12 1 10] 
#[1 17 177 0 65 17 181 0 100 17 185 0 113] 
#[1 17 189 0 49 17 193 0 133] 
#[0 6 58 0 7 0 8 0 30 0 40] 
#[0 6 62 0 7 0 8 0 30 0 40] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 17 197 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 17 201 0 194 17 17 0 203] 
#[1 2 173 0 30 17 205 1 3 17 205 1 11] 
#[0 6 66 0 7 0 8] 
#[0 6 70 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 17 209 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 17 213 0 194 17 17 0 203] 
#[0 6 74 0 7 0 8] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 17 217 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 221 0 181 17 221 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 17 225 0 193 16 81 0 204] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 17 229 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 17 233 0 181 17 233 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 17 237 0 193 16 81 0 204] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 17 241 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 17 245 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 17 249 0 180] 
#[1 2 166 0 7 2 166 0 8 2 166 0 30 2 166 0 35 2 166 0 40 7 61 0 75 2 166 0 78 2 166 0 104 2 166 0 107 2 166 0 132 7 65 0 139 7 69 0 174 17 253 0 175] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 18 1 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 18 5 0 180] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 18 9 0 186] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 18 13 0 190] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 18 17 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 21 0 181 18 21 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 18 25 0 193 16 81 0 204] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 18 29 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 33 0 181 18 33 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 18 37 0 193 16 81 0 204] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 4 210 0 32 4 210 0 34 13 193 0 35 4 210 0 40 4 210 0 58 4 210 0 107 4 210 0 111 4 210 0 119 18 41 0 181 18 41 0 182] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 18 45 0 186] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 18 49 0 190] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 18 53 0 184] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 18 57 0 188] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 18 61 0 192] 
#[0 6 78 0 7 0 8 0 30 0 40 0 107 0 111 0 119] 
#[0 18 65 0 143] 
#[0 6 82 0 7 0 8 0 30 0 40 0 107 0 119] 
#[1 18 69 0 52 18 73 0 92] 
#[0 6 86 0 7 0 8 0 30 0 40 0 107] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 18 77 0 193 16 81 0 204] 
#[0 18 81 0 7] 
#[1 6 90 0 6 18 85 0 122 18 89 0 220 18 93 0 221] 
#[1 9 29 0 146 9 29 0 246 18 97 1 2] 
#[0 18 101 0 7] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 18 105 0 97 16 249 0 205 18 109 0 206] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 18 113 0 97 16 249 0 205 18 117 0 206] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 18 121 0 97 16 249 0 205 18 125 0 206] 
#[1 18 129 0 26 18 133 0 94 18 137 0 109 18 141 0 112 18 145 0 207] 
#[1 18 129 0 26 18 133 0 94 18 137 0 109 18 141 0 112 18 149 0 207] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 18 153 0 194 17 17 0 203] 
#[0 6 94 0 7 0 8] 
#[0 4 225 0 30] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 18 157 0 194 17 17 0 203] 
#[0 6 98 0 7 0 8] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 161 0 181 18 161 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 18 165 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 18 169 0 194 17 17 0 203] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 173 0 181 18 173 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 18 177 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 18 181 0 194 17 17 0 203] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 18 185 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 18 189 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 193 0 181 18 193 0 182] 
#[1 3 122 0 7 3 122 0 8 3 122 0 30 3 122 0 35 3 122 0 40 3 122 0 78 3 122 0 104 3 122 0 107 10 181 0 132 10 185 0 177 18 197 0 178] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 18 201 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 205 0 181 18 205 0 182] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 18 209 0 188] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 18 213 0 192] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 217 0 181 18 217 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 18 221 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 18 225 0 194 17 17 0 203] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 18 229 0 181 18 229 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 18 233 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 18 237 0 194 17 17 0 203] 
#[1 4 18 0 7 4 18 0 8 4 18 0 30 12 37 0 32 4 18 0 34 4 18 0 40 4 18 0 58 4 18 0 107 4 18 0 111 4 18 0 119 12 41 0 183 18 241 0 184] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 18 245 0 188] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 18 249 0 192] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 18 253 0 186] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 19 1 0 190] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 5 0 193 16 81 0 204] 
#[0 6 102 0 7 0 8 0 30 0 40 0 107 0 119] 
#[0 6 106 0 7 0 8 0 30 0 40 0 107] 
#[0 6 110 0 7 0 8 0 30 0 40 0 107] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 9 0 194 17 17 0 203] 
#[1 6 90 0 6 18 85 0 122 18 89 0 220 19 13 0 221] 
#[0 19 17 0 144 1 6] 
#[0 6 114 0 6] 
#[0 19 21 0 6] 
#[0 19 25 0 7] 
#[1 6 90 0 6 18 85 0 122 18 89 0 220 19 29 0 221] 
#[1 19 33 0 49 17 193 0 133] 
#[0 6 118 0 7 0 8 0 30 0 40] 
#[1 19 37 0 49 17 193 0 133] 
#[0 6 122 0 7 0 8 0 30 0 40] 
#[1 19 41 0 49 17 193 0 133] 
#[0 6 126 0 7 0 8 0 30 0 40] 
#[0 6 130 0 7 0 8 0 30 0 40 0 97] 
#[0 19 45 0 14] 
#[0 6 134 0 7 0 8 0 30 0 40 0 97] 
#[1 19 49 0 47 19 53 0 96] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 19 57 0 97 16 249 0 205 19 61 0 206] 
#[0 6 138 0 7 0 8 0 30 0 40] 
#[0 6 142 0 7 0 8] 
#[0 6 146 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 65 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 69 0 194 17 17 0 203] 
#[0 6 150 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 73 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 77 0 194 17 17 0 203] 
#[0 6 154 0 7 0 8] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 19 81 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 19 85 0 181 19 85 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 89 0 193 16 81 0 204] 
#[1 4 30 0 7 4 30 0 8 4 30 0 30 4 30 0 35 4 30 0 40 12 109 0 78 12 113 0 104 4 30 0 107 12 117 0 179 19 93 0 180] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 19 97 0 181 19 97 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 101 0 193 16 81 0 204] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 19 105 0 190] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 109 0 193 16 81 0 204] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 113 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 117 0 194 17 17 0 203] 
#[0 6 158 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 121 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 125 0 194 17 17 0 203] 
#[0 6 162 0 7 0 8] 
#[1 5 186 0 7 5 186 0 8 5 186 0 30 15 105 0 34 5 186 0 40 5 186 0 58 5 186 0 107 5 186 0 111 5 186 0 119 15 109 0 185 19 129 0 186] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 19 133 0 190] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 137 0 193 16 81 0 204] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 19 141 0 188] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 19 145 0 192] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 149 0 194 17 17 0 203] 
#[0 6 166 0 7 0 8] 
#[0 19 153 0 6] 
#[0 6 170 0 6] 
#[1 19 157 0 101 19 161 0 224] 
#[1 6 90 0 6 18 85 0 122 18 89 0 220 19 165 0 221] 
#[0 19 169 0 6] 
#[1 18 129 0 26 18 133 0 94 18 137 0 109 18 141 0 112 19 173 0 207] 
#[1 18 129 0 26 18 133 0 94 18 137 0 109 18 141 0 112 19 177 0 207] 
#[1 18 129 0 26 18 133 0 94 18 137 0 109 18 141 0 112 19 181 0 207] 
#[0 6 174 0 7 0 8 0 30 0 40 0 97] 
#[0 6 178 0 7 0 8 0 30 0 40 0 97] 
#[0 6 182 0 7 0 8 0 30 0 40 0 97] 
#[0 17 193 0 133] 
#[0 6 186 0 7 0 8 0 30 0 40] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 185 0 194 17 17 0 203] 
#[0 6 190 0 7 0 8] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 189 0 194 17 17 0 203] 
#[0 6 194 0 7 0 8] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 19 193 0 181 19 193 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 197 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 201 0 194 17 17 0 203] 
#[1 4 210 0 7 4 210 0 8 4 210 0 30 13 193 0 35 4 210 0 40 4 210 0 107 19 205 0 181 19 205 0 182] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 209 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 213 0 194 17 17 0 203] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 19 217 0 192] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 221 0 194 17 17 0 203] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 225 0 194 17 17 0 203] 
#[0 6 198 0 7 0 8] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 229 0 194 17 17 0 203] 
#[0 6 202 0 7 0 8] 
#[1 5 238 0 7 5 238 0 8 5 238 0 30 5 238 0 40 16 29 0 58 5 238 0 107 5 238 0 111 5 238 0 119 16 33 0 187 19 233 0 188] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 19 237 0 192] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 19 241 0 194 17 17 0 203] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 19 245 0 190] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 19 249 0 193 16 81 0 204] 
#[0 6 206 0 7 0 8] 
#[1 19 157 0 101 19 253 0 224] 
#[0 20 1 1 7 1 11] 
#[1 6 210 0 7 6 210 0 8 20 9 0 223] 
#[0 20 13 0 6] 
#[1 19 157 0 101 20 17 0 224] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 19 57 0 97 16 249 0 205 20 21 0 206] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 19 57 0 97 16 249 0 205 20 25 0 206] 
#[1 6 30 0 7 6 30 0 8 6 30 0 30 6 30 0 40 19 57 0 97 16 249 0 205 20 29 0 206] 
#[0 6 214 0 7 0 8] 
#[0 6 218 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 20 33 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 37 0 194 17 17 0 203] 
#[0 6 222 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 20 41 0 193 16 81 0 204] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 45 0 194 17 17 0 203] 
#[0 6 226 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 20 49 0 193 16 81 0 204] 
#[0 6 230 0 7 0 8] 
#[0 6 234 0 7 0 8] 
#[0 6 238 0 7 0 8] 
#[1 6 22 0 7 6 22 0 8 6 22 0 30 6 22 0 40 6 22 0 107 16 209 0 111 6 22 0 119 16 213 0 189 20 53 0 190] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 20 57 0 193 16 81 0 204] 
#[0 6 242 0 7 0 8] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 20 61 0 192] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 65 0 194 17 17 0 203] 
#[1 6 210 0 7 6 210 0 8 20 69 0 223] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 6 246 0 35 6 246 0 43 20 73 0 57 6 246 0 72 6 246 0 89 6 246 0 93 20 77 0 119 6 246 0 124 20 81 0 135 20 85 0 225 20 89 0 226] 
#[0 6 250 0 6 0 7 0 8 0 35 0 43 0 57 0 72 0 89 0 93 0 119 0 124 0 135] 
#[1 20 93 0 7 20 97 0 8 20 101 0 222] 
#[1 19 157 0 101 20 105 0 224] 
#[1 6 210 0 7 6 210 0 8 20 109 0 223] 
#[0 6 254 0 7 0 8 0 30 0 40] 
#[0 7 2 0 7 0 8 0 30 0 40] 
#[0 7 6 0 7 0 8 0 30 0 40] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 113 0 194 17 17 0 203] 
#[0 7 10 0 7 0 8] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 117 0 194 17 17 0 203] 
#[0 7 14 0 7 0 8] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 121 0 194 17 17 0 203] 
#[1 6 50 0 7 6 50 0 8 6 50 0 30 6 50 0 40 6 50 0 107 17 149 0 119 17 153 0 191 20 125 0 192] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 129 0 194 17 17 0 203] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 20 133 0 193 16 81 0 204] 
#[0 7 18 0 7 0 8] 
#[1 20 137 0 7 20 97 0 8 20 101 0 222] 
#[1 20 141 0 13 20 145 0 76 20 145 0 249] 
#[0 20 149 0 57] 
#[1 20 153 0 71 20 157 0 81] 
#[0 7 22 0 6 0 7 0 8 0 35 0 43 0 72 0 89 0 93 0 124] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 161 0 35 7 26 0 43 7 26 0 72 7 26 0 89 7 26 0 93 7 26 0 124 20 165 0 227 20 169 0 228] 
#[0 7 30 0 12 0 17 0 70 0 108 1 10 1 11] 
#[1 19 157 0 101 20 173 0 224] 
#[0 7 34 0 7 0 8] 
#[1 6 210 0 7 6 210 0 8 20 177 0 223] 
#[1 20 181 0 7 20 97 0 8 20 101 0 222] 
#[0 7 38 0 7 0 8] 
#[0 7 42 0 7 0 8] 
#[0 7 46 0 7 0 8] 
#[1 6 2 0 7 6 2 0 8 6 2 0 30 6 2 0 40 11 121 0 107 20 185 0 193 16 81 0 204] 
#[0 7 50 0 7 0 8] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 189 0 194 17 17 0 203] 
#[0 7 54 0 12 0 17 0 70 0 108 1 10 1 11] 
#[0 20 193 0 76 0 249] 
#[0 7 58 0 6 0 7 0 8 0 35 0 43 0 72 0 89 0 93 0 124] 
#[1 20 197 0 13 20 201 0 76 20 201 0 249] 
#[0 20 205 0 6] 
#[0 20 209 0 127] 
#[1 20 213 0 13 20 217 0 143] 
#[0 7 62 0 6 0 7 0 8 0 43 0 72 0 89 0 93 0 124] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 20 229 0 230] 
#[0 7 70 0 7 0 8] 
#[1 20 233 0 7 20 97 0 8 20 101 0 222] 
#[0 7 74 0 12 0 17 0 70 0 108 1 10 1 11] 
#[1 6 34 0 7 6 34 0 8 0 229 0 30 17 9 0 40 20 237 0 194 17 17 0 203] 
#[0 7 78 0 7 0 8] 
#[0 7 82 0 6 0 7 0 8 0 35 0 43 0 72 0 89 0 93 0 124] 
#[0 20 241 0 76 0 249] 
#[0 7 86 0 6 0 7 0 8 0 35 0 43 0 72 0 89 0 93 0 124] 
#[1 7 90 0 7 20 245 0 254 20 249 0 255 20 245 1 11] 
#[1 20 253 0 6 7 90 0 7 21 1 0 88 20 245 0 254 21 5 0 255 20 245 1 11] 
#[0 21 9 0 143] 
#[0 7 94 0 6 0 7 0 8 0 43 0 72 0 89 0 93 0 124] 
#[0 21 13 0 51] 
#[0 7 98 0 6 0 7 0 8 0 72 0 89 0 93 0 124] 
#[1 7 102 0 6 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 21 25 0 232] 
#[0 7 106 0 12 0 17 0 70 0 108 1 10 1 11] 
#[0 7 110 0 7 0 8] 
#[0 7 114 0 6 0 7 0 8 0 35 0 43 0 72 0 89 0 93 0 124] 
#[1 7 118 0 7 7 118 0 8 21 29 1 1] 
#[0 21 33 0 7] 
#[0 21 37 0 254 1 11] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 6 246 0 35 6 246 0 43 20 73 0 57 6 246 0 72 6 246 0 89 6 246 0 93 20 77 0 119 6 246 0 124 20 85 0 225 21 41 0 226] 
#[0 21 45 0 7] 
#[0 7 122 0 6 0 7 0 8 0 43 0 72 0 89 0 93 0 124] 
#[1 21 49 0 13 21 53 0 143] 
#[0 21 57 0 51] 
#[0 7 126 0 6 0 7 0 8 0 89 0 93 0 124] 
#[1 7 130 0 6 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 21 69 0 234] 
#[1 7 134 0 7 21 73 0 8 21 77 1 0] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 6 246 0 35 6 246 0 43 20 73 0 57 6 246 0 72 6 246 0 89 6 246 0 93 20 77 0 119 6 246 0 124 20 85 0 225 21 81 0 226] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 6 246 0 35 6 246 0 43 20 73 0 57 6 246 0 72 6 246 0 89 6 246 0 93 20 77 0 119 6 246 0 124 20 85 0 225 21 85 0 226] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 161 0 35 7 26 0 43 7 26 0 72 7 26 0 89 7 26 0 93 7 26 0 124 20 165 0 227 21 89 0 228] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 6 246 0 35 6 246 0 43 20 73 0 57 6 246 0 72 6 246 0 89 6 246 0 93 20 77 0 119 6 246 0 124 20 85 0 225 21 93 0 226] 
#[0 21 97 0 143] 
#[0 7 138 0 6 0 7 0 8 0 72 0 89 0 93 0 124] 
#[1 21 101 0 13 21 105 0 143] 
#[1 21 109 0 13 21 113 0 144] 
#[0 7 142 0 6 0 7 0 8 0 93 0 124] 
#[1 7 146 0 6 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 21 125 0 236] 
#[0 21 129 0 254 1 11] 
#[0 7 150 0 7 0 8] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 161 0 35 7 26 0 43 7 26 0 72 7 26 0 89 7 26 0 93 7 26 0 124 20 165 0 227 21 133 0 228] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 161 0 35 7 26 0 43 7 26 0 72 7 26 0 89 7 26 0 93 7 26 0 124 20 165 0 227 21 137 0 228] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 21 141 0 230] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 161 0 35 7 26 0 43 7 26 0 72 7 26 0 89 7 26 0 93 7 26 0 124 20 165 0 227 21 145 0 228] 
#[0 7 154 0 6 0 7 0 8 0 72 0 89 0 93 0 124] 
#[0 21 149 0 143] 
#[0 7 158 0 6 0 7 0 8 0 89 0 93 0 124] 
#[0 21 153 0 144] 
#[0 7 162 0 6 0 7 0 8 0 93 0 124] 
#[1 21 157 0 13 21 161 0 144] 
#[0 7 166 0 6 0 7 0 8 0 124] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 21 173 0 238] 
#[0 7 174 0 7 0 8] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 21 177 0 230] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 21 181 0 230] 
#[1 7 102 0 6 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 21 185 0 232] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 21 189 0 230] 
#[0 7 178 0 6 0 7 0 8 0 89 0 93 0 124] 
#[0 7 182 0 6 0 7 0 8 0 93 0 124] 
#[0 21 193 0 144] 
#[0 7 186 0 6 0 7 0 8 0 124] 
#[1 21 197 0 13 21 201 1 5 21 201 1 11] 
#[0 7 190 0 6 0 7 0 8] 
#[1 21 205 0 6 7 194 0 7 7 194 0 8 21 209 0 239 21 213 0 240] 
#[1 7 102 0 6 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 21 217 0 232] 
#[1 7 102 0 6 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 21 221 0 232] 
#[1 7 130 0 6 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 21 225 0 234] 
#[1 7 102 0 6 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 21 229 0 232] 
#[0 7 198 0 6 0 7 0 8 0 124] 
#[0 21 233 1 5 1 11] 
#[0 7 202 0 6 0 7 0 8] 
#[1 21 237 0 121 21 241 0 243] 
#[0 7 206 0 7 0 8] 
#[0 7 210 0 7 0 8] 
#[1 7 130 0 6 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 21 245 0 234] 
#[1 7 130 0 6 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 21 249 0 234] 
#[1 7 146 0 6 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 21 253 0 236] 
#[1 7 130 0 6 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 22 1 0 234] 
#[0 7 214 0 6 0 7 0 8] 
#[0 22 5 1 8 1 11] 
#[1 7 218 0 7 7 218 0 8 22 13 0 242] 
#[1 7 146 0 6 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 22 17 0 236] 
#[1 7 146 0 6 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 22 21 0 236] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 22 25 0 238] 
#[1 7 146 0 6 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 22 29 0 236] 
#[1 7 66 0 7 7 66 0 8 22 33 0 35 20 221 0 43 22 37 0 57 7 66 0 72 7 66 0 89 7 66 0 93 22 41 0 119 7 66 0 124 20 225 0 229 22 45 0 230] 
#[0 7 222 0 7 0 8 0 35 0 43 0 57 0 72 0 89 0 93 0 119 0 124] 
#[1 22 49 0 7 22 53 0 8 22 57 0 241] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 22 61 0 238] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 22 65 0 238] 
#[1 21 205 0 6 7 194 0 7 7 194 0 8 21 209 0 239 22 69 0 240] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 22 73 0 238] 
#[1 22 81 0 13 7 226 0 143 22 81 0 244] 
#[1 22 85 0 13 22 89 0 76 22 89 0 249] 
#[0 22 93 0 57] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 22 97 0 232] 
#[0 7 230 0 7 0 8] 
#[1 21 237 0 121 22 101 0 243] 
#[0 7 234 0 7 0 8] 
#[1 21 205 0 6 7 194 0 7 7 194 0 8 21 209 0 239 22 105 0 240] 
#[1 21 205 0 6 7 194 0 7 7 194 0 8 21 209 0 239 22 109 0 240] 
#[0 7 238 0 7 0 8] 
#[1 21 205 0 6 7 194 0 7 7 194 0 8 21 209 0 239 22 113 0 240] 
#[0 7 242 0 143] 
#[0 22 117 0 143] 
#[0 22 121 0 76 0 249] 
#[1 7 66 0 7 7 66 0 8 22 125 0 35 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 22 129 0 230] 
#[1 22 133 0 13 22 137 0 76 22 137 0 249] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 22 141 0 234] 
#[0 7 246 0 7 0 8] 
#[0 7 250 0 7 0 8] 
#[0 7 254 0 7 0 8] 
#[0 8 2 0 7 0 8] 
#[1 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 22 145 0 230] 
#[1 7 66 0 7 7 66 0 8 22 149 0 35 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 22 153 0 230] 
#[1 22 157 0 13 7 226 0 143 22 157 0 244] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 22 161 0 232] 
#[0 22 165 0 76 0 249] 
#[1 7 66 0 7 7 66 0 8 22 169 0 35 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 22 173 0 230] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 22 177 0 236] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 22 181 0 232] 
#[1 22 185 0 13 7 226 0 143 22 185 0 244] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 22 189 0 232] 
#[0 22 193 0 143] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 22 197 0 234] 
#[1 7 66 0 7 7 66 0 8 22 201 0 35 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 22 205 0 230] 
#[1 22 209 0 13 7 226 0 143 22 209 0 244] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 22 213 0 232] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 22 217 0 238] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 22 221 0 234] 
#[0 22 225 0 143] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 22 229 0 234] 
#[1 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 22 233 0 230] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 22 237 0 236] 
#[1 22 241 0 13 7 226 0 143 22 241 0 244] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 22 245 0 232] 
#[0 22 249 0 143] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 22 253 0 234] 
#[0 8 6 0 7 0 8] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 1 0 236] 
#[1 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 23 5 0 230] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 9 0 236] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 23 13 0 232] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 17 0 238] 
#[0 23 21 0 143] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 23 25 0 234] 
#[1 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 23 29 0 230] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 33 0 236] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 37 0 238] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 23 41 0 232] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 45 0 238] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 23 49 0 234] 
#[0 8 10 0 7 0 8] 
#[1 7 66 0 7 7 66 0 8 20 221 0 43 7 66 0 72 7 66 0 89 7 66 0 93 7 66 0 124 20 225 0 229 23 53 0 230] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 57 0 236] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 23 61 0 232] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 65 0 238] 
#[0 8 14 0 7 0 8] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 23 69 0 234] 
#[0 8 18 0 7 0 8] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 73 0 236] 
#[1 7 102 0 7 7 102 0 8 21 17 0 72 7 102 0 89 7 102 0 93 7 102 0 124 21 21 0 231 23 77 0 232] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 81 0 238] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 23 85 0 234] 
#[0 8 22 0 7 0 8] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 89 0 236] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 93 0 238] 
#[1 7 130 0 7 7 130 0 8 21 61 0 89 7 130 0 93 7 130 0 124 21 65 0 233 23 97 0 234] 
#[0 8 26 0 7 0 8] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 101 0 236] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 105 0 238] 
#[0 8 30 0 7 0 8] 
#[1 7 146 0 7 7 146 0 8 21 117 0 93 7 146 0 124 21 121 0 235 23 109 0 236] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 113 0 238] 
#[0 8 34 0 7 0 8] 
#[1 7 170 0 7 7 170 0 8 21 165 0 124 21 169 0 237 23 117 0 238] 
#[0 8 38 0 7 0 8] 
#[0 8 42 0 7 0 8]
	).
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable10: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addNode: (nodes at: 6) to: result definitions.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addNodes: ((nodes at: 7) at: 2) to: result definitions.
	result addToken: (nodes at: 8) to: result rightParens.
	result partitionToken: ((nodes at: 9) at: 1).
	result addTokens: ((nodes at: 9) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 9) at: 3).
	result addTokens: ((nodes at: 9) at: 4) to: result leftParens.
	result _hash: ((nodes at: 9) at: 5).
	result addTokens: ((nodes at: 9) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 9) at: 7).
	result keyToken: ((nodes at: 9) at: 8).
	result algorithmToken: ((nodes at: 9) at: 9).
	result equals: ((nodes at: 9) at: 10).
	result value: ((nodes at: 9) at: 11).
	result addTokens: ((nodes at: 9) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 9) at: 13) to: result commas.
	result rangeToken: ((nodes at: 9) at: 14).
	result range: ((nodes at: 9) at: 15).
	result columnsToken: ((nodes at: 9) at: 16).
	result listToken: ((nodes at: 9) at: 17).
	result list: ((nodes at: 9) at: 18).
	result partitionsToken: ((nodes at: 9) at: 19).
	result partitions: ((nodes at: 9) at: 20).
	result subpartitionToken: ((nodes at: 9) at: 21).
	result subpartitionsToken: ((nodes at: 9) at: 22).
	result subpartitions: ((nodes at: 9) at: 23).
	result addNodes: ((nodes at: 9) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable11: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addNode: (nodes at: 6) to: result definitions.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addNodes: ((nodes at: 7) at: 2) to: result definitions.
	result addToken: (nodes at: 8) to: result rightParens.
	result addNodes: ((nodes at: 9) at: 1) to: result options.
	result addTokens: ((nodes at: 9) at: 2) to: result commas.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable12: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addNode: (nodes at: 6) to: result definitions.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addNodes: ((nodes at: 7) at: 2) to: result definitions.
	result addToken: (nodes at: 8) to: result rightParens.
	result addNodes: ((nodes at: 9) at: 1) to: result options.
	result addTokens: ((nodes at: 9) at: 2) to: result commas.
	result partitionToken: ((nodes at: 10) at: 1).
	result addTokens: ((nodes at: 10) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 10) at: 3).
	result addTokens: ((nodes at: 10) at: 4) to: result leftParens.
	result _hash: ((nodes at: 10) at: 5).
	result addTokens: ((nodes at: 10) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 10) at: 7).
	result keyToken: ((nodes at: 10) at: 8).
	result algorithmToken: ((nodes at: 10) at: 9).
	result equals: ((nodes at: 10) at: 10).
	result value: ((nodes at: 10) at: 11).
	result addTokens: ((nodes at: 10) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 10) at: 13) to: result commas.
	result rangeToken: ((nodes at: 10) at: 14).
	result range: ((nodes at: 10) at: 15).
	result columnsToken: ((nodes at: 10) at: 16).
	result listToken: ((nodes at: 10) at: 17).
	result list: ((nodes at: 10) at: 18).
	result partitionsToken: ((nodes at: 10) at: 19).
	result partitions: ((nodes at: 10) at: 20).
	result subpartitionToken: ((nodes at: 10) at: 21).
	result subpartitionsToken: ((nodes at: 10) at: 22).
	result subpartitions: ((nodes at: 10) at: 23).
	result addNodes: ((nodes at: 10) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable13: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result leftParens.
	result addNode: (nodes at: 9) to: result definitions.
	result addTokens: ((nodes at: 10) at: 1) to: result commas.
	result addNodes: ((nodes at: 10) at: 2) to: result definitions.
	result addToken: (nodes at: 11) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable14: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result leftParens.
	result addNode: (nodes at: 9) to: result definitions.
	result addTokens: ((nodes at: 10) at: 1) to: result commas.
	result addNodes: ((nodes at: 10) at: 2) to: result definitions.
	result addToken: (nodes at: 11) to: result rightParens.
	result partitionToken: ((nodes at: 12) at: 1).
	result addTokens: ((nodes at: 12) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 12) at: 3).
	result addTokens: ((nodes at: 12) at: 4) to: result leftParens.
	result _hash: ((nodes at: 12) at: 5).
	result addTokens: ((nodes at: 12) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 12) at: 7).
	result keyToken: ((nodes at: 12) at: 8).
	result algorithmToken: ((nodes at: 12) at: 9).
	result equals: ((nodes at: 12) at: 10).
	result value: ((nodes at: 12) at: 11).
	result addTokens: ((nodes at: 12) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 12) at: 13) to: result commas.
	result rangeToken: ((nodes at: 12) at: 14).
	result range: ((nodes at: 12) at: 15).
	result columnsToken: ((nodes at: 12) at: 16).
	result listToken: ((nodes at: 12) at: 17).
	result list: ((nodes at: 12) at: 18).
	result partitionsToken: ((nodes at: 12) at: 19).
	result partitions: ((nodes at: 12) at: 20).
	result subpartitionToken: ((nodes at: 12) at: 21).
	result subpartitionsToken: ((nodes at: 12) at: 22).
	result subpartitions: ((nodes at: 12) at: 23).
	result addNodes: ((nodes at: 12) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable15: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result leftParens.
	result addNode: (nodes at: 9) to: result definitions.
	result addTokens: ((nodes at: 10) at: 1) to: result commas.
	result addNodes: ((nodes at: 10) at: 2) to: result definitions.
	result addToken: (nodes at: 11) to: result rightParens.
	result addNodes: ((nodes at: 12) at: 1) to: result options.
	result addTokens: ((nodes at: 12) at: 2) to: result commas.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable16: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result leftParens.
	result addNode: (nodes at: 9) to: result definitions.
	result addTokens: ((nodes at: 10) at: 1) to: result commas.
	result addNodes: ((nodes at: 10) at: 2) to: result definitions.
	result addToken: (nodes at: 11) to: result rightParens.
	result addNodes: ((nodes at: 12) at: 1) to: result options.
	result addTokens: ((nodes at: 12) at: 2) to: result commas.
	result partitionToken: ((nodes at: 13) at: 1).
	result addTokens: ((nodes at: 13) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 13) at: 3).
	result addTokens: ((nodes at: 13) at: 4) to: result leftParens.
	result _hash: ((nodes at: 13) at: 5).
	result addTokens: ((nodes at: 13) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 13) at: 7).
	result keyToken: ((nodes at: 13) at: 8).
	result algorithmToken: ((nodes at: 13) at: 9).
	result equals: ((nodes at: 13) at: 10).
	result value: ((nodes at: 13) at: 11).
	result addTokens: ((nodes at: 13) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 13) at: 13) to: result commas.
	result rangeToken: ((nodes at: 13) at: 14).
	result range: ((nodes at: 13) at: 15).
	result columnsToken: ((nodes at: 13) at: 16).
	result listToken: ((nodes at: 13) at: 17).
	result list: ((nodes at: 13) at: 18).
	result partitionsToken: ((nodes at: 13) at: 19).
	result partitions: ((nodes at: 13) at: 20).
	result subpartitionToken: ((nodes at: 13) at: 21).
	result subpartitionsToken: ((nodes at: 13) at: 22).
	result subpartitions: ((nodes at: 13) at: 23).
	result addNodes: ((nodes at: 13) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable17: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result partitionToken: ((nodes at: 4) at: 1).
	result addTokens: ((nodes at: 4) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 4) at: 3).
	result addTokens: ((nodes at: 4) at: 4) to: result leftParens.
	result _hash: ((nodes at: 4) at: 5).
	result addTokens: ((nodes at: 4) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 4) at: 7).
	result keyToken: ((nodes at: 4) at: 8).
	result algorithmToken: ((nodes at: 4) at: 9).
	result equals: ((nodes at: 4) at: 10).
	result value: ((nodes at: 4) at: 11).
	result addTokens: ((nodes at: 4) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 4) at: 13) to: result commas.
	result rangeToken: ((nodes at: 4) at: 14).
	result range: ((nodes at: 4) at: 15).
	result columnsToken: ((nodes at: 4) at: 16).
	result listToken: ((nodes at: 4) at: 17).
	result list: ((nodes at: 4) at: 18).
	result partitionsToken: ((nodes at: 4) at: 19).
	result partitions: ((nodes at: 4) at: 20).
	result subpartitionToken: ((nodes at: 4) at: 21).
	result subpartitionsToken: ((nodes at: 4) at: 22).
	result subpartitions: ((nodes at: 4) at: 23).
	result addNodes: ((nodes at: 4) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 5) at: 1).
	result replaceToken: ((nodes at: 5) at: 2).
	result asToken: (nodes at: 6).
	result query: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable18: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addNodes: ((nodes at: 4) at: 1) to: result options.
	result addTokens: ((nodes at: 4) at: 2) to: result commas.
	result partitionToken: ((nodes at: 5) at: 1).
	result addTokens: ((nodes at: 5) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 5) at: 3).
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result _hash: ((nodes at: 5) at: 5).
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 5) at: 7).
	result keyToken: ((nodes at: 5) at: 8).
	result algorithmToken: ((nodes at: 5) at: 9).
	result equals: ((nodes at: 5) at: 10).
	result value: ((nodes at: 5) at: 11).
	result addTokens: ((nodes at: 5) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 5) at: 13) to: result commas.
	result rangeToken: ((nodes at: 5) at: 14).
	result range: ((nodes at: 5) at: 15).
	result columnsToken: ((nodes at: 5) at: 16).
	result listToken: ((nodes at: 5) at: 17).
	result list: ((nodes at: 5) at: 18).
	result partitionsToken: ((nodes at: 5) at: 19).
	result partitions: ((nodes at: 5) at: 20).
	result subpartitionToken: ((nodes at: 5) at: 21).
	result subpartitionsToken: ((nodes at: 5) at: 22).
	result subpartitions: ((nodes at: 5) at: 23).
	result addNodes: ((nodes at: 5) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 6) at: 1).
	result replaceToken: ((nodes at: 6) at: 2).
	result asToken: (nodes at: 7).
	result query: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable19: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addNode: (nodes at: 5) to: result definitions.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addNodes: ((nodes at: 6) at: 2) to: result definitions.
	result addToken: (nodes at: 7) to: result rightParens.
	result partitionToken: ((nodes at: 8) at: 1).
	result addTokens: ((nodes at: 8) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 8) at: 3).
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result _hash: ((nodes at: 8) at: 5).
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 8) at: 7).
	result keyToken: ((nodes at: 8) at: 8).
	result algorithmToken: ((nodes at: 8) at: 9).
	result equals: ((nodes at: 8) at: 10).
	result value: ((nodes at: 8) at: 11).
	result addTokens: ((nodes at: 8) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 8) at: 13) to: result commas.
	result rangeToken: ((nodes at: 8) at: 14).
	result range: ((nodes at: 8) at: 15).
	result columnsToken: ((nodes at: 8) at: 16).
	result listToken: ((nodes at: 8) at: 17).
	result list: ((nodes at: 8) at: 18).
	result partitionsToken: ((nodes at: 8) at: 19).
	result partitions: ((nodes at: 8) at: 20).
	result subpartitionToken: ((nodes at: 8) at: 21).
	result subpartitionsToken: ((nodes at: 8) at: 22).
	result subpartitions: ((nodes at: 8) at: 23).
	result addNodes: ((nodes at: 8) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 9) at: 1).
	result replaceToken: ((nodes at: 9) at: 2).
	result asToken: (nodes at: 10).
	result query: (nodes at: 11).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable1: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addNode: (nodes at: 5) to: result definitions.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addNodes: ((nodes at: 6) at: 2) to: result definitions.
	result addToken: (nodes at: 7) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable20: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addNode: (nodes at: 5) to: result definitions.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addNodes: ((nodes at: 6) at: 2) to: result definitions.
	result addToken: (nodes at: 7) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 1) to: result options.
	result addTokens: ((nodes at: 8) at: 2) to: result commas.
	result partitionToken: ((nodes at: 9) at: 1).
	result addTokens: ((nodes at: 9) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 9) at: 3).
	result addTokens: ((nodes at: 9) at: 4) to: result leftParens.
	result _hash: ((nodes at: 9) at: 5).
	result addTokens: ((nodes at: 9) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 9) at: 7).
	result keyToken: ((nodes at: 9) at: 8).
	result algorithmToken: ((nodes at: 9) at: 9).
	result equals: ((nodes at: 9) at: 10).
	result value: ((nodes at: 9) at: 11).
	result addTokens: ((nodes at: 9) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 9) at: 13) to: result commas.
	result rangeToken: ((nodes at: 9) at: 14).
	result range: ((nodes at: 9) at: 15).
	result columnsToken: ((nodes at: 9) at: 16).
	result listToken: ((nodes at: 9) at: 17).
	result list: ((nodes at: 9) at: 18).
	result partitionsToken: ((nodes at: 9) at: 19).
	result partitions: ((nodes at: 9) at: 20).
	result subpartitionToken: ((nodes at: 9) at: 21).
	result subpartitionsToken: ((nodes at: 9) at: 22).
	result subpartitions: ((nodes at: 9) at: 23).
	result addNodes: ((nodes at: 9) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 10) at: 1).
	result replaceToken: ((nodes at: 10) at: 2).
	result asToken: (nodes at: 11).
	result query: (nodes at: 12).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable21: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result partitionToken: ((nodes at: 7) at: 1).
	result addTokens: ((nodes at: 7) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 7) at: 3).
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result _hash: ((nodes at: 7) at: 5).
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 7) at: 7).
	result keyToken: ((nodes at: 7) at: 8).
	result algorithmToken: ((nodes at: 7) at: 9).
	result equals: ((nodes at: 7) at: 10).
	result value: ((nodes at: 7) at: 11).
	result addTokens: ((nodes at: 7) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 7) at: 13) to: result commas.
	result rangeToken: ((nodes at: 7) at: 14).
	result range: ((nodes at: 7) at: 15).
	result columnsToken: ((nodes at: 7) at: 16).
	result listToken: ((nodes at: 7) at: 17).
	result list: ((nodes at: 7) at: 18).
	result partitionsToken: ((nodes at: 7) at: 19).
	result partitions: ((nodes at: 7) at: 20).
	result subpartitionToken: ((nodes at: 7) at: 21).
	result subpartitionsToken: ((nodes at: 7) at: 22).
	result subpartitions: ((nodes at: 7) at: 23).
	result addNodes: ((nodes at: 7) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 8) at: 1).
	result replaceToken: ((nodes at: 8) at: 2).
	result asToken: (nodes at: 9).
	result query: (nodes at: 10).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable22: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addNodes: ((nodes at: 7) at: 1) to: result options.
	result addTokens: ((nodes at: 7) at: 2) to: result commas.
	result partitionToken: ((nodes at: 8) at: 1).
	result addTokens: ((nodes at: 8) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 8) at: 3).
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result _hash: ((nodes at: 8) at: 5).
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 8) at: 7).
	result keyToken: ((nodes at: 8) at: 8).
	result algorithmToken: ((nodes at: 8) at: 9).
	result equals: ((nodes at: 8) at: 10).
	result value: ((nodes at: 8) at: 11).
	result addTokens: ((nodes at: 8) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 8) at: 13) to: result commas.
	result rangeToken: ((nodes at: 8) at: 14).
	result range: ((nodes at: 8) at: 15).
	result columnsToken: ((nodes at: 8) at: 16).
	result listToken: ((nodes at: 8) at: 17).
	result list: ((nodes at: 8) at: 18).
	result partitionsToken: ((nodes at: 8) at: 19).
	result partitions: ((nodes at: 8) at: 20).
	result subpartitionToken: ((nodes at: 8) at: 21).
	result subpartitionsToken: ((nodes at: 8) at: 22).
	result subpartitions: ((nodes at: 8) at: 23).
	result addNodes: ((nodes at: 8) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 9) at: 1).
	result replaceToken: ((nodes at: 9) at: 2).
	result asToken: (nodes at: 10).
	result query: (nodes at: 11).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable23: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result leftParens.
	result addNode: (nodes at: 8) to: result definitions.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addNodes: ((nodes at: 9) at: 2) to: result definitions.
	result addToken: (nodes at: 10) to: result rightParens.
	result partitionToken: ((nodes at: 11) at: 1).
	result addTokens: ((nodes at: 11) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 11) at: 3).
	result addTokens: ((nodes at: 11) at: 4) to: result leftParens.
	result _hash: ((nodes at: 11) at: 5).
	result addTokens: ((nodes at: 11) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 11) at: 7).
	result keyToken: ((nodes at: 11) at: 8).
	result algorithmToken: ((nodes at: 11) at: 9).
	result equals: ((nodes at: 11) at: 10).
	result value: ((nodes at: 11) at: 11).
	result addTokens: ((nodes at: 11) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 11) at: 13) to: result commas.
	result rangeToken: ((nodes at: 11) at: 14).
	result range: ((nodes at: 11) at: 15).
	result columnsToken: ((nodes at: 11) at: 16).
	result listToken: ((nodes at: 11) at: 17).
	result list: ((nodes at: 11) at: 18).
	result partitionsToken: ((nodes at: 11) at: 19).
	result partitions: ((nodes at: 11) at: 20).
	result subpartitionToken: ((nodes at: 11) at: 21).
	result subpartitionsToken: ((nodes at: 11) at: 22).
	result subpartitions: ((nodes at: 11) at: 23).
	result addNodes: ((nodes at: 11) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 12) at: 1).
	result replaceToken: ((nodes at: 12) at: 2).
	result asToken: (nodes at: 13).
	result query: (nodes at: 14).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable24: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result leftParens.
	result addNode: (nodes at: 8) to: result definitions.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addNodes: ((nodes at: 9) at: 2) to: result definitions.
	result addToken: (nodes at: 10) to: result rightParens.
	result addNodes: ((nodes at: 11) at: 1) to: result options.
	result addTokens: ((nodes at: 11) at: 2) to: result commas.
	result partitionToken: ((nodes at: 12) at: 1).
	result addTokens: ((nodes at: 12) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 12) at: 3).
	result addTokens: ((nodes at: 12) at: 4) to: result leftParens.
	result _hash: ((nodes at: 12) at: 5).
	result addTokens: ((nodes at: 12) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 12) at: 7).
	result keyToken: ((nodes at: 12) at: 8).
	result algorithmToken: ((nodes at: 12) at: 9).
	result equals: ((nodes at: 12) at: 10).
	result value: ((nodes at: 12) at: 11).
	result addTokens: ((nodes at: 12) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 12) at: 13) to: result commas.
	result rangeToken: ((nodes at: 12) at: 14).
	result range: ((nodes at: 12) at: 15).
	result columnsToken: ((nodes at: 12) at: 16).
	result listToken: ((nodes at: 12) at: 17).
	result list: ((nodes at: 12) at: 18).
	result partitionsToken: ((nodes at: 12) at: 19).
	result partitions: ((nodes at: 12) at: 20).
	result subpartitionToken: ((nodes at: 12) at: 21).
	result subpartitionsToken: ((nodes at: 12) at: 22).
	result subpartitions: ((nodes at: 12) at: 23).
	result addNodes: ((nodes at: 12) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 13) at: 1).
	result replaceToken: ((nodes at: 13) at: 2).
	result asToken: (nodes at: 14).
	result query: (nodes at: 15).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable25: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result partitionToken: ((nodes at: 5) at: 1).
	result addTokens: ((nodes at: 5) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 5) at: 3).
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result _hash: ((nodes at: 5) at: 5).
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 5) at: 7).
	result keyToken: ((nodes at: 5) at: 8).
	result algorithmToken: ((nodes at: 5) at: 9).
	result equals: ((nodes at: 5) at: 10).
	result value: ((nodes at: 5) at: 11).
	result addTokens: ((nodes at: 5) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 5) at: 13) to: result commas.
	result rangeToken: ((nodes at: 5) at: 14).
	result range: ((nodes at: 5) at: 15).
	result columnsToken: ((nodes at: 5) at: 16).
	result listToken: ((nodes at: 5) at: 17).
	result list: ((nodes at: 5) at: 18).
	result partitionsToken: ((nodes at: 5) at: 19).
	result partitions: ((nodes at: 5) at: 20).
	result subpartitionToken: ((nodes at: 5) at: 21).
	result subpartitionsToken: ((nodes at: 5) at: 22).
	result subpartitions: ((nodes at: 5) at: 23).
	result addNodes: ((nodes at: 5) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 6) at: 1).
	result replaceToken: ((nodes at: 6) at: 2).
	result asToken: (nodes at: 7).
	result query: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable26: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addNodes: ((nodes at: 5) at: 1) to: result options.
	result addTokens: ((nodes at: 5) at: 2) to: result commas.
	result partitionToken: ((nodes at: 6) at: 1).
	result addTokens: ((nodes at: 6) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 6) at: 3).
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result _hash: ((nodes at: 6) at: 5).
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 6) at: 7).
	result keyToken: ((nodes at: 6) at: 8).
	result algorithmToken: ((nodes at: 6) at: 9).
	result equals: ((nodes at: 6) at: 10).
	result value: ((nodes at: 6) at: 11).
	result addTokens: ((nodes at: 6) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 6) at: 13) to: result commas.
	result rangeToken: ((nodes at: 6) at: 14).
	result range: ((nodes at: 6) at: 15).
	result columnsToken: ((nodes at: 6) at: 16).
	result listToken: ((nodes at: 6) at: 17).
	result list: ((nodes at: 6) at: 18).
	result partitionsToken: ((nodes at: 6) at: 19).
	result partitions: ((nodes at: 6) at: 20).
	result subpartitionToken: ((nodes at: 6) at: 21).
	result subpartitionsToken: ((nodes at: 6) at: 22).
	result subpartitions: ((nodes at: 6) at: 23).
	result addNodes: ((nodes at: 6) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 7) at: 1).
	result replaceToken: ((nodes at: 7) at: 2).
	result asToken: (nodes at: 8).
	result query: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable27: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addNode: (nodes at: 6) to: result definitions.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addNodes: ((nodes at: 7) at: 2) to: result definitions.
	result addToken: (nodes at: 8) to: result rightParens.
	result partitionToken: ((nodes at: 9) at: 1).
	result addTokens: ((nodes at: 9) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 9) at: 3).
	result addTokens: ((nodes at: 9) at: 4) to: result leftParens.
	result _hash: ((nodes at: 9) at: 5).
	result addTokens: ((nodes at: 9) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 9) at: 7).
	result keyToken: ((nodes at: 9) at: 8).
	result algorithmToken: ((nodes at: 9) at: 9).
	result equals: ((nodes at: 9) at: 10).
	result value: ((nodes at: 9) at: 11).
	result addTokens: ((nodes at: 9) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 9) at: 13) to: result commas.
	result rangeToken: ((nodes at: 9) at: 14).
	result range: ((nodes at: 9) at: 15).
	result columnsToken: ((nodes at: 9) at: 16).
	result listToken: ((nodes at: 9) at: 17).
	result list: ((nodes at: 9) at: 18).
	result partitionsToken: ((nodes at: 9) at: 19).
	result partitions: ((nodes at: 9) at: 20).
	result subpartitionToken: ((nodes at: 9) at: 21).
	result subpartitionsToken: ((nodes at: 9) at: 22).
	result subpartitions: ((nodes at: 9) at: 23).
	result addNodes: ((nodes at: 9) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 10) at: 1).
	result replaceToken: ((nodes at: 10) at: 2).
	result asToken: (nodes at: 11).
	result query: (nodes at: 12).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable28: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addNode: (nodes at: 6) to: result definitions.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addNodes: ((nodes at: 7) at: 2) to: result definitions.
	result addToken: (nodes at: 8) to: result rightParens.
	result addNodes: ((nodes at: 9) at: 1) to: result options.
	result addTokens: ((nodes at: 9) at: 2) to: result commas.
	result partitionToken: ((nodes at: 10) at: 1).
	result addTokens: ((nodes at: 10) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 10) at: 3).
	result addTokens: ((nodes at: 10) at: 4) to: result leftParens.
	result _hash: ((nodes at: 10) at: 5).
	result addTokens: ((nodes at: 10) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 10) at: 7).
	result keyToken: ((nodes at: 10) at: 8).
	result algorithmToken: ((nodes at: 10) at: 9).
	result equals: ((nodes at: 10) at: 10).
	result value: ((nodes at: 10) at: 11).
	result addTokens: ((nodes at: 10) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 10) at: 13) to: result commas.
	result rangeToken: ((nodes at: 10) at: 14).
	result range: ((nodes at: 10) at: 15).
	result columnsToken: ((nodes at: 10) at: 16).
	result listToken: ((nodes at: 10) at: 17).
	result list: ((nodes at: 10) at: 18).
	result partitionsToken: ((nodes at: 10) at: 19).
	result partitions: ((nodes at: 10) at: 20).
	result subpartitionToken: ((nodes at: 10) at: 21).
	result subpartitionsToken: ((nodes at: 10) at: 22).
	result subpartitions: ((nodes at: 10) at: 23).
	result addNodes: ((nodes at: 10) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 11) at: 1).
	result replaceToken: ((nodes at: 11) at: 2).
	result asToken: (nodes at: 12).
	result query: (nodes at: 13).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable29: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result partitionToken: ((nodes at: 8) at: 1).
	result addTokens: ((nodes at: 8) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 8) at: 3).
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result _hash: ((nodes at: 8) at: 5).
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 8) at: 7).
	result keyToken: ((nodes at: 8) at: 8).
	result algorithmToken: ((nodes at: 8) at: 9).
	result equals: ((nodes at: 8) at: 10).
	result value: ((nodes at: 8) at: 11).
	result addTokens: ((nodes at: 8) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 8) at: 13) to: result commas.
	result rangeToken: ((nodes at: 8) at: 14).
	result range: ((nodes at: 8) at: 15).
	result columnsToken: ((nodes at: 8) at: 16).
	result listToken: ((nodes at: 8) at: 17).
	result list: ((nodes at: 8) at: 18).
	result partitionsToken: ((nodes at: 8) at: 19).
	result partitions: ((nodes at: 8) at: 20).
	result subpartitionToken: ((nodes at: 8) at: 21).
	result subpartitionsToken: ((nodes at: 8) at: 22).
	result subpartitions: ((nodes at: 8) at: 23).
	result addNodes: ((nodes at: 8) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 9) at: 1).
	result replaceToken: ((nodes at: 9) at: 2).
	result asToken: (nodes at: 10).
	result query: (nodes at: 11).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable2: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addNode: (nodes at: 5) to: result definitions.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addNodes: ((nodes at: 6) at: 2) to: result definitions.
	result addToken: (nodes at: 7) to: result rightParens.
	result partitionToken: ((nodes at: 8) at: 1).
	result addTokens: ((nodes at: 8) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 8) at: 3).
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result _hash: ((nodes at: 8) at: 5).
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 8) at: 7).
	result keyToken: ((nodes at: 8) at: 8).
	result algorithmToken: ((nodes at: 8) at: 9).
	result equals: ((nodes at: 8) at: 10).
	result value: ((nodes at: 8) at: 11).
	result addTokens: ((nodes at: 8) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 8) at: 13) to: result commas.
	result rangeToken: ((nodes at: 8) at: 14).
	result range: ((nodes at: 8) at: 15).
	result columnsToken: ((nodes at: 8) at: 16).
	result listToken: ((nodes at: 8) at: 17).
	result list: ((nodes at: 8) at: 18).
	result partitionsToken: ((nodes at: 8) at: 19).
	result partitions: ((nodes at: 8) at: 20).
	result subpartitionToken: ((nodes at: 8) at: 21).
	result subpartitionsToken: ((nodes at: 8) at: 22).
	result subpartitions: ((nodes at: 8) at: 23).
	result addNodes: ((nodes at: 8) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable30: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addNodes: ((nodes at: 8) at: 1) to: result options.
	result addTokens: ((nodes at: 8) at: 2) to: result commas.
	result partitionToken: ((nodes at: 9) at: 1).
	result addTokens: ((nodes at: 9) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 9) at: 3).
	result addTokens: ((nodes at: 9) at: 4) to: result leftParens.
	result _hash: ((nodes at: 9) at: 5).
	result addTokens: ((nodes at: 9) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 9) at: 7).
	result keyToken: ((nodes at: 9) at: 8).
	result algorithmToken: ((nodes at: 9) at: 9).
	result equals: ((nodes at: 9) at: 10).
	result value: ((nodes at: 9) at: 11).
	result addTokens: ((nodes at: 9) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 9) at: 13) to: result commas.
	result rangeToken: ((nodes at: 9) at: 14).
	result range: ((nodes at: 9) at: 15).
	result columnsToken: ((nodes at: 9) at: 16).
	result listToken: ((nodes at: 9) at: 17).
	result list: ((nodes at: 9) at: 18).
	result partitionsToken: ((nodes at: 9) at: 19).
	result partitions: ((nodes at: 9) at: 20).
	result subpartitionToken: ((nodes at: 9) at: 21).
	result subpartitionsToken: ((nodes at: 9) at: 22).
	result subpartitions: ((nodes at: 9) at: 23).
	result addNodes: ((nodes at: 9) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 10) at: 1).
	result replaceToken: ((nodes at: 10) at: 2).
	result asToken: (nodes at: 11).
	result query: (nodes at: 12).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable31: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result leftParens.
	result addNode: (nodes at: 9) to: result definitions.
	result addTokens: ((nodes at: 10) at: 1) to: result commas.
	result addNodes: ((nodes at: 10) at: 2) to: result definitions.
	result addToken: (nodes at: 11) to: result rightParens.
	result partitionToken: ((nodes at: 12) at: 1).
	result addTokens: ((nodes at: 12) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 12) at: 3).
	result addTokens: ((nodes at: 12) at: 4) to: result leftParens.
	result _hash: ((nodes at: 12) at: 5).
	result addTokens: ((nodes at: 12) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 12) at: 7).
	result keyToken: ((nodes at: 12) at: 8).
	result algorithmToken: ((nodes at: 12) at: 9).
	result equals: ((nodes at: 12) at: 10).
	result value: ((nodes at: 12) at: 11).
	result addTokens: ((nodes at: 12) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 12) at: 13) to: result commas.
	result rangeToken: ((nodes at: 12) at: 14).
	result range: ((nodes at: 12) at: 15).
	result columnsToken: ((nodes at: 12) at: 16).
	result listToken: ((nodes at: 12) at: 17).
	result list: ((nodes at: 12) at: 18).
	result partitionsToken: ((nodes at: 12) at: 19).
	result partitions: ((nodes at: 12) at: 20).
	result subpartitionToken: ((nodes at: 12) at: 21).
	result subpartitionsToken: ((nodes at: 12) at: 22).
	result subpartitions: ((nodes at: 12) at: 23).
	result addNodes: ((nodes at: 12) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 13) at: 1).
	result replaceToken: ((nodes at: 13) at: 2).
	result asToken: (nodes at: 14).
	result query: (nodes at: 15).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable32: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result leftParens.
	result addNode: (nodes at: 9) to: result definitions.
	result addTokens: ((nodes at: 10) at: 1) to: result commas.
	result addNodes: ((nodes at: 10) at: 2) to: result definitions.
	result addToken: (nodes at: 11) to: result rightParens.
	result addNodes: ((nodes at: 12) at: 1) to: result options.
	result addTokens: ((nodes at: 12) at: 2) to: result commas.
	result partitionToken: ((nodes at: 13) at: 1).
	result addTokens: ((nodes at: 13) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 13) at: 3).
	result addTokens: ((nodes at: 13) at: 4) to: result leftParens.
	result _hash: ((nodes at: 13) at: 5).
	result addTokens: ((nodes at: 13) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 13) at: 7).
	result keyToken: ((nodes at: 13) at: 8).
	result algorithmToken: ((nodes at: 13) at: 9).
	result equals: ((nodes at: 13) at: 10).
	result value: ((nodes at: 13) at: 11).
	result addTokens: ((nodes at: 13) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 13) at: 13) to: result commas.
	result rangeToken: ((nodes at: 13) at: 14).
	result range: ((nodes at: 13) at: 15).
	result columnsToken: ((nodes at: 13) at: 16).
	result listToken: ((nodes at: 13) at: 17).
	result list: ((nodes at: 13) at: 18).
	result partitionsToken: ((nodes at: 13) at: 19).
	result partitions: ((nodes at: 13) at: 20).
	result subpartitionToken: ((nodes at: 13) at: 21).
	result subpartitionsToken: ((nodes at: 13) at: 22).
	result subpartitions: ((nodes at: 13) at: 23).
	result addNodes: ((nodes at: 13) at: 24) to: result definitions.
	result ignoreToken: ((nodes at: 14) at: 1).
	result replaceToken: ((nodes at: 14) at: 2).
	result asToken: (nodes at: 15).
	result query: (nodes at: 16).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable33: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result likeToken: (nodes at: 4).
	result likeTableName: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable34: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result likeToken: (nodes at: 5).
	result likeTableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable35: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result likeToken: (nodes at: 7).
	result likeTableName: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable36: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result leftParens.
	result likeToken: (nodes at: 8).
	result likeTableName: (nodes at: 9).
	result addToken: (nodes at: 10) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable37: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result likeToken: (nodes at: 5).
	result likeTableName: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable38: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result likeToken: (nodes at: 6).
	result likeTableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable39: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result likeToken: (nodes at: 8).
	result likeTableName: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable3: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addNode: (nodes at: 5) to: result definitions.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addNodes: ((nodes at: 6) at: 2) to: result definitions.
	result addToken: (nodes at: 7) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 1) to: result options.
	result addTokens: ((nodes at: 8) at: 2) to: result commas.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable40: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result ifToken: (nodes at: 4).
	result notToken: (nodes at: 5).
	result existsToken: (nodes at: 6).
	result tableName: (nodes at: 7).
	result addToken: (nodes at: 8) to: result leftParens.
	result likeToken: (nodes at: 9).
	result likeTableName: (nodes at: 10).
	result addToken: (nodes at: 11) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable4: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addNode: (nodes at: 5) to: result definitions.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addNodes: ((nodes at: 6) at: 2) to: result definitions.
	result addToken: (nodes at: 7) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 1) to: result options.
	result addTokens: ((nodes at: 8) at: 2) to: result commas.
	result partitionToken: ((nodes at: 9) at: 1).
	result addTokens: ((nodes at: 9) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 9) at: 3).
	result addTokens: ((nodes at: 9) at: 4) to: result leftParens.
	result _hash: ((nodes at: 9) at: 5).
	result addTokens: ((nodes at: 9) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 9) at: 7).
	result keyToken: ((nodes at: 9) at: 8).
	result algorithmToken: ((nodes at: 9) at: 9).
	result equals: ((nodes at: 9) at: 10).
	result value: ((nodes at: 9) at: 11).
	result addTokens: ((nodes at: 9) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 9) at: 13) to: result commas.
	result rangeToken: ((nodes at: 9) at: 14).
	result range: ((nodes at: 9) at: 15).
	result columnsToken: ((nodes at: 9) at: 16).
	result listToken: ((nodes at: 9) at: 17).
	result list: ((nodes at: 9) at: 18).
	result partitionsToken: ((nodes at: 9) at: 19).
	result partitions: ((nodes at: 9) at: 20).
	result subpartitionToken: ((nodes at: 9) at: 21).
	result subpartitionsToken: ((nodes at: 9) at: 22).
	result subpartitions: ((nodes at: 9) at: 23).
	result addNodes: ((nodes at: 9) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable5: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result leftParens.
	result addNode: (nodes at: 8) to: result definitions.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addNodes: ((nodes at: 9) at: 2) to: result definitions.
	result addToken: (nodes at: 10) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable6: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result leftParens.
	result addNode: (nodes at: 8) to: result definitions.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addNodes: ((nodes at: 9) at: 2) to: result definitions.
	result addToken: (nodes at: 10) to: result rightParens.
	result partitionToken: ((nodes at: 11) at: 1).
	result addTokens: ((nodes at: 11) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 11) at: 3).
	result addTokens: ((nodes at: 11) at: 4) to: result leftParens.
	result _hash: ((nodes at: 11) at: 5).
	result addTokens: ((nodes at: 11) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 11) at: 7).
	result keyToken: ((nodes at: 11) at: 8).
	result algorithmToken: ((nodes at: 11) at: 9).
	result equals: ((nodes at: 11) at: 10).
	result value: ((nodes at: 11) at: 11).
	result addTokens: ((nodes at: 11) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 11) at: 13) to: result commas.
	result rangeToken: ((nodes at: 11) at: 14).
	result range: ((nodes at: 11) at: 15).
	result columnsToken: ((nodes at: 11) at: 16).
	result listToken: ((nodes at: 11) at: 17).
	result list: ((nodes at: 11) at: 18).
	result partitionsToken: ((nodes at: 11) at: 19).
	result partitions: ((nodes at: 11) at: 20).
	result subpartitionToken: ((nodes at: 11) at: 21).
	result subpartitionsToken: ((nodes at: 11) at: 22).
	result subpartitions: ((nodes at: 11) at: 23).
	result addNodes: ((nodes at: 11) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable7: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result leftParens.
	result addNode: (nodes at: 8) to: result definitions.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addNodes: ((nodes at: 9) at: 2) to: result definitions.
	result addToken: (nodes at: 10) to: result rightParens.
	result addNodes: ((nodes at: 11) at: 1) to: result options.
	result addTokens: ((nodes at: 11) at: 2) to: result commas.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable8: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result notToken: (nodes at: 4).
	result existsToken: (nodes at: 5).
	result tableName: (nodes at: 6).
	result addToken: (nodes at: 7) to: result leftParens.
	result addNode: (nodes at: 8) to: result definitions.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addNodes: ((nodes at: 9) at: 2) to: result definitions.
	result addToken: (nodes at: 10) to: result rightParens.
	result addNodes: ((nodes at: 11) at: 1) to: result options.
	result addTokens: ((nodes at: 11) at: 2) to: result commas.
	result partitionToken: ((nodes at: 12) at: 1).
	result addTokens: ((nodes at: 12) at: 2) to: result byTokens.
	result hashToken: ((nodes at: 12) at: 3).
	result addTokens: ((nodes at: 12) at: 4) to: result leftParens.
	result _hash: ((nodes at: 12) at: 5).
	result addTokens: ((nodes at: 12) at: 6) to: result rightParens.
	result linearToken: ((nodes at: 12) at: 7).
	result keyToken: ((nodes at: 12) at: 8).
	result algorithmToken: ((nodes at: 12) at: 9).
	result equals: ((nodes at: 12) at: 10).
	result value: ((nodes at: 12) at: 11).
	result addTokens: ((nodes at: 12) at: 12) to: result columnNames.
	result addTokens: ((nodes at: 12) at: 13) to: result commas.
	result rangeToken: ((nodes at: 12) at: 14).
	result range: ((nodes at: 12) at: 15).
	result columnsToken: ((nodes at: 12) at: 16).
	result listToken: ((nodes at: 12) at: 17).
	result list: ((nodes at: 12) at: 18).
	result partitionsToken: ((nodes at: 12) at: 19).
	result partitions: ((nodes at: 12) at: 20).
	result subpartitionToken: ((nodes at: 12) at: 21).
	result subpartitionsToken: ((nodes at: 12) at: 22).
	result subpartitions: ((nodes at: 12) at: 23).
	result addNodes: ((nodes at: 12) at: 24) to: result definitions.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable9: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result tableName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addNode: (nodes at: 6) to: result definitions.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addNodes: ((nodes at: 7) at: 2) to: result definitions.
	result addToken: (nodes at: 8) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForFile1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForStatements1: nodes [
	| result |
	result := MysqlFileNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result statements.
	result addTokens: ((nodes at: 1) at: 2) to: result semicolons.
	result addNode: (nodes at: 2) to: result statements.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor_Statement__statement_______semicolon__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor_Statement__statement_______semicolon___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor_Statement__statement_______semicolon___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__ALGORITHM___algorithmToken_______equals____1___value_____2___value___1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__1: nodes [
	| result |
	result := Array new: 4.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__2: nodes [
	| result |
	result := Array new: 4.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 4 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (nodes at: 1).
	result at: 3 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__2: nodes [
	| result |
	result := Array new: 2.
	result at: 2 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: nodes [
	| result |
	result := Array new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen___1: nodes [
	| result |
	result := Array new: 5.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen___2: nodes [
	| result |
	result := Array new: 5.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 4 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	result at: 5 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen____1: nodes [
	| result |
	result := Array new: 5.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option_1: nodes [
	| result |
	result := Array new: 9.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: ((nodes at: 3) at: 1).
	result at: 4 put: ((nodes at: 3) at: 2).
	result at: 5 put: ((nodes at: 3) at: 3).
	result at: 6 put: ((nodes at: 3) at: 4).
	result at: 7 put: ((nodes at: 3) at: 5).
	result at: 8 put: ((nodes at: 3) at: 6).
	result at: 9 put: ((nodes at: 3) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option__1: nodes [
	| result |
	result := Array new: 9.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__1: nodes [
	| result |
	result := Array new: 4.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__2: nodes [
	| result |
	result := Array new: 4.
	result at: 1 put: (nodes at: 1).
	result at: 3 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__3: nodes [
	| result |
	result := Array new: 4.
	result at: 4 put: (nodes at: 1).
	result at: 1 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__4: nodes [
	| result |
	result := Array new: 4.
	result at: 4 put: (nodes at: 1).
	result at: 1 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	result at: 2 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: nodes [
	| result |
	result := Array new: 4.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____1: nodes [
	| result |
	result := Array new: 7.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____2: nodes [
	| result |
	result := Array new: 7.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	result at: 4 put: (nodes at: 4).
	result at: 5 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____3: nodes [
	| result |
	result := Array new: 7.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 6 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____4: nodes [
	| result |
	result := Array new: 7.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 6 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	result at: 4 put: (nodes at: 5).
	result at: 5 put: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____5: nodes [
	| result |
	result := Array new: 7.
	result at: 7 put: (nodes at: 1).
	result at: 3 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____6: nodes [
	| result |
	result := Array new: 7.
	result at: 7 put: (nodes at: 1).
	result at: 3 put: (nodes at: 2).
	result at: 4 put: (nodes at: 3).
	result at: 5 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____7: nodes [
	| result |
	result := Array new: 7.
	result at: 7 put: (nodes at: 1).
	result at: 6 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____8: nodes [
	| result |
	result := Array new: 7.
	result at: 7 put: (nodes at: 1).
	result at: 6 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	result at: 4 put: (nodes at: 4).
	result at: 5 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName_____1: nodes [
	| result |
	result := Array new: 7.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor______comma___table_option__option__2: nodes [
	| result |
	result := Array new: 2.
	result at: 2 put: (nodes at: 1).
	result at: 1 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor______comma__key_part_1: nodes [
	| result |
	result := Array new: 7.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: ((nodes at: 2) at: 1).
	result at: 3 put: ((nodes at: 2) at: 2).
	result at: 4 put: ((nodes at: 2) at: 3).
	result at: 5 put: ((nodes at: 2) at: 4).
	result at: 6 put: ((nodes at: 2) at: 5).
	result at: 7 put: ((nodes at: 2) at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor______comma__key_part__1: nodes [
	| result |
	result := Array new: 7.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor______comma__key_part__2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	self add: ((nodes at: 2) at: 3) to: (result at: 3).
	self add: ((nodes at: 2) at: 4) to: (result at: 4).
	self add: ((nodes at: 2) at: 5) to: (result at: 5).
	self add: ((nodes at: 2) at: 6) to: (result at: 6).
	self add: ((nodes at: 2) at: 7) to: (result at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen__1: nodes [
	| result |
	result := Array new: 4.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	self addAll: ((nodes at: 3) at: 1) to: (result at: 3).
	self addAll: ((nodes at: 3) at: 2) to: (result at: 2).
	result at: 4 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen___1: nodes [
	| result |
	result := Array new: 4.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition1: nodes [
	| result |
	result := Array new: 8.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	result at: 4 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition2: nodes [
	| result |
	result := Array new: 8.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	result at: 4 put: (nodes at: 4).
	result at: 5 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition3: nodes [
	| result |
	result := Array new: 8.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	result at: 3 put: (nodes at: 3).
	result at: 4 put: (nodes at: 4).
	result at: 6 put: (nodes at: 5).
	result at: 5 put: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition4: nodes [
	| result |
	result := Array new: 8.
	result at: 7 put: (nodes at: 1).
	result at: 1 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	result at: 4 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition5: nodes [
	| result |
	result := Array new: 8.
	result at: 7 put: (nodes at: 1).
	result at: 1 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	result at: 4 put: (nodes at: 5).
	result at: 5 put: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition6: nodes [
	| result |
	result := Array new: 8.
	result at: 7 put: (nodes at: 1).
	result at: 1 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	result at: 4 put: (nodes at: 5).
	result at: 6 put: (nodes at: 6).
	result at: 5 put: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition7: nodes [
	| result |
	result := Array new: 8.
	result at: 7 put: (nodes at: 1).
	result at: 8 put: (nodes at: 2).
	result at: 1 put: (nodes at: 3).
	result at: 2 put: (nodes at: 4).
	result at: 3 put: (nodes at: 5).
	result at: 4 put: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition8: nodes [
	| result |
	result := Array new: 8.
	result at: 7 put: (nodes at: 1).
	result at: 8 put: (nodes at: 2).
	result at: 1 put: (nodes at: 3).
	result at: 2 put: (nodes at: 4).
	result at: 3 put: (nodes at: 5).
	result at: 4 put: (nodes at: 6).
	result at: 5 put: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition9: nodes [
	| result |
	result := Array new: 8.
	result at: 7 put: (nodes at: 1).
	result at: 8 put: (nodes at: 2).
	result at: 1 put: (nodes at: 3).
	result at: 2 put: (nodes at: 4).
	result at: 3 put: (nodes at: 5).
	result at: 4 put: (nodes at: 6).
	result at: 6 put: (nodes at: 7).
	result at: 5 put: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcheck_constraint_definition_1: nodes [
	| result |
	result := Array new: 8.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition10: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 5).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 6).
	result at: 53 put: (nodes at: 6).
	result at: 7 put: ((nodes at: 7) at: 1).
	result at: 8 put: ((nodes at: 7) at: 2).
	result at: 10 put: ((nodes at: 8) at: 1).
	self add: ((nodes at: 8) at: 2) to: (result at: 11).
	self add: ((nodes at: 9) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 9) at: 2).
	result at: 13 put: (nodes at: 10).
	result at: 26 put: ((nodes at: 11) at: 1).
	result at: 27 put: ((nodes at: 11) at: 2).
	self addAll: ((nodes at: 11) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 11) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 11) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 11) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 11) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 11) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 11) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 11) at: 10) to: (result at: 2).
	self add: ((nodes at: 11) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 11) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 11) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 11) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 11) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 11) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 11) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 11) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 11) at: 19).
	result at: 41 put: ((nodes at: 11) at: 20).
	result at: 42 put: ((nodes at: 11) at: 21).
	result at: 43 put: ((nodes at: 11) at: 22).
	result at: 44 put: ((nodes at: 11) at: 23).
	result at: 45 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 12) at: 3).
	self add: ((nodes at: 12) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 12) at: 5).
	self add: ((nodes at: 12) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 12) at: 7).
	result at: 50 put: ((nodes at: 12) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition11: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 5).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 6).
	result at: 53 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 48).
	self add: (nodes at: 8) to: (result at: 36).
	result at: 7 put: ((nodes at: 9) at: 1).
	result at: 8 put: ((nodes at: 9) at: 2).
	result at: 10 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 11).
	self add: ((nodes at: 11) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: (nodes at: 12).
	result at: 26 put: ((nodes at: 13) at: 1).
	result at: 27 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 2).
	self add: ((nodes at: 13) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 13) at: 19).
	result at: 41 put: ((nodes at: 13) at: 20).
	result at: 42 put: ((nodes at: 13) at: 21).
	result at: 43 put: ((nodes at: 13) at: 22).
	result at: 44 put: ((nodes at: 13) at: 23).
	result at: 45 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 14) at: 7).
	result at: 50 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition12: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 5).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 6).
	result at: 53 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 36).
	result at: 7 put: ((nodes at: 8) at: 1).
	result at: 8 put: ((nodes at: 8) at: 2).
	result at: 10 put: ((nodes at: 9) at: 1).
	self add: ((nodes at: 9) at: 2) to: (result at: 11).
	self add: ((nodes at: 10) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 10) at: 2).
	result at: 13 put: (nodes at: 11).
	result at: 26 put: ((nodes at: 12) at: 1).
	result at: 27 put: ((nodes at: 12) at: 2).
	self addAll: ((nodes at: 12) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 12) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 12) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 12) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 12) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 12) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 12) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 12) at: 10) to: (result at: 2).
	self add: ((nodes at: 12) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 12) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 12) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 12) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 12) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 12) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 12) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 12) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 12) at: 19).
	result at: 41 put: ((nodes at: 12) at: 20).
	result at: 42 put: ((nodes at: 12) at: 21).
	result at: 43 put: ((nodes at: 12) at: 22).
	result at: 44 put: ((nodes at: 12) at: 23).
	result at: 45 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 13) at: 3).
	self add: ((nodes at: 13) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 13) at: 5).
	self add: ((nodes at: 13) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 13) at: 7).
	result at: 50 put: ((nodes at: 13) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition13: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 5).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 6).
	result at: 54 put: (nodes at: 6).
	result at: 7 put: ((nodes at: 7) at: 1).
	result at: 8 put: ((nodes at: 7) at: 2).
	result at: 10 put: ((nodes at: 8) at: 1).
	self add: ((nodes at: 8) at: 2) to: (result at: 11).
	self add: ((nodes at: 9) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 9) at: 2).
	result at: 13 put: (nodes at: 10).
	result at: 26 put: ((nodes at: 11) at: 1).
	result at: 27 put: ((nodes at: 11) at: 2).
	self addAll: ((nodes at: 11) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 11) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 11) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 11) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 11) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 11) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 11) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 11) at: 10) to: (result at: 2).
	self add: ((nodes at: 11) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 11) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 11) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 11) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 11) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 11) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 11) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 11) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 11) at: 19).
	result at: 41 put: ((nodes at: 11) at: 20).
	result at: 42 put: ((nodes at: 11) at: 21).
	result at: 43 put: ((nodes at: 11) at: 22).
	result at: 44 put: ((nodes at: 11) at: 23).
	result at: 45 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 12) at: 3).
	self add: ((nodes at: 12) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 12) at: 5).
	self add: ((nodes at: 12) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 12) at: 7).
	result at: 50 put: ((nodes at: 12) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition14: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 5).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 6).
	result at: 54 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 48).
	self add: (nodes at: 8) to: (result at: 36).
	result at: 7 put: ((nodes at: 9) at: 1).
	result at: 8 put: ((nodes at: 9) at: 2).
	result at: 10 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 11).
	self add: ((nodes at: 11) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: (nodes at: 12).
	result at: 26 put: ((nodes at: 13) at: 1).
	result at: 27 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 2).
	self add: ((nodes at: 13) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 13) at: 19).
	result at: 41 put: ((nodes at: 13) at: 20).
	result at: 42 put: ((nodes at: 13) at: 21).
	result at: 43 put: ((nodes at: 13) at: 22).
	result at: 44 put: ((nodes at: 13) at: 23).
	result at: 45 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 14) at: 7).
	result at: 50 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition15: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 5).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 6).
	result at: 54 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 36).
	result at: 7 put: ((nodes at: 8) at: 1).
	result at: 8 put: ((nodes at: 8) at: 2).
	result at: 10 put: ((nodes at: 9) at: 1).
	self add: ((nodes at: 9) at: 2) to: (result at: 11).
	self add: ((nodes at: 10) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 10) at: 2).
	result at: 13 put: (nodes at: 11).
	result at: 26 put: ((nodes at: 12) at: 1).
	result at: 27 put: ((nodes at: 12) at: 2).
	self addAll: ((nodes at: 12) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 12) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 12) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 12) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 12) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 12) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 12) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 12) at: 10) to: (result at: 2).
	self add: ((nodes at: 12) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 12) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 12) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 12) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 12) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 12) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 12) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 12) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 12) at: 19).
	result at: 41 put: ((nodes at: 12) at: 20).
	result at: 42 put: ((nodes at: 12) at: 21).
	result at: 43 put: ((nodes at: 12) at: 22).
	result at: 44 put: ((nodes at: 12) at: 23).
	result at: 45 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 13) at: 3).
	self add: ((nodes at: 13) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 13) at: 5).
	self add: ((nodes at: 13) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 13) at: 7).
	result at: 50 put: ((nodes at: 13) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition16: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 53 put: (nodes at: 8).
	result at: 7 put: ((nodes at: 9) at: 1).
	result at: 8 put: ((nodes at: 9) at: 2).
	result at: 10 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 11).
	self add: ((nodes at: 11) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: (nodes at: 12).
	result at: 26 put: ((nodes at: 13) at: 1).
	result at: 27 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 2).
	self add: ((nodes at: 13) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 13) at: 19).
	result at: 41 put: ((nodes at: 13) at: 20).
	result at: 42 put: ((nodes at: 13) at: 21).
	result at: 43 put: ((nodes at: 13) at: 22).
	result at: 44 put: ((nodes at: 13) at: 23).
	result at: 45 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 14) at: 7).
	result at: 50 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition17: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 48).
	self add: (nodes at: 10) to: (result at: 36).
	result at: 7 put: ((nodes at: 11) at: 1).
	result at: 8 put: ((nodes at: 11) at: 2).
	result at: 10 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 11).
	self add: ((nodes at: 13) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 13) at: 2).
	result at: 13 put: (nodes at: 14).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition18: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 36).
	result at: 7 put: ((nodes at: 10) at: 1).
	result at: 8 put: ((nodes at: 10) at: 2).
	result at: 10 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 11).
	self add: ((nodes at: 12) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 12) at: 2).
	result at: 13 put: (nodes at: 13).
	result at: 26 put: ((nodes at: 14) at: 1).
	result at: 27 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 2).
	self add: ((nodes at: 14) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 14) at: 19).
	result at: 41 put: ((nodes at: 14) at: 20).
	result at: 42 put: ((nodes at: 14) at: 21).
	result at: 43 put: ((nodes at: 14) at: 22).
	result at: 44 put: ((nodes at: 14) at: 23).
	result at: 45 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 15) at: 7).
	result at: 50 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition19: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 54 put: (nodes at: 8).
	result at: 7 put: ((nodes at: 9) at: 1).
	result at: 8 put: ((nodes at: 9) at: 2).
	result at: 10 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 11).
	self add: ((nodes at: 11) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: (nodes at: 12).
	result at: 26 put: ((nodes at: 13) at: 1).
	result at: 27 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 2).
	self add: ((nodes at: 13) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 13) at: 19).
	result at: 41 put: ((nodes at: 13) at: 20).
	result at: 42 put: ((nodes at: 13) at: 21).
	result at: 43 put: ((nodes at: 13) at: 22).
	result at: 44 put: ((nodes at: 13) at: 23).
	result at: 45 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 14) at: 7).
	result at: 50 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition1: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: ((nodes at: 2) at: 1) to: (result at: 2).
	self add: ((nodes at: 2) at: 2) to: (result at: 3).
	self add: ((nodes at: 2) at: 3) to: (result at: 4).
	self add: ((nodes at: 2) at: 4) to: (result at: 5).
	self add: ((nodes at: 2) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 3) at: 1).
	result at: 8 put: ((nodes at: 3) at: 2).
	result at: 9 put: (nodes at: 4).
	result at: 10 put: ((nodes at: 5) at: 1).
	self add: ((nodes at: 5) at: 2) to: (result at: 11).
	self add: ((nodes at: 6) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 6) at: 2).
	result at: 13 put: (nodes at: 7).
	result at: 14 put: ((nodes at: 8) at: 1).
	result at: 15 put: ((nodes at: 8) at: 2).
	result at: 16 put: ((nodes at: 9) at: 1).
	result at: 17 put: ((nodes at: 9) at: 2).
	result at: 18 put: ((nodes at: 10) at: 1).
	result at: 19 put: ((nodes at: 10) at: 2).
	self add: ((nodes at: 10) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 11) at: 1).
	result at: 22 put: ((nodes at: 11) at: 2).
	self add: ((nodes at: 11) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 12) at: 1).
	result at: 24 put: ((nodes at: 12) at: 2).
	result at: 25 put: ((nodes at: 12) at: 3).
	result at: 26 put: ((nodes at: 13) at: 1).
	result at: 27 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 2).
	self add: ((nodes at: 13) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 13) at: 19).
	result at: 41 put: ((nodes at: 13) at: 20).
	result at: 42 put: ((nodes at: 13) at: 21).
	result at: 43 put: ((nodes at: 13) at: 22).
	result at: 44 put: ((nodes at: 13) at: 23).
	result at: 45 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 14) at: 7).
	result at: 50 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition20: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 48).
	self add: (nodes at: 10) to: (result at: 36).
	result at: 7 put: ((nodes at: 11) at: 1).
	result at: 8 put: ((nodes at: 11) at: 2).
	result at: 10 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 11).
	self add: ((nodes at: 13) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 13) at: 2).
	result at: 13 put: (nodes at: 14).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition21: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 36).
	result at: 7 put: ((nodes at: 10) at: 1).
	result at: 8 put: ((nodes at: 10) at: 2).
	result at: 10 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 11).
	self add: ((nodes at: 12) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 12) at: 2).
	result at: 13 put: (nodes at: 13).
	result at: 26 put: ((nodes at: 14) at: 1).
	result at: 27 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 2).
	self add: ((nodes at: 14) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 14) at: 19).
	result at: 41 put: ((nodes at: 14) at: 20).
	result at: 42 put: ((nodes at: 14) at: 21).
	result at: 43 put: ((nodes at: 14) at: 22).
	result at: 44 put: ((nodes at: 14) at: 23).
	result at: 45 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 15) at: 7).
	result at: 50 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition22: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 53 put: (nodes at: 8).
	result at: 7 put: ((nodes at: 9) at: 1).
	result at: 8 put: ((nodes at: 9) at: 2).
	result at: 10 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 11).
	self add: ((nodes at: 11) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: (nodes at: 12).
	result at: 26 put: ((nodes at: 13) at: 1).
	result at: 27 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 2).
	self add: ((nodes at: 13) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 13) at: 19).
	result at: 41 put: ((nodes at: 13) at: 20).
	result at: 42 put: ((nodes at: 13) at: 21).
	result at: 43 put: ((nodes at: 13) at: 22).
	result at: 44 put: ((nodes at: 13) at: 23).
	result at: 45 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 14) at: 7).
	result at: 50 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition23: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 48).
	self add: (nodes at: 10) to: (result at: 36).
	result at: 7 put: ((nodes at: 11) at: 1).
	result at: 8 put: ((nodes at: 11) at: 2).
	result at: 10 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 11).
	self add: ((nodes at: 13) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 13) at: 2).
	result at: 13 put: (nodes at: 14).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition24: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 36).
	result at: 7 put: ((nodes at: 10) at: 1).
	result at: 8 put: ((nodes at: 10) at: 2).
	result at: 10 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 11).
	self add: ((nodes at: 12) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 12) at: 2).
	result at: 13 put: (nodes at: 13).
	result at: 26 put: ((nodes at: 14) at: 1).
	result at: 27 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 2).
	self add: ((nodes at: 14) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 14) at: 19).
	result at: 41 put: ((nodes at: 14) at: 20).
	result at: 42 put: ((nodes at: 14) at: 21).
	result at: 43 put: ((nodes at: 14) at: 22).
	result at: 44 put: ((nodes at: 14) at: 23).
	result at: 45 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 15) at: 7).
	result at: 50 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition25: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 54 put: (nodes at: 8).
	result at: 7 put: ((nodes at: 9) at: 1).
	result at: 8 put: ((nodes at: 9) at: 2).
	result at: 10 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 11).
	self add: ((nodes at: 11) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: (nodes at: 12).
	result at: 26 put: ((nodes at: 13) at: 1).
	result at: 27 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 2).
	self add: ((nodes at: 13) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 13) at: 19).
	result at: 41 put: ((nodes at: 13) at: 20).
	result at: 42 put: ((nodes at: 13) at: 21).
	result at: 43 put: ((nodes at: 13) at: 22).
	result at: 44 put: ((nodes at: 13) at: 23).
	result at: 45 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 14) at: 7).
	result at: 50 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition26: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 48).
	self add: (nodes at: 10) to: (result at: 36).
	result at: 7 put: ((nodes at: 11) at: 1).
	result at: 8 put: ((nodes at: 11) at: 2).
	result at: 10 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 11).
	self add: ((nodes at: 13) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 13) at: 2).
	result at: 13 put: (nodes at: 14).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition27: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 5).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 36).
	result at: 7 put: ((nodes at: 10) at: 1).
	result at: 8 put: ((nodes at: 10) at: 2).
	result at: 10 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 11).
	self add: ((nodes at: 12) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 12) at: 2).
	result at: 13 put: (nodes at: 13).
	result at: 26 put: ((nodes at: 14) at: 1).
	result at: 27 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 2).
	self add: ((nodes at: 14) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 14) at: 19).
	result at: 41 put: ((nodes at: 14) at: 20).
	result at: 42 put: ((nodes at: 14) at: 21).
	result at: 43 put: ((nodes at: 14) at: 22).
	result at: 44 put: ((nodes at: 14) at: 23).
	result at: 45 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 15) at: 7).
	result at: 50 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition28: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 5).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 6).
	result at: 53 put: (nodes at: 10).
	result at: 7 put: ((nodes at: 11) at: 1).
	result at: 8 put: ((nodes at: 11) at: 2).
	result at: 10 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 11).
	self add: ((nodes at: 13) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 13) at: 2).
	result at: 13 put: (nodes at: 14).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition29: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 5).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 6).
	result at: 53 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 48).
	self add: (nodes at: 12) to: (result at: 36).
	result at: 7 put: ((nodes at: 13) at: 1).
	result at: 8 put: ((nodes at: 13) at: 2).
	result at: 10 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 11).
	self add: ((nodes at: 15) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 15) at: 2).
	result at: 13 put: (nodes at: 16).
	result at: 26 put: ((nodes at: 17) at: 1).
	result at: 27 put: ((nodes at: 17) at: 2).
	self addAll: ((nodes at: 17) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 17) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 17) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 17) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 17) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 17) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 17) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 17) at: 10) to: (result at: 2).
	self add: ((nodes at: 17) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 17) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 17) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 17) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 17) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 17) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 17) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 17) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 17) at: 19).
	result at: 41 put: ((nodes at: 17) at: 20).
	result at: 42 put: ((nodes at: 17) at: 21).
	result at: 43 put: ((nodes at: 17) at: 22).
	result at: 44 put: ((nodes at: 17) at: 23).
	result at: 45 put: ((nodes at: 18) at: 1).
	self add: ((nodes at: 18) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 18) at: 3).
	self add: ((nodes at: 18) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 18) at: 5).
	self add: ((nodes at: 18) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 18) at: 7).
	result at: 50 put: ((nodes at: 18) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition2: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 39).
	self add: (nodes at: 3) to: (result at: 4).
	self add: ((nodes at: 4) at: 1) to: (result at: 2).
	self add: ((nodes at: 4) at: 2) to: (result at: 3).
	self add: ((nodes at: 4) at: 3) to: (result at: 4).
	self add: ((nodes at: 4) at: 4) to: (result at: 5).
	self add: ((nodes at: 4) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 5) at: 1).
	result at: 8 put: ((nodes at: 5) at: 2).
	result at: 9 put: (nodes at: 6).
	result at: 10 put: ((nodes at: 7) at: 1).
	self add: ((nodes at: 7) at: 2) to: (result at: 11).
	self add: ((nodes at: 8) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 8) at: 2).
	result at: 13 put: (nodes at: 9).
	result at: 14 put: ((nodes at: 10) at: 1).
	result at: 15 put: ((nodes at: 10) at: 2).
	result at: 16 put: ((nodes at: 11) at: 1).
	result at: 17 put: ((nodes at: 11) at: 2).
	result at: 18 put: ((nodes at: 12) at: 1).
	result at: 19 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self add: ((nodes at: 13) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 14) at: 1).
	result at: 24 put: ((nodes at: 14) at: 2).
	result at: 25 put: ((nodes at: 14) at: 3).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition30: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 5).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 6).
	result at: 53 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 36).
	result at: 7 put: ((nodes at: 12) at: 1).
	result at: 8 put: ((nodes at: 12) at: 2).
	result at: 10 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 11).
	self add: ((nodes at: 14) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 14) at: 2).
	result at: 13 put: (nodes at: 15).
	result at: 26 put: ((nodes at: 16) at: 1).
	result at: 27 put: ((nodes at: 16) at: 2).
	self addAll: ((nodes at: 16) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 16) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 16) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 16) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 16) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 16) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 16) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 16) at: 10) to: (result at: 2).
	self add: ((nodes at: 16) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 16) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 16) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 16) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 16) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 16) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 16) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 16) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 16) at: 19).
	result at: 41 put: ((nodes at: 16) at: 20).
	result at: 42 put: ((nodes at: 16) at: 21).
	result at: 43 put: ((nodes at: 16) at: 22).
	result at: 44 put: ((nodes at: 16) at: 23).
	result at: 45 put: ((nodes at: 17) at: 1).
	self add: ((nodes at: 17) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 17) at: 3).
	self add: ((nodes at: 17) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 17) at: 5).
	self add: ((nodes at: 17) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 17) at: 7).
	result at: 50 put: ((nodes at: 17) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition31: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 5).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 6).
	result at: 54 put: (nodes at: 10).
	result at: 7 put: ((nodes at: 11) at: 1).
	result at: 8 put: ((nodes at: 11) at: 2).
	result at: 10 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 11).
	self add: ((nodes at: 13) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 13) at: 2).
	result at: 13 put: (nodes at: 14).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition32: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 5).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 6).
	result at: 54 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 48).
	self add: (nodes at: 12) to: (result at: 36).
	result at: 7 put: ((nodes at: 13) at: 1).
	result at: 8 put: ((nodes at: 13) at: 2).
	result at: 10 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 11).
	self add: ((nodes at: 15) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 15) at: 2).
	result at: 13 put: (nodes at: 16).
	result at: 26 put: ((nodes at: 17) at: 1).
	result at: 27 put: ((nodes at: 17) at: 2).
	self addAll: ((nodes at: 17) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 17) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 17) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 17) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 17) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 17) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 17) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 17) at: 10) to: (result at: 2).
	self add: ((nodes at: 17) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 17) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 17) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 17) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 17) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 17) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 17) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 17) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 17) at: 19).
	result at: 41 put: ((nodes at: 17) at: 20).
	result at: 42 put: ((nodes at: 17) at: 21).
	result at: 43 put: ((nodes at: 17) at: 22).
	result at: 44 put: ((nodes at: 17) at: 23).
	result at: 45 put: ((nodes at: 18) at: 1).
	self add: ((nodes at: 18) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 18) at: 3).
	self add: ((nodes at: 18) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 18) at: 5).
	self add: ((nodes at: 18) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 18) at: 7).
	result at: 50 put: ((nodes at: 18) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition33: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 14 put: (nodes at: 2).
	result at: 15 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 5).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 6).
	result at: 54 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 36).
	result at: 7 put: ((nodes at: 12) at: 1).
	result at: 8 put: ((nodes at: 12) at: 2).
	result at: 10 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 11).
	self add: ((nodes at: 14) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 14) at: 2).
	result at: 13 put: (nodes at: 15).
	result at: 26 put: ((nodes at: 16) at: 1).
	result at: 27 put: ((nodes at: 16) at: 2).
	self addAll: ((nodes at: 16) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 16) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 16) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 16) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 16) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 16) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 16) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 16) at: 10) to: (result at: 2).
	self add: ((nodes at: 16) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 16) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 16) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 16) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 16) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 16) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 16) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 16) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 16) at: 19).
	result at: 41 put: ((nodes at: 16) at: 20).
	result at: 42 put: ((nodes at: 16) at: 21).
	result at: 43 put: ((nodes at: 16) at: 22).
	result at: 44 put: ((nodes at: 16) at: 23).
	result at: 45 put: ((nodes at: 17) at: 1).
	self add: ((nodes at: 17) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 17) at: 3).
	self add: ((nodes at: 17) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 17) at: 5).
	self add: ((nodes at: 17) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 17) at: 7).
	result at: 50 put: ((nodes at: 17) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition3: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 39).
	self add: (nodes at: 3) to: (result at: 5).
	self add: (nodes at: 4) to: (result at: 4).
	self add: (nodes at: 5) to: (result at: 6).
	self add: ((nodes at: 6) at: 1) to: (result at: 2).
	self add: ((nodes at: 6) at: 2) to: (result at: 3).
	self add: ((nodes at: 6) at: 3) to: (result at: 4).
	self add: ((nodes at: 6) at: 4) to: (result at: 5).
	self add: ((nodes at: 6) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 7) at: 1).
	result at: 8 put: ((nodes at: 7) at: 2).
	result at: 9 put: (nodes at: 8).
	result at: 10 put: ((nodes at: 9) at: 1).
	self add: ((nodes at: 9) at: 2) to: (result at: 11).
	self add: ((nodes at: 10) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 10) at: 2).
	result at: 13 put: (nodes at: 11).
	result at: 14 put: ((nodes at: 12) at: 1).
	result at: 15 put: ((nodes at: 12) at: 2).
	result at: 16 put: ((nodes at: 13) at: 1).
	result at: 17 put: ((nodes at: 13) at: 2).
	result at: 18 put: ((nodes at: 14) at: 1).
	result at: 19 put: ((nodes at: 14) at: 2).
	self add: ((nodes at: 14) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self add: ((nodes at: 15) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 16) at: 1).
	result at: 24 put: ((nodes at: 16) at: 2).
	result at: 25 put: ((nodes at: 16) at: 3).
	result at: 26 put: ((nodes at: 17) at: 1).
	result at: 27 put: ((nodes at: 17) at: 2).
	self addAll: ((nodes at: 17) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 17) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 17) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 17) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 17) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 17) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 17) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 17) at: 10) to: (result at: 2).
	self add: ((nodes at: 17) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 17) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 17) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 17) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 17) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 17) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 17) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 17) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 17) at: 19).
	result at: 41 put: ((nodes at: 17) at: 20).
	result at: 42 put: ((nodes at: 17) at: 21).
	result at: 43 put: ((nodes at: 17) at: 22).
	result at: 44 put: ((nodes at: 17) at: 23).
	result at: 45 put: ((nodes at: 18) at: 1).
	self add: ((nodes at: 18) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 18) at: 3).
	self add: ((nodes at: 18) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 18) at: 5).
	self add: ((nodes at: 18) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 18) at: 7).
	result at: 50 put: ((nodes at: 18) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition4: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 48).
	self add: (nodes at: 3) to: (result at: 36).
	self add: ((nodes at: 4) at: 1) to: (result at: 2).
	self add: ((nodes at: 4) at: 2) to: (result at: 3).
	self add: ((nodes at: 4) at: 3) to: (result at: 4).
	self add: ((nodes at: 4) at: 4) to: (result at: 5).
	self add: ((nodes at: 4) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 5) at: 1).
	result at: 8 put: ((nodes at: 5) at: 2).
	result at: 9 put: (nodes at: 6).
	result at: 10 put: ((nodes at: 7) at: 1).
	self add: ((nodes at: 7) at: 2) to: (result at: 11).
	self add: ((nodes at: 8) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 8) at: 2).
	result at: 13 put: (nodes at: 9).
	result at: 14 put: ((nodes at: 10) at: 1).
	result at: 15 put: ((nodes at: 10) at: 2).
	result at: 16 put: ((nodes at: 11) at: 1).
	result at: 17 put: ((nodes at: 11) at: 2).
	result at: 18 put: ((nodes at: 12) at: 1).
	result at: 19 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self add: ((nodes at: 13) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 14) at: 1).
	result at: 24 put: ((nodes at: 14) at: 2).
	result at: 25 put: ((nodes at: 14) at: 3).
	result at: 26 put: ((nodes at: 15) at: 1).
	result at: 27 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 2).
	self add: ((nodes at: 15) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 15) at: 19).
	result at: 41 put: ((nodes at: 15) at: 20).
	result at: 42 put: ((nodes at: 15) at: 21).
	result at: 43 put: ((nodes at: 15) at: 22).
	result at: 44 put: ((nodes at: 15) at: 23).
	result at: 45 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 16) at: 7).
	result at: 50 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition5: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 48).
	self add: (nodes at: 3) to: (result at: 36).
	self add: (nodes at: 4) to: (result at: 39).
	self add: (nodes at: 5) to: (result at: 4).
	self add: ((nodes at: 6) at: 1) to: (result at: 2).
	self add: ((nodes at: 6) at: 2) to: (result at: 3).
	self add: ((nodes at: 6) at: 3) to: (result at: 4).
	self add: ((nodes at: 6) at: 4) to: (result at: 5).
	self add: ((nodes at: 6) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 7) at: 1).
	result at: 8 put: ((nodes at: 7) at: 2).
	result at: 9 put: (nodes at: 8).
	result at: 10 put: ((nodes at: 9) at: 1).
	self add: ((nodes at: 9) at: 2) to: (result at: 11).
	self add: ((nodes at: 10) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 10) at: 2).
	result at: 13 put: (nodes at: 11).
	result at: 14 put: ((nodes at: 12) at: 1).
	result at: 15 put: ((nodes at: 12) at: 2).
	result at: 16 put: ((nodes at: 13) at: 1).
	result at: 17 put: ((nodes at: 13) at: 2).
	result at: 18 put: ((nodes at: 14) at: 1).
	result at: 19 put: ((nodes at: 14) at: 2).
	self add: ((nodes at: 14) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self add: ((nodes at: 15) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 16) at: 1).
	result at: 24 put: ((nodes at: 16) at: 2).
	result at: 25 put: ((nodes at: 16) at: 3).
	result at: 26 put: ((nodes at: 17) at: 1).
	result at: 27 put: ((nodes at: 17) at: 2).
	self addAll: ((nodes at: 17) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 17) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 17) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 17) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 17) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 17) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 17) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 17) at: 10) to: (result at: 2).
	self add: ((nodes at: 17) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 17) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 17) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 17) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 17) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 17) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 17) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 17) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 17) at: 19).
	result at: 41 put: ((nodes at: 17) at: 20).
	result at: 42 put: ((nodes at: 17) at: 21).
	result at: 43 put: ((nodes at: 17) at: 22).
	result at: 44 put: ((nodes at: 17) at: 23).
	result at: 45 put: ((nodes at: 18) at: 1).
	self add: ((nodes at: 18) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 18) at: 3).
	self add: ((nodes at: 18) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 18) at: 5).
	self add: ((nodes at: 18) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 18) at: 7).
	result at: 50 put: ((nodes at: 18) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition6: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 48).
	self add: (nodes at: 3) to: (result at: 36).
	self add: (nodes at: 4) to: (result at: 39).
	self add: (nodes at: 5) to: (result at: 5).
	self add: (nodes at: 6) to: (result at: 4).
	self add: (nodes at: 7) to: (result at: 6).
	self add: ((nodes at: 8) at: 1) to: (result at: 2).
	self add: ((nodes at: 8) at: 2) to: (result at: 3).
	self add: ((nodes at: 8) at: 3) to: (result at: 4).
	self add: ((nodes at: 8) at: 4) to: (result at: 5).
	self add: ((nodes at: 8) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 9) at: 1).
	result at: 8 put: ((nodes at: 9) at: 2).
	result at: 9 put: (nodes at: 10).
	result at: 10 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 11).
	self add: ((nodes at: 12) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 12) at: 2).
	result at: 13 put: (nodes at: 13).
	result at: 14 put: ((nodes at: 14) at: 1).
	result at: 15 put: ((nodes at: 14) at: 2).
	result at: 16 put: ((nodes at: 15) at: 1).
	result at: 17 put: ((nodes at: 15) at: 2).
	result at: 18 put: ((nodes at: 16) at: 1).
	result at: 19 put: ((nodes at: 16) at: 2).
	self add: ((nodes at: 16) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 17) at: 1).
	result at: 22 put: ((nodes at: 17) at: 2).
	self add: ((nodes at: 17) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 18) at: 1).
	result at: 24 put: ((nodes at: 18) at: 2).
	result at: 25 put: ((nodes at: 18) at: 3).
	result at: 26 put: ((nodes at: 19) at: 1).
	result at: 27 put: ((nodes at: 19) at: 2).
	self addAll: ((nodes at: 19) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 19) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 19) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 19) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 19) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 19) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 19) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 19) at: 10) to: (result at: 2).
	self add: ((nodes at: 19) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 19) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 19) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 19) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 19) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 19) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 19) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 19) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 19) at: 19).
	result at: 41 put: ((nodes at: 19) at: 20).
	result at: 42 put: ((nodes at: 19) at: 21).
	result at: 43 put: ((nodes at: 19) at: 22).
	result at: 44 put: ((nodes at: 19) at: 23).
	result at: 45 put: ((nodes at: 20) at: 1).
	self add: ((nodes at: 20) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 20) at: 3).
	self add: ((nodes at: 20) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 20) at: 5).
	self add: ((nodes at: 20) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 20) at: 7).
	result at: 50 put: ((nodes at: 20) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition7: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 36).
	self add: ((nodes at: 3) at: 1) to: (result at: 2).
	self add: ((nodes at: 3) at: 2) to: (result at: 3).
	self add: ((nodes at: 3) at: 3) to: (result at: 4).
	self add: ((nodes at: 3) at: 4) to: (result at: 5).
	self add: ((nodes at: 3) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 4) at: 1).
	result at: 8 put: ((nodes at: 4) at: 2).
	result at: 9 put: (nodes at: 5).
	result at: 10 put: ((nodes at: 6) at: 1).
	self add: ((nodes at: 6) at: 2) to: (result at: 11).
	self add: ((nodes at: 7) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 7) at: 2).
	result at: 13 put: (nodes at: 8).
	result at: 14 put: ((nodes at: 9) at: 1).
	result at: 15 put: ((nodes at: 9) at: 2).
	result at: 16 put: ((nodes at: 10) at: 1).
	result at: 17 put: ((nodes at: 10) at: 2).
	result at: 18 put: ((nodes at: 11) at: 1).
	result at: 19 put: ((nodes at: 11) at: 2).
	self add: ((nodes at: 11) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 12) at: 1).
	result at: 22 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 13) at: 1).
	result at: 24 put: ((nodes at: 13) at: 2).
	result at: 25 put: ((nodes at: 13) at: 3).
	result at: 26 put: ((nodes at: 14) at: 1).
	result at: 27 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 2).
	self add: ((nodes at: 14) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 14) at: 19).
	result at: 41 put: ((nodes at: 14) at: 20).
	result at: 42 put: ((nodes at: 14) at: 21).
	result at: 43 put: ((nodes at: 14) at: 22).
	result at: 44 put: ((nodes at: 14) at: 23).
	result at: 45 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 15) at: 7).
	result at: 50 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition8: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 36).
	self add: (nodes at: 3) to: (result at: 39).
	self add: (nodes at: 4) to: (result at: 4).
	self add: ((nodes at: 5) at: 1) to: (result at: 2).
	self add: ((nodes at: 5) at: 2) to: (result at: 3).
	self add: ((nodes at: 5) at: 3) to: (result at: 4).
	self add: ((nodes at: 5) at: 4) to: (result at: 5).
	self add: ((nodes at: 5) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 6) at: 1).
	result at: 8 put: ((nodes at: 6) at: 2).
	result at: 9 put: (nodes at: 7).
	result at: 10 put: ((nodes at: 8) at: 1).
	self add: ((nodes at: 8) at: 2) to: (result at: 11).
	self add: ((nodes at: 9) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 9) at: 2).
	result at: 13 put: (nodes at: 10).
	result at: 14 put: ((nodes at: 11) at: 1).
	result at: 15 put: ((nodes at: 11) at: 2).
	result at: 16 put: ((nodes at: 12) at: 1).
	result at: 17 put: ((nodes at: 12) at: 2).
	result at: 18 put: ((nodes at: 13) at: 1).
	result at: 19 put: ((nodes at: 13) at: 2).
	self add: ((nodes at: 13) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 14) at: 1).
	result at: 22 put: ((nodes at: 14) at: 2).
	self add: ((nodes at: 14) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 15) at: 1).
	result at: 24 put: ((nodes at: 15) at: 2).
	result at: 25 put: ((nodes at: 15) at: 3).
	result at: 26 put: ((nodes at: 16) at: 1).
	result at: 27 put: ((nodes at: 16) at: 2).
	self addAll: ((nodes at: 16) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 16) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 16) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 16) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 16) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 16) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 16) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 16) at: 10) to: (result at: 2).
	self add: ((nodes at: 16) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 16) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 16) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 16) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 16) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 16) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 16) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 16) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 16) at: 19).
	result at: 41 put: ((nodes at: 16) at: 20).
	result at: 42 put: ((nodes at: 16) at: 21).
	result at: 43 put: ((nodes at: 16) at: 22).
	result at: 44 put: ((nodes at: 16) at: 23).
	result at: 45 put: ((nodes at: 17) at: 1).
	self add: ((nodes at: 17) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 17) at: 3).
	self add: ((nodes at: 17) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 17) at: 5).
	self add: ((nodes at: 17) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 17) at: 7).
	result at: 50 put: ((nodes at: 17) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition9: nodes [
	| result |
	result := Array new: 56.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 11 put: (OrderedCollection new: 2).
	result at: 20 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 31 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 39 put: (OrderedCollection new: 2).
	result at: 48 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 36).
	self add: (nodes at: 3) to: (result at: 39).
	self add: (nodes at: 4) to: (result at: 5).
	self add: (nodes at: 5) to: (result at: 4).
	self add: (nodes at: 6) to: (result at: 6).
	self add: ((nodes at: 7) at: 1) to: (result at: 2).
	self add: ((nodes at: 7) at: 2) to: (result at: 3).
	self add: ((nodes at: 7) at: 3) to: (result at: 4).
	self add: ((nodes at: 7) at: 4) to: (result at: 5).
	self add: ((nodes at: 7) at: 5) to: (result at: 6).
	result at: 7 put: ((nodes at: 8) at: 1).
	result at: 8 put: ((nodes at: 8) at: 2).
	result at: 9 put: (nodes at: 9).
	result at: 10 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 11).
	self add: ((nodes at: 11) at: 1) to: (result at: 11).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: (nodes at: 12).
	result at: 14 put: ((nodes at: 13) at: 1).
	result at: 15 put: ((nodes at: 13) at: 2).
	result at: 16 put: ((nodes at: 14) at: 1).
	result at: 17 put: ((nodes at: 14) at: 2).
	result at: 18 put: ((nodes at: 15) at: 1).
	result at: 19 put: ((nodes at: 15) at: 2).
	self add: ((nodes at: 15) at: 3) to: (result at: 20).
	result at: 21 put: ((nodes at: 16) at: 1).
	result at: 22 put: ((nodes at: 16) at: 2).
	self add: ((nodes at: 16) at: 3) to: (result at: 20).
	result at: 23 put: ((nodes at: 17) at: 1).
	result at: 24 put: ((nodes at: 17) at: 2).
	result at: 25 put: ((nodes at: 17) at: 3).
	result at: 26 put: ((nodes at: 18) at: 1).
	result at: 27 put: ((nodes at: 18) at: 2).
	self addAll: ((nodes at: 18) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 18) at: 4) to: (result at: 28).
	self addAll: ((nodes at: 18) at: 5) to: (result at: 29).
	self addAll: ((nodes at: 18) at: 6) to: (result at: 30).
	self addAll: ((nodes at: 18) at: 7) to: (result at: 6).
	self addAll: ((nodes at: 18) at: 8) to: (result at: 31).
	self addAll: ((nodes at: 18) at: 9) to: (result at: 32).
	self addAll: ((nodes at: 18) at: 10) to: (result at: 2).
	self add: ((nodes at: 18) at: 11) to: (result at: 3).
	self addAll: ((nodes at: 18) at: 12) to: (result at: 33).
	self addAll: ((nodes at: 18) at: 13) to: (result at: 34).
	self addAll: ((nodes at: 18) at: 14) to: (result at: 35).
	self addAll: ((nodes at: 18) at: 15) to: (result at: 36).
	self addAll: ((nodes at: 18) at: 16) to: (result at: 37).
	self addAll: ((nodes at: 18) at: 17) to: (result at: 38).
	self addAll: ((nodes at: 18) at: 18) to: (result at: 39).
	result at: 40 put: ((nodes at: 18) at: 19).
	result at: 41 put: ((nodes at: 18) at: 20).
	result at: 42 put: ((nodes at: 18) at: 21).
	result at: 43 put: ((nodes at: 18) at: 22).
	result at: 44 put: ((nodes at: 18) at: 23).
	result at: 45 put: ((nodes at: 19) at: 1).
	self add: ((nodes at: 19) at: 2) to: (result at: 5).
	result at: 46 put: ((nodes at: 19) at: 3).
	self add: ((nodes at: 19) at: 4) to: (result at: 6).
	result at: 47 put: ((nodes at: 19) at: 5).
	self add: ((nodes at: 19) at: 6) to: (result at: 48).
	result at: 49 put: ((nodes at: 19) at: 7).
	result at: 50 put: ((nodes at: 19) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_list1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition10: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result addToken: (nodes at: 2) to: result leftParens.
	result addToken: ((nodes at: 3) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 4) at: 3) to: result directions.
	result addTokens: ((nodes at: 4) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 4) at: 5) to: result lengths.
	result addTokens: ((nodes at: 4) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 4) at: 7) to: result exprs.
	result addToken: (nodes at: 5) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition11: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result addToken: (nodes at: 2) to: result leftParens.
	result addToken: ((nodes at: 3) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 4) at: 3) to: result directions.
	result addTokens: ((nodes at: 4) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 4) at: 5) to: result lengths.
	result addTokens: ((nodes at: 4) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 4) at: 7) to: result exprs.
	result addToken: (nodes at: 5) to: result rightParens.
	result option: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition12: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result usingToken: ((nodes at: 2) at: 1).
	result btreeToken: ((nodes at: 2) at: 2).
	result hashToken: ((nodes at: 2) at: 3).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition13: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result usingToken: ((nodes at: 2) at: 1).
	result btreeToken: ((nodes at: 2) at: 2).
	result hashToken: ((nodes at: 2) at: 3).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition14: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition15: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition16: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result usingToken: ((nodes at: 3) at: 1).
	result btreeToken: ((nodes at: 3) at: 2).
	result hashToken: ((nodes at: 3) at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition17: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result keyToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result usingToken: ((nodes at: 3) at: 1).
	result btreeToken: ((nodes at: 3) at: 2).
	result hashToken: ((nodes at: 3) at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition18: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result fulltextToken: (nodes at: 1).
	result addToken: (nodes at: 2) to: result leftParens.
	result addToken: ((nodes at: 3) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 4) at: 3) to: result directions.
	result addTokens: ((nodes at: 4) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 4) at: 5) to: result lengths.
	result addTokens: ((nodes at: 4) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 4) at: 7) to: result exprs.
	result addToken: (nodes at: 5) to: result rightParens.
	result option: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition19: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result fulltextToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition1: nodes [
	| result |
	result := MysqlColumnDefinitionNode new.
	result columnName: (nodes at: 1).
	result dataType: ((nodes at: 2) at: 1).
	result addTokens: ((nodes at: 2) at: 2) to: result onTokens.
	result addTokens: ((nodes at: 2) at: 3) to: result updateTokens.
	result addObjects: ((nodes at: 2) at: 4) to: result values.
	result addTokens: ((nodes at: 2) at: 5) to: result leftParens.
	result addTokens: ((nodes at: 2) at: 6) to: result rightParens.
	result visibleToken: ((nodes at: 2) at: 7).
	result invisibleToken: ((nodes at: 2) at: 8).
	result autoIncrementToken: ((nodes at: 2) at: 9).
	result uniqueToken: ((nodes at: 2) at: 10).
	result addTokens: ((nodes at: 2) at: 11) to: result keyTokens.
	result primaryToken: ((nodes at: 2) at: 12).
	result commentToken: ((nodes at: 2) at: 13).
	result collateToken: ((nodes at: 2) at: 14).
	result collationName: ((nodes at: 2) at: 15).
	result columnFormatToken: ((nodes at: 2) at: 16).
	result columnFormat: ((nodes at: 2) at: 17).
	result engineAttributeToken: ((nodes at: 2) at: 18).
	result engineAttribute: ((nodes at: 2) at: 19).
	result addTokens: ((nodes at: 2) at: 20) to: result equalses.
	result secondaryToken: ((nodes at: 2) at: 21).
	result secondaryEngineAttribute: ((nodes at: 2) at: 22).
	result storageToken: ((nodes at: 2) at: 23).
	result diskToken: ((nodes at: 2) at: 24).
	result memoryToken: ((nodes at: 2) at: 25).
	result referencesToken: ((nodes at: 2) at: 26).
	result tableName: ((nodes at: 2) at: 27).
	result addTokens: ((nodes at: 2) at: 28) to: result refColumnNames.
	result addTokens: ((nodes at: 2) at: 29) to: result directions.
	result addTokens: ((nodes at: 2) at: 30) to: result lengths.
	result addNodes: ((nodes at: 2) at: 31) to: result exprs.
	result addTokens: ((nodes at: 2) at: 32) to: result commas.
	result addTokens: ((nodes at: 2) at: 33) to: result restrictTokens.
	result addTokens: ((nodes at: 2) at: 34) to: result cascadeTokens.
	result addTokens: ((nodes at: 2) at: 35) to: result setTokens.
	result addTokens: ((nodes at: 2) at: 36) to: result nullTokens.
	result addTokens: ((nodes at: 2) at: 37) to: result noTokens.
	result addTokens: ((nodes at: 2) at: 38) to: result actionTokens.
	result addTokens: ((nodes at: 2) at: 39) to: result defaultTokens.
	result _deleteToken: ((nodes at: 2) at: 40).
	result matchToken: ((nodes at: 2) at: 41).
	result fullToken: ((nodes at: 2) at: 42).
	result partialToken: ((nodes at: 2) at: 43).
	result simpleToken: ((nodes at: 2) at: 44).
	result checkToken: ((nodes at: 2) at: 45).
	result check: ((nodes at: 2) at: 46).
	result enforcedToken: ((nodes at: 2) at: 47).
	result addTokens: ((nodes at: 2) at: 48) to: result notTokens.
	result constraintToken: ((nodes at: 2) at: 49).
	result constraintName: ((nodes at: 2) at: 50).
	result asToken: ((nodes at: 2) at: 51).
	result generated: ((nodes at: 2) at: 52).
	result virtualToken: ((nodes at: 2) at: 53).
	result storedToken: ((nodes at: 2) at: 54).
	result generatedToken: ((nodes at: 2) at: 55).
	result alwaysToken: ((nodes at: 2) at: 56).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition20: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result fulltextToken: (nodes at: 1).
	result indexToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition21: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result fulltextToken: (nodes at: 1).
	result indexToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition22: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result fulltextToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition23: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result fulltextToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition24: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result spatialToken: (nodes at: 1).
	result addToken: (nodes at: 2) to: result leftParens.
	result addToken: ((nodes at: 3) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 4) at: 3) to: result directions.
	result addTokens: ((nodes at: 4) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 4) at: 5) to: result lengths.
	result addTokens: ((nodes at: 4) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 4) at: 7) to: result exprs.
	result addToken: (nodes at: 5) to: result rightParens.
	result option: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition25: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result spatialToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition26: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result spatialToken: (nodes at: 1).
	result indexToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition27: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result spatialToken: (nodes at: 1).
	result indexToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition28: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result spatialToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition29: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result spatialToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition2: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result addToken: (nodes at: 2) to: result leftParens.
	result addToken: ((nodes at: 3) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 4) at: 3) to: result directions.
	result addTokens: ((nodes at: 4) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 4) at: 5) to: result lengths.
	result addTokens: ((nodes at: 4) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 4) at: 7) to: result exprs.
	result addToken: (nodes at: 5) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition30: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result primaryToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition31: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result primaryToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition32: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result primaryToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result usingToken: ((nodes at: 3) at: 1).
	result btreeToken: ((nodes at: 3) at: 2).
	result hashToken: ((nodes at: 3) at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition33: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result primaryToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result usingToken: ((nodes at: 3) at: 1).
	result btreeToken: ((nodes at: 3) at: 2).
	result hashToken: ((nodes at: 3) at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition34: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result primaryToken: (nodes at: 2).
	result keyToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition35: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result primaryToken: (nodes at: 2).
	result keyToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition36: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result primaryToken: (nodes at: 2).
	result keyToken: (nodes at: 3).
	result usingToken: ((nodes at: 4) at: 1).
	result btreeToken: ((nodes at: 4) at: 2).
	result hashToken: ((nodes at: 4) at: 3).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: ((nodes at: 6) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 3) to: result directions.
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 5) to: result lengths.
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 7) to: result exprs.
	result addToken: (nodes at: 8) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition37: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result primaryToken: (nodes at: 2).
	result keyToken: (nodes at: 3).
	result usingToken: ((nodes at: 4) at: 1).
	result btreeToken: ((nodes at: 4) at: 2).
	result hashToken: ((nodes at: 4) at: 3).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: ((nodes at: 6) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 3) to: result directions.
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 5) to: result lengths.
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 7) to: result exprs.
	result addToken: (nodes at: 8) to: result rightParens.
	result option: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition38: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result primaryToken: (nodes at: 3).
	result keyToken: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: ((nodes at: 6) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 3) to: result directions.
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 5) to: result lengths.
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 7) to: result exprs.
	result addToken: (nodes at: 8) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition39: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result primaryToken: (nodes at: 3).
	result keyToken: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: ((nodes at: 6) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 3) to: result directions.
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 5) to: result lengths.
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 7) to: result exprs.
	result addToken: (nodes at: 8) to: result rightParens.
	result option: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition3: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result addToken: (nodes at: 2) to: result leftParens.
	result addToken: ((nodes at: 3) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 4) at: 3) to: result directions.
	result addTokens: ((nodes at: 4) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 4) at: 5) to: result lengths.
	result addTokens: ((nodes at: 4) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 4) at: 7) to: result exprs.
	result addToken: (nodes at: 5) to: result rightParens.
	result option: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition40: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result primaryToken: (nodes at: 3).
	result keyToken: (nodes at: 4).
	result usingToken: ((nodes at: 5) at: 1).
	result btreeToken: ((nodes at: 5) at: 2).
	result hashToken: ((nodes at: 5) at: 3).
	result addToken: (nodes at: 6) to: result leftParens.
	result addToken: ((nodes at: 7) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 8) at: 3) to: result directions.
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 8) at: 5) to: result lengths.
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 7) to: result exprs.
	result addToken: (nodes at: 9) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition41: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result primaryToken: (nodes at: 3).
	result keyToken: (nodes at: 4).
	result usingToken: ((nodes at: 5) at: 1).
	result btreeToken: ((nodes at: 5) at: 2).
	result hashToken: ((nodes at: 5) at: 3).
	result addToken: (nodes at: 6) to: result leftParens.
	result addToken: ((nodes at: 7) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 8) at: 3) to: result directions.
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 8) at: 5) to: result lengths.
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 7) to: result exprs.
	result addToken: (nodes at: 9) to: result rightParens.
	result option: (nodes at: 10).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition42: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result uniqueToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result usingToken: ((nodes at: 3) at: 1).
	result btreeToken: ((nodes at: 3) at: 2).
	result hashToken: ((nodes at: 3) at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition43: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result uniqueToken: (nodes at: 1).
	result indexToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result usingToken: ((nodes at: 4) at: 1).
	result btreeToken: ((nodes at: 4) at: 2).
	result hashToken: ((nodes at: 4) at: 3).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: ((nodes at: 6) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 3) to: result directions.
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 5) to: result lengths.
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 7) to: result exprs.
	result addToken: (nodes at: 8) to: result rightParens.
	result option: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition44: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result uniqueToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result usingToken: ((nodes at: 4) at: 1).
	result btreeToken: ((nodes at: 4) at: 2).
	result hashToken: ((nodes at: 4) at: 3).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: ((nodes at: 6) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 3) to: result directions.
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 5) to: result lengths.
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 7) to: result exprs.
	result addToken: (nodes at: 8) to: result rightParens.
	result option: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition45: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result uniqueToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result usingToken: ((nodes at: 4) at: 1).
	result btreeToken: ((nodes at: 4) at: 2).
	result hashToken: ((nodes at: 4) at: 3).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: ((nodes at: 6) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 3) to: result directions.
	result addTokens: ((nodes at: 7) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 5) to: result lengths.
	result addTokens: ((nodes at: 7) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 7) to: result exprs.
	result addToken: (nodes at: 8) to: result rightParens.
	result option: (nodes at: 9).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition46: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result uniqueToken: (nodes at: 2).
	result indexToken: (nodes at: 3).
	result indexName: (nodes at: 4).
	result usingToken: ((nodes at: 5) at: 1).
	result btreeToken: ((nodes at: 5) at: 2).
	result hashToken: ((nodes at: 5) at: 3).
	result addToken: (nodes at: 6) to: result leftParens.
	result addToken: ((nodes at: 7) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 8) at: 3) to: result directions.
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 8) at: 5) to: result lengths.
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 7) to: result exprs.
	result addToken: (nodes at: 9) to: result rightParens.
	result option: (nodes at: 10).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition47: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result uniqueToken: (nodes at: 2).
	result keyToken: (nodes at: 3).
	result indexName: (nodes at: 4).
	result usingToken: ((nodes at: 5) at: 1).
	result btreeToken: ((nodes at: 5) at: 2).
	result hashToken: ((nodes at: 5) at: 3).
	result addToken: (nodes at: 6) to: result leftParens.
	result addToken: ((nodes at: 7) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 8) at: 3) to: result directions.
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 8) at: 5) to: result lengths.
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 7) to: result exprs.
	result addToken: (nodes at: 9) to: result rightParens.
	result option: (nodes at: 10).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition48: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result uniqueToken: (nodes at: 3).
	result indexName: (nodes at: 4).
	result usingToken: ((nodes at: 5) at: 1).
	result btreeToken: ((nodes at: 5) at: 2).
	result hashToken: ((nodes at: 5) at: 3).
	result addToken: (nodes at: 6) to: result leftParens.
	result addToken: ((nodes at: 7) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 8) at: 3) to: result directions.
	result addTokens: ((nodes at: 8) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 8) at: 5) to: result lengths.
	result addTokens: ((nodes at: 8) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 7) to: result exprs.
	result addToken: (nodes at: 9) to: result rightParens.
	result option: (nodes at: 10).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition49: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result uniqueToken: (nodes at: 3).
	result indexToken: (nodes at: 4).
	result indexName: (nodes at: 5).
	result usingToken: ((nodes at: 6) at: 1).
	result btreeToken: ((nodes at: 6) at: 2).
	result hashToken: ((nodes at: 6) at: 3).
	result addToken: (nodes at: 7) to: result leftParens.
	result addToken: ((nodes at: 8) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 8) at: 2) to: result directions.
	result addToken: ((nodes at: 8) at: 3) to: result leftParens.
	result addToken: ((nodes at: 8) at: 4) to: result lengths.
	result addToken: ((nodes at: 8) at: 5) to: result rightParens.
	result addNode: ((nodes at: 8) at: 6) to: result exprs.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addTokens: ((nodes at: 9) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 9) at: 3) to: result directions.
	result addTokens: ((nodes at: 9) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 9) at: 5) to: result lengths.
	result addTokens: ((nodes at: 9) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 9) at: 7) to: result exprs.
	result addToken: (nodes at: 10) to: result rightParens.
	result option: (nodes at: 11).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition4: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result usingToken: ((nodes at: 2) at: 1).
	result btreeToken: ((nodes at: 2) at: 2).
	result hashToken: ((nodes at: 2) at: 3).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition50: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result uniqueToken: (nodes at: 3).
	result keyToken: (nodes at: 4).
	result indexName: (nodes at: 5).
	result usingToken: ((nodes at: 6) at: 1).
	result btreeToken: ((nodes at: 6) at: 2).
	result hashToken: ((nodes at: 6) at: 3).
	result addToken: (nodes at: 7) to: result leftParens.
	result addToken: ((nodes at: 8) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 8) at: 2) to: result directions.
	result addToken: ((nodes at: 8) at: 3) to: result leftParens.
	result addToken: ((nodes at: 8) at: 4) to: result lengths.
	result addToken: ((nodes at: 8) at: 5) to: result rightParens.
	result addNode: ((nodes at: 8) at: 6) to: result exprs.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addTokens: ((nodes at: 9) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 9) at: 3) to: result directions.
	result addTokens: ((nodes at: 9) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 9) at: 5) to: result lengths.
	result addTokens: ((nodes at: 9) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 9) at: 7) to: result exprs.
	result addToken: (nodes at: 10) to: result rightParens.
	result option: (nodes at: 11).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition51: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result foreignToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: (nodes at: 4) to: result columnNames.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
	result addToken: (nodes at: 6) to: result rightParens.
	result referencesToken: ((nodes at: 7) at: 1).
	result tableName: ((nodes at: 7) at: 2).
	result addTokens: ((nodes at: 7) at: 3) to: result leftParens.
	result addTokens: ((nodes at: 7) at: 4) to: result refColumnNames.
	result addTokens: ((nodes at: 7) at: 5) to: result directions.
	result addTokens: ((nodes at: 7) at: 6) to: result lengths.
	result addTokens: ((nodes at: 7) at: 7) to: result rightParens.
	result addNodes: ((nodes at: 7) at: 8) to: result exprs.
	result addTokens: ((nodes at: 7) at: 9) to: result commas.
	result addTokens: ((nodes at: 7) at: 10) to: result onTokens.
	result updateToken: ((nodes at: 7) at: 11).
	result addTokens: ((nodes at: 7) at: 12) to: result restrictTokens.
	result addTokens: ((nodes at: 7) at: 13) to: result cascadeTokens.
	result addTokens: ((nodes at: 7) at: 14) to: result setTokens.
	result addTokens: ((nodes at: 7) at: 15) to: result nullTokens.
	result addTokens: ((nodes at: 7) at: 16) to: result noTokens.
	result addTokens: ((nodes at: 7) at: 17) to: result actionTokens.
	result addTokens: ((nodes at: 7) at: 18) to: result defaultTokens.
	result _deleteToken: ((nodes at: 7) at: 19).
	result matchToken: ((nodes at: 7) at: 20).
	result fullToken: ((nodes at: 7) at: 21).
	result partialToken: ((nodes at: 7) at: 22).
	result simpleToken: ((nodes at: 7) at: 23).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition52: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result foreignToken: (nodes at: 1).
	result keyToken: (nodes at: 2).
	result indexName: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: (nodes at: 5) to: result columnNames.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
	result addToken: (nodes at: 7) to: result rightParens.
	result referencesToken: ((nodes at: 8) at: 1).
	result tableName: ((nodes at: 8) at: 2).
	result addTokens: ((nodes at: 8) at: 3) to: result leftParens.
	result addTokens: ((nodes at: 8) at: 4) to: result refColumnNames.
	result addTokens: ((nodes at: 8) at: 5) to: result directions.
	result addTokens: ((nodes at: 8) at: 6) to: result lengths.
	result addTokens: ((nodes at: 8) at: 7) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 8) to: result exprs.
	result addTokens: ((nodes at: 8) at: 9) to: result commas.
	result addTokens: ((nodes at: 8) at: 10) to: result onTokens.
	result updateToken: ((nodes at: 8) at: 11).
	result addTokens: ((nodes at: 8) at: 12) to: result restrictTokens.
	result addTokens: ((nodes at: 8) at: 13) to: result cascadeTokens.
	result addTokens: ((nodes at: 8) at: 14) to: result setTokens.
	result addTokens: ((nodes at: 8) at: 15) to: result nullTokens.
	result addTokens: ((nodes at: 8) at: 16) to: result noTokens.
	result addTokens: ((nodes at: 8) at: 17) to: result actionTokens.
	result addTokens: ((nodes at: 8) at: 18) to: result defaultTokens.
	result _deleteToken: ((nodes at: 8) at: 19).
	result matchToken: ((nodes at: 8) at: 20).
	result fullToken: ((nodes at: 8) at: 21).
	result partialToken: ((nodes at: 8) at: 22).
	result simpleToken: ((nodes at: 8) at: 23).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition53: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result foreignToken: (nodes at: 2).
	result keyToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: (nodes at: 5) to: result columnNames.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
	result addToken: (nodes at: 7) to: result rightParens.
	result referencesToken: ((nodes at: 8) at: 1).
	result tableName: ((nodes at: 8) at: 2).
	result addTokens: ((nodes at: 8) at: 3) to: result leftParens.
	result addTokens: ((nodes at: 8) at: 4) to: result refColumnNames.
	result addTokens: ((nodes at: 8) at: 5) to: result directions.
	result addTokens: ((nodes at: 8) at: 6) to: result lengths.
	result addTokens: ((nodes at: 8) at: 7) to: result rightParens.
	result addNodes: ((nodes at: 8) at: 8) to: result exprs.
	result addTokens: ((nodes at: 8) at: 9) to: result commas.
	result addTokens: ((nodes at: 8) at: 10) to: result onTokens.
	result updateToken: ((nodes at: 8) at: 11).
	result addTokens: ((nodes at: 8) at: 12) to: result restrictTokens.
	result addTokens: ((nodes at: 8) at: 13) to: result cascadeTokens.
	result addTokens: ((nodes at: 8) at: 14) to: result setTokens.
	result addTokens: ((nodes at: 8) at: 15) to: result nullTokens.
	result addTokens: ((nodes at: 8) at: 16) to: result noTokens.
	result addTokens: ((nodes at: 8) at: 17) to: result actionTokens.
	result addTokens: ((nodes at: 8) at: 18) to: result defaultTokens.
	result _deleteToken: ((nodes at: 8) at: 19).
	result matchToken: ((nodes at: 8) at: 20).
	result fullToken: ((nodes at: 8) at: 21).
	result partialToken: ((nodes at: 8) at: 22).
	result simpleToken: ((nodes at: 8) at: 23).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition54: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result foreignToken: (nodes at: 2).
	result keyToken: (nodes at: 3).
	result indexName: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: (nodes at: 6) to: result columnNames.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
	result addToken: (nodes at: 8) to: result rightParens.
	result referencesToken: ((nodes at: 9) at: 1).
	result tableName: ((nodes at: 9) at: 2).
	result addTokens: ((nodes at: 9) at: 3) to: result leftParens.
	result addTokens: ((nodes at: 9) at: 4) to: result refColumnNames.
	result addTokens: ((nodes at: 9) at: 5) to: result directions.
	result addTokens: ((nodes at: 9) at: 6) to: result lengths.
	result addTokens: ((nodes at: 9) at: 7) to: result rightParens.
	result addNodes: ((nodes at: 9) at: 8) to: result exprs.
	result addTokens: ((nodes at: 9) at: 9) to: result commas.
	result addTokens: ((nodes at: 9) at: 10) to: result onTokens.
	result updateToken: ((nodes at: 9) at: 11).
	result addTokens: ((nodes at: 9) at: 12) to: result restrictTokens.
	result addTokens: ((nodes at: 9) at: 13) to: result cascadeTokens.
	result addTokens: ((nodes at: 9) at: 14) to: result setTokens.
	result addTokens: ((nodes at: 9) at: 15) to: result nullTokens.
	result addTokens: ((nodes at: 9) at: 16) to: result noTokens.
	result addTokens: ((nodes at: 9) at: 17) to: result actionTokens.
	result addTokens: ((nodes at: 9) at: 18) to: result defaultTokens.
	result _deleteToken: ((nodes at: 9) at: 19).
	result matchToken: ((nodes at: 9) at: 20).
	result fullToken: ((nodes at: 9) at: 21).
	result partialToken: ((nodes at: 9) at: 22).
	result simpleToken: ((nodes at: 9) at: 23).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition55: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result foreignToken: (nodes at: 3).
	result keyToken: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addToken: (nodes at: 6) to: result columnNames.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
	result addToken: (nodes at: 8) to: result rightParens.
	result referencesToken: ((nodes at: 9) at: 1).
	result tableName: ((nodes at: 9) at: 2).
	result addTokens: ((nodes at: 9) at: 3) to: result leftParens.
	result addTokens: ((nodes at: 9) at: 4) to: result refColumnNames.
	result addTokens: ((nodes at: 9) at: 5) to: result directions.
	result addTokens: ((nodes at: 9) at: 6) to: result lengths.
	result addTokens: ((nodes at: 9) at: 7) to: result rightParens.
	result addNodes: ((nodes at: 9) at: 8) to: result exprs.
	result addTokens: ((nodes at: 9) at: 9) to: result commas.
	result addTokens: ((nodes at: 9) at: 10) to: result onTokens.
	result updateToken: ((nodes at: 9) at: 11).
	result addTokens: ((nodes at: 9) at: 12) to: result restrictTokens.
	result addTokens: ((nodes at: 9) at: 13) to: result cascadeTokens.
	result addTokens: ((nodes at: 9) at: 14) to: result setTokens.
	result addTokens: ((nodes at: 9) at: 15) to: result nullTokens.
	result addTokens: ((nodes at: 9) at: 16) to: result noTokens.
	result addTokens: ((nodes at: 9) at: 17) to: result actionTokens.
	result addTokens: ((nodes at: 9) at: 18) to: result defaultTokens.
	result _deleteToken: ((nodes at: 9) at: 19).
	result matchToken: ((nodes at: 9) at: 20).
	result fullToken: ((nodes at: 9) at: 21).
	result partialToken: ((nodes at: 9) at: 22).
	result simpleToken: ((nodes at: 9) at: 23).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition56: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result constraintToken: (nodes at: 1).
	result constraintName: (nodes at: 2).
	result foreignToken: (nodes at: 3).
	result keyToken: (nodes at: 4).
	result indexName: (nodes at: 5).
	result addToken: (nodes at: 6) to: result leftParens.
	result addToken: (nodes at: 7) to: result columnNames.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result columnNames.
	result addToken: (nodes at: 9) to: result rightParens.
	result referencesToken: ((nodes at: 10) at: 1).
	result tableName: ((nodes at: 10) at: 2).
	result addTokens: ((nodes at: 10) at: 3) to: result leftParens.
	result addTokens: ((nodes at: 10) at: 4) to: result refColumnNames.
	result addTokens: ((nodes at: 10) at: 5) to: result directions.
	result addTokens: ((nodes at: 10) at: 6) to: result lengths.
	result addTokens: ((nodes at: 10) at: 7) to: result rightParens.
	result addNodes: ((nodes at: 10) at: 8) to: result exprs.
	result addTokens: ((nodes at: 10) at: 9) to: result commas.
	result addTokens: ((nodes at: 10) at: 10) to: result onTokens.
	result updateToken: ((nodes at: 10) at: 11).
	result addTokens: ((nodes at: 10) at: 12) to: result restrictTokens.
	result addTokens: ((nodes at: 10) at: 13) to: result cascadeTokens.
	result addTokens: ((nodes at: 10) at: 14) to: result setTokens.
	result addTokens: ((nodes at: 10) at: 15) to: result nullTokens.
	result addTokens: ((nodes at: 10) at: 16) to: result noTokens.
	result addTokens: ((nodes at: 10) at: 17) to: result actionTokens.
	result addTokens: ((nodes at: 10) at: 18) to: result defaultTokens.
	result _deleteToken: ((nodes at: 10) at: 19).
	result matchToken: ((nodes at: 10) at: 20).
	result fullToken: ((nodes at: 10) at: 21).
	result partialToken: ((nodes at: 10) at: 22).
	result simpleToken: ((nodes at: 10) at: 23).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition57: nodes [
	| result |
	result := MysqlConstraintDefinitionNode new.
	result checkToken: ((nodes at: 1) at: 1).
	result addToken: ((nodes at: 1) at: 2) to: result leftParens.
	result check: ((nodes at: 1) at: 3).
	result addToken: ((nodes at: 1) at: 4) to: result rightParens.
	result enforcedToken: ((nodes at: 1) at: 5).
	result notToken: ((nodes at: 1) at: 6).
	result constraintToken: ((nodes at: 1) at: 7).
	result constraintName: ((nodes at: 1) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition5: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result usingToken: ((nodes at: 2) at: 1).
	result btreeToken: ((nodes at: 2) at: 2).
	result hashToken: ((nodes at: 2) at: 3).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition6: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition7: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result addToken: (nodes at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 5) at: 3) to: result directions.
	result addTokens: ((nodes at: 5) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 5) at: 5) to: result lengths.
	result addTokens: ((nodes at: 5) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 5) at: 7) to: result exprs.
	result addToken: (nodes at: 6) to: result rightParens.
	result option: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition8: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result usingToken: ((nodes at: 3) at: 1).
	result btreeToken: ((nodes at: 3) at: 2).
	result hashToken: ((nodes at: 3) at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcreate_definition9: nodes [
	| result |
	result := MysqlIndexDefinitionNode new.
	result indexToken: (nodes at: 1).
	result indexName: (nodes at: 2).
	result usingToken: ((nodes at: 3) at: 1).
	result btreeToken: ((nodes at: 3) at: 2).
	result hashToken: ((nodes at: 3) at: 3).
	result addToken: (nodes at: 4) to: result leftParens.
	result addToken: ((nodes at: 5) at: 1) to: result refColumnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result refColumnNames.
	result addTokens: ((nodes at: 6) at: 3) to: result directions.
	result addTokens: ((nodes at: 6) at: 4) to: result leftParens.
	result addTokens: ((nodes at: 6) at: 5) to: result lengths.
	result addTokens: ((nodes at: 6) at: 6) to: result rightParens.
	result addNodes: ((nodes at: 6) at: 7) to: result exprs.
	result addToken: (nodes at: 7) to: result rightParens.
	result option: (nodes at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type10: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result addToken: (nodes at: 4) to: result commas.
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result zerofillToken: (nodes at: 7).
	result characterToken: ((nodes at: 8) at: 1).
	result setToken: ((nodes at: 8) at: 2).
	result charsetName: ((nodes at: 8) at: 3).
	result collateToken: ((nodes at: 8) at: 4).
	result collationName: ((nodes at: 8) at: 5).
	result equals: ((nodes at: 8) at: 6).
	result charsetToken: ((nodes at: 8) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type11: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result addToken: (nodes at: 4) to: result commas.
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result unsignedToken: (nodes at: 7).
	result characterToken: ((nodes at: 8) at: 1).
	result setToken: ((nodes at: 8) at: 2).
	result charsetName: ((nodes at: 8) at: 3).
	result collateToken: ((nodes at: 8) at: 4).
	result collationName: ((nodes at: 8) at: 5).
	result equals: ((nodes at: 8) at: 6).
	result charsetToken: ((nodes at: 8) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type12: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result addToken: (nodes at: 4) to: result commas.
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result unsignedToken: (nodes at: 7).
	result zerofillToken: (nodes at: 8).
	result characterToken: ((nodes at: 9) at: 1).
	result setToken: ((nodes at: 9) at: 2).
	result charsetName: ((nodes at: 9) at: 3).
	result collateToken: ((nodes at: 9) at: 4).
	result collationName: ((nodes at: 9) at: 5).
	result equals: ((nodes at: 9) at: 6).
	result charsetToken: ((nodes at: 9) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type13: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type14: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result characterToken: (nodes at: 4).
	result setToken: (nodes at: 5).
	result charsetName: (nodes at: 6).
	result collateToken: ((nodes at: 7) at: 1).
	result collationName: ((nodes at: 7) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type15: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result characterToken: (nodes at: 4).
	result setToken: (nodes at: 5).
	result equals: (nodes at: 6).
	result charsetName: (nodes at: 7).
	result collateToken: ((nodes at: 8) at: 1).
	result collationName: ((nodes at: 8) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type16: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result charsetToken: (nodes at: 4).
	result charsetName: (nodes at: 5).
	result collateToken: ((nodes at: 6) at: 1).
	result collationName: ((nodes at: 6) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type17: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result charsetToken: (nodes at: 4).
	result equals: (nodes at: 5).
	result charsetName: (nodes at: 6).
	result collateToken: ((nodes at: 7) at: 1).
	result collationName: ((nodes at: 7) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type18: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result rightParen: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type19: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result rightParen: (nodes at: 4).
	result characterToken: (nodes at: 5).
	result setToken: (nodes at: 6).
	result charsetName: (nodes at: 7).
	result collateToken: ((nodes at: 8) at: 1).
	result collationName: ((nodes at: 8) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type1: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result characterToken: ((nodes at: 2) at: 1).
	result setToken: ((nodes at: 2) at: 2).
	result charsetName: ((nodes at: 2) at: 3).
	result collateToken: ((nodes at: 2) at: 4).
	result collationName: ((nodes at: 2) at: 5).
	result equals: ((nodes at: 2) at: 6).
	result charsetToken: ((nodes at: 2) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type20: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result rightParen: (nodes at: 4).
	result characterToken: (nodes at: 5).
	result setToken: (nodes at: 6).
	result equals: (nodes at: 7).
	result charsetName: (nodes at: 8).
	result collateToken: ((nodes at: 9) at: 1).
	result collationName: ((nodes at: 9) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type21: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result rightParen: (nodes at: 4).
	result charsetToken: (nodes at: 5).
	result charsetName: (nodes at: 6).
	result collateToken: ((nodes at: 7) at: 1).
	result collationName: ((nodes at: 7) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type22: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result enumValues.
	result addTokens: ((nodes at: 3) at: 2) to: result commas.
	result rightParen: (nodes at: 4).
	result charsetToken: (nodes at: 5).
	result equals: (nodes at: 6).
	result charsetName: (nodes at: 7).
	result collateToken: ((nodes at: 8) at: 1).
	result collationName: ((nodes at: 8) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type2: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result zerofillToken: (nodes at: 2).
	result characterToken: ((nodes at: 3) at: 1).
	result setToken: ((nodes at: 3) at: 2).
	result charsetName: ((nodes at: 3) at: 3).
	result collateToken: ((nodes at: 3) at: 4).
	result collationName: ((nodes at: 3) at: 5).
	result equals: ((nodes at: 3) at: 6).
	result charsetToken: ((nodes at: 3) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type3: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result unsignedToken: (nodes at: 2).
	result characterToken: ((nodes at: 3) at: 1).
	result setToken: ((nodes at: 3) at: 2).
	result charsetName: ((nodes at: 3) at: 3).
	result collateToken: ((nodes at: 3) at: 4).
	result collationName: ((nodes at: 3) at: 5).
	result equals: ((nodes at: 3) at: 6).
	result charsetToken: ((nodes at: 3) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type4: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result unsignedToken: (nodes at: 2).
	result zerofillToken: (nodes at: 3).
	result characterToken: ((nodes at: 4) at: 1).
	result setToken: ((nodes at: 4) at: 2).
	result charsetName: ((nodes at: 4) at: 3).
	result collateToken: ((nodes at: 4) at: 4).
	result collationName: ((nodes at: 4) at: 5).
	result equals: ((nodes at: 4) at: 6).
	result charsetToken: ((nodes at: 4) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type5: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result rightParen: (nodes at: 4).
	result characterToken: ((nodes at: 5) at: 1).
	result setToken: ((nodes at: 5) at: 2).
	result charsetName: ((nodes at: 5) at: 3).
	result collateToken: ((nodes at: 5) at: 4).
	result collationName: ((nodes at: 5) at: 5).
	result equals: ((nodes at: 5) at: 6).
	result charsetToken: ((nodes at: 5) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type6: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result rightParen: (nodes at: 4).
	result zerofillToken: (nodes at: 5).
	result characterToken: ((nodes at: 6) at: 1).
	result setToken: ((nodes at: 6) at: 2).
	result charsetName: ((nodes at: 6) at: 3).
	result collateToken: ((nodes at: 6) at: 4).
	result collationName: ((nodes at: 6) at: 5).
	result equals: ((nodes at: 6) at: 6).
	result charsetToken: ((nodes at: 6) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type7: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result rightParen: (nodes at: 4).
	result unsignedToken: (nodes at: 5).
	result characterToken: ((nodes at: 6) at: 1).
	result setToken: ((nodes at: 6) at: 2).
	result charsetName: ((nodes at: 6) at: 3).
	result collateToken: ((nodes at: 6) at: 4).
	result collationName: ((nodes at: 6) at: 5).
	result equals: ((nodes at: 6) at: 6).
	result charsetToken: ((nodes at: 6) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type8: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result rightParen: (nodes at: 4).
	result unsignedToken: (nodes at: 5).
	result zerofillToken: (nodes at: 6).
	result characterToken: ((nodes at: 7) at: 1).
	result setToken: ((nodes at: 7) at: 2).
	result charsetName: ((nodes at: 7) at: 3).
	result collateToken: ((nodes at: 7) at: 4).
	result collationName: ((nodes at: 7) at: 5).
	result equals: ((nodes at: 7) at: 6).
	result charsetToken: ((nodes at: 7) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type9: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result addToken: (nodes at: 4) to: result commas.
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result characterToken: ((nodes at: 7) at: 1).
	result setToken: ((nodes at: 7) at: 2).
	result charsetName: ((nodes at: 7) at: 3).
	result collateToken: ((nodes at: 7) at: 4).
	result collationName: ((nodes at: 7) at: 5).
	result equals: ((nodes at: 7) at: 6).
	result charsetToken: ((nodes at: 7) at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForenum_values1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForenum_values2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option10: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result secondaryToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option11: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result secondaryToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option1: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result keyBlockSizeToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option2: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result keyBlockSizeToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option3: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result usingToken: ((nodes at: 1) at: 1).
	result btreeToken: ((nodes at: 1) at: 2).
	result hashToken: ((nodes at: 1) at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option4: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result withToken: (nodes at: 1).
	result parserToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option5: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result commentToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option6: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result visibleToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option7: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result invisibleToken: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option8: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result engineAttributeToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_option9: nodes [
	| result |
	result := MysqlIndexOptionNode new.
	result engineAttributeToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_type1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_type2: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (nodes at: 1).
	result at: 3 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForindex_type_1: nodes [
	| result |
	result := Array new: 3.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForkey_part1: nodes [
	| result |
	result := Array new: 6.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForkey_part2: nodes [
	| result |
	result := Array new: 6.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForkey_part4: nodes [
	| result |
	result := Array new: 6.
	result at: 1 put: (nodes at: 1).
	result at: 3 put: (nodes at: 2).
	result at: 4 put: (nodes at: 3).
	result at: 5 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForkey_part5: nodes [
	| result |
	result := Array new: 6.
	result at: 1 put: (nodes at: 1).
	result at: 3 put: (nodes at: 2).
	result at: 4 put: (nodes at: 3).
	result at: 5 put: (nodes at: 4).
	result at: 2 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForkey_part7: nodes [
	| result |
	result := Array new: 6.
	result at: 3 put: (nodes at: 1).
	result at: 6 put: (nodes at: 2).
	result at: 5 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForkey_part8: nodes [
	| result |
	result := Array new: 6.
	result at: 3 put: (nodes at: 1).
	result at: 6 put: (nodes at: 2).
	result at: 5 put: (nodes at: 3).
	result at: 2 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_definition1: nodes [
	| result |
	result := MysqlPartitionDefinitionNode new.
	result partitionToken: (nodes at: 1).
	result partitionName: (nodes at: 2).
	result engineToken: ((nodes at: 3) at: 1).
	result engineName: ((nodes at: 3) at: 2).
	result addToken: ((nodes at: 3) at: 3) to: result equalses.
	result storageToken: ((nodes at: 3) at: 4).
	result commentToken: ((nodes at: 4) at: 1).
	result comment: ((nodes at: 4) at: 2).
	result addToken: ((nodes at: 4) at: 3) to: result equalses.
	result dataToken: ((nodes at: 5) at: 1).
	result addToken: ((nodes at: 5) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 5) at: 3).
	result addToken: ((nodes at: 5) at: 4) to: result equalses.
	result indexToken: ((nodes at: 6) at: 1).
	result addToken: ((nodes at: 6) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 6) at: 3).
	result addToken: ((nodes at: 6) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 7) at: 1).
	result maxRows: ((nodes at: 7) at: 2).
	result addToken: ((nodes at: 7) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 8) at: 1).
	result minRows: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 9) at: 1).
	result tablespaceName: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result addToken: ((nodes at: 10) at: 1) to: result leftParens.
	result addNodes: ((nodes at: 10) at: 2) to: result definitions.
	result addTokens: ((nodes at: 10) at: 3) to: result commas.
	result addToken: ((nodes at: 10) at: 4) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_definition2: nodes [
	| result |
	result := MysqlPartitionDefinitionNode new.
	result partitionToken: (nodes at: 1).
	result partitionName: (nodes at: 2).
	result valueToken: (nodes at: 3).
	result lessToken: (nodes at: 4).
	result thanToken: (nodes at: 5).
	result addToken: (nodes at: 6) to: result leftParens.
	result addNode: (nodes at: 7) to: result values.
	result engineToken: ((nodes at: 8) at: 1).
	result engineName: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result storageToken: ((nodes at: 8) at: 4).
	result commentToken: ((nodes at: 9) at: 1).
	result comment: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result dataToken: ((nodes at: 10) at: 1).
	result addToken: ((nodes at: 10) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 10) at: 3).
	result addToken: ((nodes at: 10) at: 4) to: result equalses.
	result indexToken: ((nodes at: 11) at: 1).
	result addToken: ((nodes at: 11) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 11) at: 3).
	result addToken: ((nodes at: 11) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 12) at: 1).
	result maxRows: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 13) at: 1).
	result minRows: ((nodes at: 13) at: 2).
	result addToken: ((nodes at: 13) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 14) at: 1).
	result tablespaceName: ((nodes at: 14) at: 2).
	result addToken: ((nodes at: 14) at: 3) to: result equalses.
	result addToken: ((nodes at: 15) at: 1) to: result leftParens.
	result addNodes: ((nodes at: 15) at: 2) to: result definitions.
	result addTokens: ((nodes at: 15) at: 3) to: result commas.
	result addToken: ((nodes at: 15) at: 4) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_definition3: nodes [
	| result |
	result := MysqlPartitionDefinitionNode new.
	result partitionToken: (nodes at: 1).
	result partitionName: (nodes at: 2).
	result valueToken: (nodes at: 3).
	result lessToken: (nodes at: 4).
	result thanToken: (nodes at: 5).
	result addNodes: ((nodes at: 6) at: 1) to: result values.
	result addTokens: ((nodes at: 6) at: 2) to: result commas.
	result addToken: (nodes at: 7) to: result rightParens.
	result engineToken: ((nodes at: 8) at: 1).
	result engineName: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result storageToken: ((nodes at: 8) at: 4).
	result commentToken: ((nodes at: 9) at: 1).
	result comment: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result dataToken: ((nodes at: 10) at: 1).
	result addToken: ((nodes at: 10) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 10) at: 3).
	result addToken: ((nodes at: 10) at: 4) to: result equalses.
	result indexToken: ((nodes at: 11) at: 1).
	result addToken: ((nodes at: 11) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 11) at: 3).
	result addToken: ((nodes at: 11) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 12) at: 1).
	result maxRows: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 13) at: 1).
	result minRows: ((nodes at: 13) at: 2).
	result addToken: ((nodes at: 13) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 14) at: 1).
	result tablespaceName: ((nodes at: 14) at: 2).
	result addToken: ((nodes at: 14) at: 3) to: result equalses.
	result addToken: ((nodes at: 15) at: 1) to: result leftParens.
	result addNodes: ((nodes at: 15) at: 2) to: result definitions.
	result addTokens: ((nodes at: 15) at: 3) to: result commas.
	result addToken: ((nodes at: 15) at: 4) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_definition4: nodes [
	| result |
	result := MysqlPartitionDefinitionNode new.
	result partitionToken: (nodes at: 1).
	result partitionName: (nodes at: 2).
	result valueToken: (nodes at: 3).
	result lessToken: (nodes at: 4).
	result thanToken: (nodes at: 5).
	result maxvalueToken: (nodes at: 6).
	result engineToken: ((nodes at: 7) at: 1).
	result engineName: ((nodes at: 7) at: 2).
	result addToken: ((nodes at: 7) at: 3) to: result equalses.
	result storageToken: ((nodes at: 7) at: 4).
	result commentToken: ((nodes at: 8) at: 1).
	result comment: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result dataToken: ((nodes at: 9) at: 1).
	result addToken: ((nodes at: 9) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 9) at: 3).
	result addToken: ((nodes at: 9) at: 4) to: result equalses.
	result indexToken: ((nodes at: 10) at: 1).
	result addToken: ((nodes at: 10) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 10) at: 3).
	result addToken: ((nodes at: 10) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 11) at: 1).
	result maxRows: ((nodes at: 11) at: 2).
	result addToken: ((nodes at: 11) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 12) at: 1).
	result minRows: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 13) at: 1).
	result tablespaceName: ((nodes at: 13) at: 2).
	result addToken: ((nodes at: 13) at: 3) to: result equalses.
	result addToken: ((nodes at: 14) at: 1) to: result leftParens.
	result addNodes: ((nodes at: 14) at: 2) to: result definitions.
	result addTokens: ((nodes at: 14) at: 3) to: result commas.
	result addToken: ((nodes at: 14) at: 4) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_definition5: nodes [
	| result |
	result := MysqlPartitionDefinitionNode new.
	result partitionToken: (nodes at: 1).
	result partitionName: (nodes at: 2).
	result valueToken: (nodes at: 3).
	result inToken: (nodes at: 4).
	result addToken: (nodes at: 5) to: result leftParens.
	result addNodes: ((nodes at: 6) at: 1) to: result values.
	result addTokens: ((nodes at: 6) at: 2) to: result commas.
	result addToken: (nodes at: 7) to: result rightParens.
	result engineToken: ((nodes at: 8) at: 1).
	result engineName: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result storageToken: ((nodes at: 8) at: 4).
	result commentToken: ((nodes at: 9) at: 1).
	result comment: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result dataToken: ((nodes at: 10) at: 1).
	result addToken: ((nodes at: 10) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 10) at: 3).
	result addToken: ((nodes at: 10) at: 4) to: result equalses.
	result indexToken: ((nodes at: 11) at: 1).
	result addToken: ((nodes at: 11) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 11) at: 3).
	result addToken: ((nodes at: 11) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 12) at: 1).
	result maxRows: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 13) at: 1).
	result minRows: ((nodes at: 13) at: 2).
	result addToken: ((nodes at: 13) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 14) at: 1).
	result tablespaceName: ((nodes at: 14) at: 2).
	result addToken: ((nodes at: 14) at: 3) to: result equalses.
	result addToken: ((nodes at: 15) at: 1) to: result leftParens.
	result addNodes: ((nodes at: 15) at: 2) to: result definitions.
	result addTokens: ((nodes at: 15) at: 3) to: result commas.
	result addToken: ((nodes at: 15) at: 4) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options10: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 17 put: (nodes at: 3).
	result at: 16 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 4).
	self addAll: ((nodes at: 6) at: 1) to: (result at: 12).
	self add: ((nodes at: 6) at: 2) to: (result at: 13).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 19 put: ((nodes at: 8) at: 1).
	result at: 20 put: ((nodes at: 8) at: 2).
	result at: 21 put: (nodes at: 9).
	self add: (nodes at: 10) to: (result at: 2).
	result at: 7 put: (nodes at: 11).
	result at: 8 put: (nodes at: 12).
	result at: 9 put: ((nodes at: 13) at: 1).
	result at: 10 put: ((nodes at: 13) at: 2).
	result at: 11 put: ((nodes at: 13) at: 3).
	self add: (nodes at: 14) to: (result at: 4).
	self addAll: ((nodes at: 15) at: 1) to: (result at: 12).
	self add: ((nodes at: 15) at: 2) to: (result at: 13).
	self add: (nodes at: 16) to: (result at: 6).
	result at: 22 put: ((nodes at: 17) at: 1).
	result at: 23 put: ((nodes at: 17) at: 2).
	self add: (nodes at: 18) to: (result at: 4).
	self add: (nodes at: 19) to: (result at: 24).
	self addAll: ((nodes at: 20) at: 1) to: (result at: 13).
	self addAll: ((nodes at: 20) at: 2) to: (result at: 24).
	self add: (nodes at: 21) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options1: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options2: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 3).
	self add: (nodes at: 4) to: (result at: 4).
	result at: 5 put: (nodes at: 5).
	self add: (nodes at: 6) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options3: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 7 put: (nodes at: 3).
	result at: 3 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 4).
	result at: 5 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options4: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 7 put: (nodes at: 3).
	result at: 8 put: (nodes at: 4).
	result at: 9 put: ((nodes at: 5) at: 1).
	result at: 10 put: ((nodes at: 5) at: 2).
	result at: 11 put: ((nodes at: 5) at: 3).
	self add: (nodes at: 6) to: (result at: 4).
	self addAll: ((nodes at: 7) at: 1) to: (result at: 12).
	self add: ((nodes at: 7) at: 2) to: (result at: 13).
	self add: (nodes at: 8) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options5: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 14 put: (nodes at: 3).
	self add: (nodes at: 4) to: (result at: 4).
	result at: 15 put: (nodes at: 5).
	self add: (nodes at: 6) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options6: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 14 put: (nodes at: 3).
	result at: 16 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 4).
	self addAll: ((nodes at: 6) at: 1) to: (result at: 12).
	self add: ((nodes at: 6) at: 2) to: (result at: 13).
	self add: (nodes at: 7) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options7: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 17 put: (nodes at: 3).
	self add: (nodes at: 4) to: (result at: 4).
	result at: 18 put: (nodes at: 5).
	self add: (nodes at: 6) to: (result at: 6).
	result at: 19 put: ((nodes at: 7) at: 1).
	result at: 20 put: ((nodes at: 7) at: 2).
	result at: 21 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 2).
	result at: 7 put: (nodes at: 10).
	result at: 3 put: (nodes at: 11).
	self add: (nodes at: 12) to: (result at: 4).
	result at: 5 put: (nodes at: 13).
	self add: (nodes at: 14) to: (result at: 6).
	result at: 22 put: ((nodes at: 15) at: 1).
	result at: 23 put: ((nodes at: 15) at: 2).
	self add: (nodes at: 16) to: (result at: 4).
	self add: (nodes at: 17) to: (result at: 24).
	self addAll: ((nodes at: 18) at: 1) to: (result at: 13).
	self addAll: ((nodes at: 18) at: 2) to: (result at: 24).
	self add: (nodes at: 19) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options8: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 17 put: (nodes at: 3).
	self add: (nodes at: 4) to: (result at: 4).
	result at: 18 put: (nodes at: 5).
	self add: (nodes at: 6) to: (result at: 6).
	result at: 19 put: ((nodes at: 7) at: 1).
	result at: 20 put: ((nodes at: 7) at: 2).
	result at: 21 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 2).
	result at: 7 put: (nodes at: 10).
	result at: 8 put: (nodes at: 11).
	result at: 9 put: ((nodes at: 12) at: 1).
	result at: 10 put: ((nodes at: 12) at: 2).
	result at: 11 put: ((nodes at: 12) at: 3).
	self add: (nodes at: 13) to: (result at: 4).
	self addAll: ((nodes at: 14) at: 1) to: (result at: 12).
	self add: ((nodes at: 14) at: 2) to: (result at: 13).
	self add: (nodes at: 15) to: (result at: 6).
	result at: 22 put: ((nodes at: 16) at: 1).
	result at: 23 put: ((nodes at: 16) at: 2).
	self add: (nodes at: 17) to: (result at: 4).
	self add: (nodes at: 18) to: (result at: 24).
	self addAll: ((nodes at: 19) at: 1) to: (result at: 13).
	self addAll: ((nodes at: 19) at: 2) to: (result at: 24).
	self add: (nodes at: 20) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options9: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	result at: 17 put: (nodes at: 3).
	result at: 16 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 4).
	self addAll: ((nodes at: 6) at: 1) to: (result at: 12).
	self add: ((nodes at: 6) at: 2) to: (result at: 13).
	self add: (nodes at: 7) to: (result at: 6).
	result at: 19 put: ((nodes at: 8) at: 1).
	result at: 20 put: ((nodes at: 8) at: 2).
	result at: 21 put: (nodes at: 9).
	self add: (nodes at: 10) to: (result at: 2).
	result at: 7 put: (nodes at: 11).
	result at: 3 put: (nodes at: 12).
	self add: (nodes at: 13) to: (result at: 4).
	result at: 5 put: (nodes at: 14).
	self add: (nodes at: 15) to: (result at: 6).
	result at: 22 put: ((nodes at: 16) at: 1).
	result at: 23 put: ((nodes at: 16) at: 2).
	self add: (nodes at: 17) to: (result at: 4).
	self add: (nodes at: 18) to: (result at: 24).
	self addAll: ((nodes at: 19) at: 1) to: (result at: 13).
	self addAll: ((nodes at: 19) at: 2) to: (result at: 24).
	self add: (nodes at: 20) to: (result at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForpartition_options_1: nodes [
	| result |
	result := Array new: 24.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition1: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	self add: ((nodes at: 7) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 7) at: 2).
	self add: ((nodes at: 7) at: 3) to: (result at: 12).
	self add: ((nodes at: 7) at: 4) to: (result at: 13).
	self add: ((nodes at: 7) at: 5) to: (result at: 14).
	self add: ((nodes at: 7) at: 6) to: (result at: 15).
	self add: ((nodes at: 7) at: 7) to: (result at: 16).
	self add: ((nodes at: 7) at: 8) to: (result at: 17).
	self add: ((nodes at: 7) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition2: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	self add: (nodes at: 7) to: (result at: 10).
	result at: 19 put: (nodes at: 8).
	self add: ((nodes at: 9) at: 1) to: (result at: 12).
	self add: ((nodes at: 9) at: 2) to: (result at: 13).
	self add: ((nodes at: 9) at: 3) to: (result at: 14).
	self add: ((nodes at: 9) at: 4) to: (result at: 15).
	self add: ((nodes at: 9) at: 5) to: (result at: 16).
	self add: ((nodes at: 9) at: 6) to: (result at: 17).
	self add: ((nodes at: 9) at: 7) to: (result at: 18).
	self add: ((nodes at: 10) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 10) at: 2).
	self add: ((nodes at: 10) at: 3) to: (result at: 12).
	self add: ((nodes at: 10) at: 4) to: (result at: 13).
	self add: ((nodes at: 10) at: 5) to: (result at: 14).
	self add: ((nodes at: 10) at: 6) to: (result at: 15).
	self add: ((nodes at: 10) at: 7) to: (result at: 16).
	self add: ((nodes at: 10) at: 8) to: (result at: 17).
	self add: ((nodes at: 10) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition3: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	result at: 20 put: (nodes at: 7).
	result at: 21 put: (nodes at: 8).
	self add: ((nodes at: 9) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 9) at: 2).
	self add: ((nodes at: 9) at: 3) to: (result at: 12).
	self add: ((nodes at: 9) at: 4) to: (result at: 13).
	self add: ((nodes at: 9) at: 5) to: (result at: 14).
	self add: ((nodes at: 9) at: 6) to: (result at: 15).
	self add: ((nodes at: 9) at: 7) to: (result at: 16).
	self add: ((nodes at: 9) at: 8) to: (result at: 17).
	self add: ((nodes at: 9) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition4: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	result at: 20 put: (nodes at: 7).
	result at: 21 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 10).
	result at: 19 put: (nodes at: 10).
	self add: ((nodes at: 11) at: 1) to: (result at: 12).
	self add: ((nodes at: 11) at: 2) to: (result at: 13).
	self add: ((nodes at: 11) at: 3) to: (result at: 14).
	self add: ((nodes at: 11) at: 4) to: (result at: 15).
	self add: ((nodes at: 11) at: 5) to: (result at: 16).
	self add: ((nodes at: 11) at: 6) to: (result at: 17).
	self add: ((nodes at: 11) at: 7) to: (result at: 18).
	self add: ((nodes at: 12) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 12).
	self add: ((nodes at: 12) at: 4) to: (result at: 13).
	self add: ((nodes at: 12) at: 5) to: (result at: 14).
	self add: ((nodes at: 12) at: 6) to: (result at: 15).
	self add: ((nodes at: 12) at: 7) to: (result at: 16).
	self add: ((nodes at: 12) at: 8) to: (result at: 17).
	self add: ((nodes at: 12) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition5: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	result at: 20 put: (nodes at: 7).
	result at: 22 put: (nodes at: 8).
	self add: ((nodes at: 9) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 9) at: 2).
	self add: ((nodes at: 9) at: 3) to: (result at: 12).
	self add: ((nodes at: 9) at: 4) to: (result at: 13).
	self add: ((nodes at: 9) at: 5) to: (result at: 14).
	self add: ((nodes at: 9) at: 6) to: (result at: 15).
	self add: ((nodes at: 9) at: 7) to: (result at: 16).
	self add: ((nodes at: 9) at: 8) to: (result at: 17).
	self add: ((nodes at: 9) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition6: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	result at: 20 put: (nodes at: 7).
	result at: 22 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 10).
	result at: 19 put: (nodes at: 10).
	self add: ((nodes at: 11) at: 1) to: (result at: 12).
	self add: ((nodes at: 11) at: 2) to: (result at: 13).
	self add: ((nodes at: 11) at: 3) to: (result at: 14).
	self add: ((nodes at: 11) at: 4) to: (result at: 15).
	self add: ((nodes at: 11) at: 5) to: (result at: 16).
	self add: ((nodes at: 11) at: 6) to: (result at: 17).
	self add: ((nodes at: 11) at: 7) to: (result at: 18).
	self add: ((nodes at: 12) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 12).
	self add: ((nodes at: 12) at: 4) to: (result at: 13).
	self add: ((nodes at: 12) at: 5) to: (result at: 14).
	self add: ((nodes at: 12) at: 6) to: (result at: 15).
	self add: ((nodes at: 12) at: 7) to: (result at: 16).
	self add: ((nodes at: 12) at: 8) to: (result at: 17).
	self add: ((nodes at: 12) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition7: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	result at: 20 put: (nodes at: 7).
	result at: 23 put: (nodes at: 8).
	self add: ((nodes at: 9) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 9) at: 2).
	self add: ((nodes at: 9) at: 3) to: (result at: 12).
	self add: ((nodes at: 9) at: 4) to: (result at: 13).
	self add: ((nodes at: 9) at: 5) to: (result at: 14).
	self add: ((nodes at: 9) at: 6) to: (result at: 15).
	self add: ((nodes at: 9) at: 7) to: (result at: 16).
	self add: ((nodes at: 9) at: 8) to: (result at: 17).
	self add: ((nodes at: 9) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition8: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 1) to: (result at: 4).
	self add: ((nodes at: 4) at: 2) to: (result at: 5).
	self add: ((nodes at: 4) at: 3) to: (result at: 3).
	self add: ((nodes at: 4) at: 4) to: (result at: 6).
	self add: ((nodes at: 4) at: 5) to: (result at: 7).
	self add: ((nodes at: 4) at: 6) to: (result at: 8).
	self addAll: ((nodes at: 5) at: 1) to: (result at: 9).
	self addAll: ((nodes at: 5) at: 2) to: (result at: 4).
	self addAll: ((nodes at: 5) at: 3) to: (result at: 5).
	self addAll: ((nodes at: 5) at: 4) to: (result at: 3).
	self addAll: ((nodes at: 5) at: 5) to: (result at: 6).
	self addAll: ((nodes at: 5) at: 6) to: (result at: 7).
	self addAll: ((nodes at: 5) at: 7) to: (result at: 8).
	self add: (nodes at: 6) to: (result at: 7).
	result at: 20 put: (nodes at: 7).
	result at: 23 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 10).
	result at: 19 put: (nodes at: 10).
	self add: ((nodes at: 11) at: 1) to: (result at: 12).
	self add: ((nodes at: 11) at: 2) to: (result at: 13).
	self add: ((nodes at: 11) at: 3) to: (result at: 14).
	self add: ((nodes at: 11) at: 4) to: (result at: 15).
	self add: ((nodes at: 11) at: 5) to: (result at: 16).
	self add: ((nodes at: 11) at: 6) to: (result at: 17).
	self add: ((nodes at: 11) at: 7) to: (result at: 18).
	self add: ((nodes at: 12) at: 1) to: (result at: 10).
	result at: 11 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 12).
	self add: ((nodes at: 12) at: 4) to: (result at: 13).
	self add: ((nodes at: 12) at: 5) to: (result at: 14).
	self add: ((nodes at: 12) at: 6) to: (result at: 15).
	self add: ((nodes at: 12) at: 7) to: (result at: 16).
	self add: ((nodes at: 12) at: 8) to: (result at: 17).
	self add: ((nodes at: 12) at: 9) to: (result at: 18).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_definition_1: nodes [
	| result |
	result := Array new: 23.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 4 put: (OrderedCollection new: 2).
	result at: 5 put: (OrderedCollection new: 2).
	result at: 6 put: (OrderedCollection new: 2).
	result at: 7 put: (OrderedCollection new: 2).
	result at: 8 put: (OrderedCollection new: 2).
	result at: 9 put: (OrderedCollection new: 2).
	result at: 10 put: (OrderedCollection new: 2).
	result at: 12 put: (OrderedCollection new: 2).
	result at: 13 put: (OrderedCollection new: 2).
	result at: 14 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 16 put: (OrderedCollection new: 2).
	result at: 17 put: (OrderedCollection new: 2).
	result at: 18 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_option1: nodes [
	| result |
	result := Array new: 7.
	result at: 1 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_option2: nodes [
	| result |
	result := Array new: 7.
	result at: 2 put: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_option3: nodes [
	| result |
	result := Array new: 7.
	result at: 3 put: (nodes at: 1).
	result at: 4 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_option4: nodes [
	| result |
	result := Array new: 7.
	result at: 5 put: (nodes at: 1).
	result at: 6 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForreference_option5: nodes [
	| result |
	result := Array new: 7.
	result at: 3 put: (nodes at: 1).
	result at: 7 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition10: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result storageToken: (nodes at: 3).
	result engineToken: (nodes at: 4).
	result addToken: (nodes at: 5) to: result equalses.
	result engineName: (nodes at: 6).
	result commentToken: (nodes at: 7).
	result addToken: (nodes at: 8) to: result equalses.
	result comment: (nodes at: 9).
	result dataToken: ((nodes at: 10) at: 1).
	result addToken: ((nodes at: 10) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 10) at: 3).
	result addToken: ((nodes at: 10) at: 4) to: result equalses.
	result indexToken: ((nodes at: 11) at: 1).
	result addToken: ((nodes at: 11) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 11) at: 3).
	result addToken: ((nodes at: 11) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 12) at: 1).
	result maxRows: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 13) at: 1).
	result minRows: ((nodes at: 13) at: 2).
	result addToken: ((nodes at: 13) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 14) at: 1).
	result tablespaceName: ((nodes at: 14) at: 2).
	result addToken: ((nodes at: 14) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition1: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result dataToken: ((nodes at: 3) at: 1).
	result addToken: ((nodes at: 3) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 3) at: 3).
	result addToken: ((nodes at: 3) at: 4) to: result equalses.
	result indexToken: ((nodes at: 4) at: 1).
	result addToken: ((nodes at: 4) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 4) at: 3).
	result addToken: ((nodes at: 4) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 5) at: 1).
	result maxRows: ((nodes at: 5) at: 2).
	result addToken: ((nodes at: 5) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 6) at: 1).
	result minRows: ((nodes at: 6) at: 2).
	result addToken: ((nodes at: 6) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 7) at: 1).
	result tablespaceName: ((nodes at: 7) at: 2).
	result addToken: ((nodes at: 7) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition2: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result commentToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result equalses.
	result comment: (nodes at: 5).
	result dataToken: ((nodes at: 6) at: 1).
	result addToken: ((nodes at: 6) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 6) at: 3).
	result addToken: ((nodes at: 6) at: 4) to: result equalses.
	result indexToken: ((nodes at: 7) at: 1).
	result addToken: ((nodes at: 7) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 7) at: 3).
	result addToken: ((nodes at: 7) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 8) at: 1).
	result maxRows: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 9) at: 1).
	result minRows: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 10) at: 1).
	result tablespaceName: ((nodes at: 10) at: 2).
	result addToken: ((nodes at: 10) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition3: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result engineToken: (nodes at: 3).
	result engineName: (nodes at: 4).
	result dataToken: ((nodes at: 5) at: 1).
	result addToken: ((nodes at: 5) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 5) at: 3).
	result addToken: ((nodes at: 5) at: 4) to: result equalses.
	result indexToken: ((nodes at: 6) at: 1).
	result addToken: ((nodes at: 6) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 6) at: 3).
	result addToken: ((nodes at: 6) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 7) at: 1).
	result maxRows: ((nodes at: 7) at: 2).
	result addToken: ((nodes at: 7) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 8) at: 1).
	result minRows: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 9) at: 1).
	result tablespaceName: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition4: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result engineToken: (nodes at: 3).
	result engineName: (nodes at: 4).
	result commentToken: (nodes at: 5).
	result addToken: (nodes at: 6) to: result equalses.
	result comment: (nodes at: 7).
	result dataToken: ((nodes at: 8) at: 1).
	result addToken: ((nodes at: 8) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 8) at: 3).
	result addToken: ((nodes at: 8) at: 4) to: result equalses.
	result indexToken: ((nodes at: 9) at: 1).
	result addToken: ((nodes at: 9) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 9) at: 3).
	result addToken: ((nodes at: 9) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 10) at: 1).
	result maxRows: ((nodes at: 10) at: 2).
	result addToken: ((nodes at: 10) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 11) at: 1).
	result minRows: ((nodes at: 11) at: 2).
	result addToken: ((nodes at: 11) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 12) at: 1).
	result tablespaceName: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition5: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result engineToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result equalses.
	result engineName: (nodes at: 5).
	result dataToken: ((nodes at: 6) at: 1).
	result addToken: ((nodes at: 6) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 6) at: 3).
	result addToken: ((nodes at: 6) at: 4) to: result equalses.
	result indexToken: ((nodes at: 7) at: 1).
	result addToken: ((nodes at: 7) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 7) at: 3).
	result addToken: ((nodes at: 7) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 8) at: 1).
	result maxRows: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 9) at: 1).
	result minRows: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 10) at: 1).
	result tablespaceName: ((nodes at: 10) at: 2).
	result addToken: ((nodes at: 10) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition6: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result engineToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result equalses.
	result engineName: (nodes at: 5).
	result commentToken: (nodes at: 6).
	result addToken: (nodes at: 7) to: result equalses.
	result comment: (nodes at: 8).
	result dataToken: ((nodes at: 9) at: 1).
	result addToken: ((nodes at: 9) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 9) at: 3).
	result addToken: ((nodes at: 9) at: 4) to: result equalses.
	result indexToken: ((nodes at: 10) at: 1).
	result addToken: ((nodes at: 10) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 10) at: 3).
	result addToken: ((nodes at: 10) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 11) at: 1).
	result maxRows: ((nodes at: 11) at: 2).
	result addToken: ((nodes at: 11) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 12) at: 1).
	result minRows: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 13) at: 1).
	result tablespaceName: ((nodes at: 13) at: 2).
	result addToken: ((nodes at: 13) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition7: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result storageToken: (nodes at: 3).
	result engineToken: (nodes at: 4).
	result engineName: (nodes at: 5).
	result dataToken: ((nodes at: 6) at: 1).
	result addToken: ((nodes at: 6) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 6) at: 3).
	result addToken: ((nodes at: 6) at: 4) to: result equalses.
	result indexToken: ((nodes at: 7) at: 1).
	result addToken: ((nodes at: 7) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 7) at: 3).
	result addToken: ((nodes at: 7) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 8) at: 1).
	result maxRows: ((nodes at: 8) at: 2).
	result addToken: ((nodes at: 8) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 9) at: 1).
	result minRows: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 10) at: 1).
	result tablespaceName: ((nodes at: 10) at: 2).
	result addToken: ((nodes at: 10) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition8: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result storageToken: (nodes at: 3).
	result engineToken: (nodes at: 4).
	result engineName: (nodes at: 5).
	result commentToken: (nodes at: 6).
	result addToken: (nodes at: 7) to: result equalses.
	result comment: (nodes at: 8).
	result dataToken: ((nodes at: 9) at: 1).
	result addToken: ((nodes at: 9) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 9) at: 3).
	result addToken: ((nodes at: 9) at: 4) to: result equalses.
	result indexToken: ((nodes at: 10) at: 1).
	result addToken: ((nodes at: 10) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 10) at: 3).
	result addToken: ((nodes at: 10) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 11) at: 1).
	result maxRows: ((nodes at: 11) at: 2).
	result addToken: ((nodes at: 11) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 12) at: 1).
	result minRows: ((nodes at: 12) at: 2).
	result addToken: ((nodes at: 12) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 13) at: 1).
	result tablespaceName: ((nodes at: 13) at: 2).
	result addToken: ((nodes at: 13) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForsubpartition_definition9: nodes [
	| result |
	result := MysqlSubpartitionDefinitionNode new.
	result subpartitionToken: (nodes at: 1).
	result subpartion: (nodes at: 2).
	result storageToken: (nodes at: 3).
	result engineToken: (nodes at: 4).
	result addToken: (nodes at: 5) to: result equalses.
	result engineName: (nodes at: 6).
	result dataToken: ((nodes at: 7) at: 1).
	result addToken: ((nodes at: 7) at: 2) to: result directoryTokens.
	result dataDirectory: ((nodes at: 7) at: 3).
	result addToken: ((nodes at: 7) at: 4) to: result equalses.
	result indexToken: ((nodes at: 8) at: 1).
	result addToken: ((nodes at: 8) at: 2) to: result directoryTokens.
	result indexDirectory: ((nodes at: 8) at: 3).
	result addToken: ((nodes at: 8) at: 4) to: result equalses.
	result maxRowsToken: ((nodes at: 9) at: 1).
	result maxRows: ((nodes at: 9) at: 2).
	result addToken: ((nodes at: 9) at: 3) to: result equalses.
	result minRowsToken: ((nodes at: 10) at: 1).
	result minRows: ((nodes at: 10) at: 2).
	result addToken: ((nodes at: 10) at: 3) to: result equalses.
	result tableSpaceToken: ((nodes at: 11) at: 1).
	result tablespaceName: ((nodes at: 11) at: 2).
	result addToken: ((nodes at: 11) at: 3) to: result equalses.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option100: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result unionToken: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result addToken: (nodes at: 3) to: result tableNames.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result tableNames.
	result rightParen: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option101: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result unionToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result leftParen: (nodes at: 3).
	result addToken: (nodes at: 4) to: result tableNames.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result tableNames.
	result rightParen: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option10: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result charsetToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option11: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result defaultToken: (nodes at: 1).
	result characterToken: (nodes at: 2).
	result setToken: (nodes at: 3).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option12: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result defaultToken: (nodes at: 1).
	result characterToken: (nodes at: 2).
	result setToken: (nodes at: 3).
	result equals: (nodes at: 4).
	result value: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option13: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result defaultToken: (nodes at: 1).
	result charsetToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option14: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result defaultToken: (nodes at: 1).
	result charsetToken: (nodes at: 2).
	result equals: (nodes at: 3).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option15: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result checksumToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option17: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result checksumToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option19: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result collateToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option1: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result autoextendSizeToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option20: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result collateToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option21: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result defaultToken: (nodes at: 1).
	result collateToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option22: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result defaultToken: (nodes at: 1).
	result collateToken: (nodes at: 2).
	result equals: (nodes at: 3).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option23: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result commentToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option24: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result commentToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option26: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result compressionToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option29: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result compressionToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option2: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result autoextendSizeToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option31: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result connectionToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option32: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result connectionToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option33: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result dataToken: (nodes at: 1).
	result directoryToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option34: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result dataToken: (nodes at: 1).
	result directoryToken: (nodes at: 2).
	result equals: (nodes at: 3).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option35: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result indexToken: (nodes at: 1).
	result directoryToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option36: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result indexToken: (nodes at: 1).
	result directoryToken: (nodes at: 2).
	result equals: (nodes at: 3).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option37: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result delayKeyWriteToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option39: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result delayKeyWriteToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option3: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result autoIncrementToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option42: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result encryptionToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option44: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result encryptionToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option45: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result engineToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option46: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result engineToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option47: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result engineAttributeToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option48: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result engineAttributeToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option4: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result autoIncrementToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option50: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result insertMethodToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option53: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result insertMethodToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option55: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result keyBlockSizeToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option56: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result keyBlockSizeToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option57: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result maxRowsToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option58: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result maxRowsToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option59: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result minRowsToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option5: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result avgRowLengthToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option60: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result minRowsToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option61: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result packKeysToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option64: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result packKeysToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option67: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result passwordToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option68: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result passwordToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option6: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result avgRowLengthToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option74: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result rowFormatToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option7: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result characterToken: (nodes at: 1).
	result setToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option80: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result rowFormatToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option81: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result secondaryToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option82: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result secondaryToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option84: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result statsToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option87: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result statsToken: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option8: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result characterToken: (nodes at: 1).
	result setToken: (nodes at: 2).
	result equals: (nodes at: 3).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option97: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result tableSpaceToken: (nodes at: 1).
	result tablespaceName: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option98: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result tableSpaceToken: (nodes at: 1).
	result tablespaceName: (nodes at: 2).
	result storageToken: (nodes at: 3).
	result diskToken: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option99: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result tableSpaceToken: (nodes at: 1).
	result tablespaceName: (nodes at: 2).
	result storageToken: (nodes at: 3).
	result memoryToken: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_option9: nodes [
	| result |
	result := MysqlTableOptionNode new.
	result charsetToken: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFortable_options1: nodes [
	| result |
	result := nodes at: 2.
	self addFirst: (nodes at: 1) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForvalue_list1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	self addAll: ((nodes at: 2) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 2) at: 2) to: (result at: 1).
	^ result
]

{ #category : #testing }
MysqlParser >> tryAllTokens [
	^ true
]

{ #category : #testing }
MysqlParser >> useAllTokenIds [
	^ false
]
