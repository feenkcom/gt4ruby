Class {
	#name : #MysqlParser,
	#superclass : #SmaCCGLRParser,
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlParser class >> ambiguousTransitions [
^#(
#[ 1 186 5 177] 
#[ 3 30 8 209] 
#[ 3 30 8 213] 
#[ 3 54 9 49] 
#[ 3 150 10 253] 
#[ 3 154 11 1] 
#[ 4 42 12 77] 
#[ 4 46 12 145] 
#[ 4 62 12 181]
	).
]

{ #category : #'generated-accessing' }
MysqlParser class >> cacheId [
	^'2021-11-18T12:42:41.245389-06:00'
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
	| DropTable
	;
DropTable
	: ""DROP"" 'dropToken' ""TABLE"" 'tableToken' (""IF"" 'ifToken' ""EXISTS"" 'existsToken')? tbl_name 'tableName' {{}}
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
	| ""TIME""
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
	| ""MyISAM"" 'name'
	;
charset_name
	: <simple_name>
	;
length
	: <integer>
	;
collation_name
	: <simple_name>
	| <string>
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
	#(157 0 #reduceActionFor_Statement__statement_______semicolon___1: 399361 false) 
	#(154 1 #reduceActionForFile1: 357377 false) 
	#(158 0 #nil 476161 false) 
	#(157 2 #reduceActionFor_Statement__statement_______semicolon___2: 399362 false) 
	#(155 2 #reduceActionForStatements1: 385025 false) 
	#(158 1 #liftFirstValue: 476163 false) 
	#(158 1 #liftFirstValue: 476162 false) 
	#(156 2 #reduceActionFor_Statement__statement_______semicolon__1: 399361 false) 
	#(249 1 #liftFirstValue: 12986369 false) 
	#(163 0 #reduceActionForpartition_options_1: 1274881 false) 
	#(159 3 #reduceActionForDropTable1: 521217 false) 
	#(165 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 1296385 false) 
	#(214 0 #reduceActionFor_Statement__statement_______semicolon___1: 7394305 false) 
	#(163 1 #reduceActionForFile1: 1274882 false) 
	#(171 0 #nil 2593793 false) 
	#(250 1 #liftFirstValue: 13008897 false) 
	#(162 0 #reduceActionFor_Statement__statement_______semicolon___1: 869377 false) 
	#(167 1 #reduceActionForcreate_definition57: 1700921 false) 
	#(251 1 #liftFirstValue: 13031428 false) 
	#(251 1 #liftFirstValue: 13031425 false) 
	#(251 1 #liftFirstValue: 13031426 false) 
	#(251 1 #liftFirstValue: 13031427 false) 
	#(269 1 #liftFirstValue: 13785089 false) 
	#(215 2 #reduceActionFortable_option1: 7436289 false) 
	#(269 1 #liftFirstValue: 13785090 false) 
	#(215 2 #reduceActionFortable_option3: 7436291 false) 
	#(215 2 #reduceActionFortable_option5: 7436293 false) 
	#(254 1 #liftFirstValue: 13233153 false) 
	#(215 2 #reduceActionFortable_option9: 7436297 false) 
	#(215 2 #reduceActionFortable_option15: 7436303 false) 
	#(215 2 #reduceActionFortable_option15: 7436304 false) 
	#(256 1 #liftFirstValue: 13290498 false) 
	#(256 1 #liftFirstValue: 13290497 false) 
	#(215 2 #reduceActionFortable_option19: 7436307 false) 
	#(215 2 #reduceActionFortable_option23: 7436311 false) 
	#(215 2 #reduceActionFortable_option26: 7436314 false) 
	#(215 2 #reduceActionFortable_option26: 7436315 false) 
	#(215 2 #reduceActionFortable_option26: 7436313 false) 
	#(215 2 #reduceActionFortable_option31: 7436319 false) 
	#(215 2 #reduceActionFortable_option37: 7436325 false) 
	#(215 2 #reduceActionFortable_option37: 7436326 false) 
	#(215 2 #reduceActionFortable_option42: 7436330 false) 
	#(215 2 #reduceActionFortable_option42: 7436329 false) 
	#(253 1 #liftFirstValue: 13178881 false) 
	#(253 1 #liftFirstValue: 13178882 false) 
	#(215 2 #reduceActionFortable_option45: 7436333 false) 
	#(215 2 #reduceActionFortable_option47: 7436335 false) 
	#(215 2 #reduceActionFortable_option50: 7436338 false) 
	#(215 2 #reduceActionFortable_option50: 7436339 false) 
	#(215 2 #reduceActionFortable_option50: 7436337 false) 
	#(215 2 #reduceActionFortable_option55: 7436343 false) 
	#(160 5 #reduceActionForCreateTable33: 647201 false) 
	#(215 2 #reduceActionFortable_option57: 7436345 false) 
	#(215 2 #reduceActionFortable_option59: 7436347 false) 
	#(215 2 #reduceActionFortable_option61: 7436349 false) 
	#(215 2 #reduceActionFortable_option61: 7436350 false) 
	#(215 2 #reduceActionFortable_option61: 7436351 false) 
	#(218 2 #reduceActionForpartition_options1: 10014721 false) 
	#(219 0 #nil 10181633 false) 
	#(215 2 #reduceActionFortable_option67: 7436355 false) 
	#(215 2 #reduceActionFortable_option74: 7436362 false) 
	#(215 2 #reduceActionFortable_option74: 7436360 false) 
	#(215 2 #reduceActionFortable_option74: 7436357 false) 
	#(215 2 #reduceActionFortable_option74: 7436358 false) 
	#(215 2 #reduceActionFortable_option74: 7436359 false) 
	#(215 2 #reduceActionFortable_option74: 7436361 false) 
	#(215 2 #reduceActionFortable_option81: 7436369 false) 
	#(215 2 #reduceActionFortable_option84: 7436372 false) 
	#(215 2 #reduceActionFortable_option84: 7436373 false) 
	#(215 2 #reduceActionFortable_option84: 7436371 false) 
	#(215 2 #reduceActionFortable_option84: 7436378 false) 
	#(215 2 #reduceActionFortable_option84: 7436379 false) 
	#(215 2 #reduceActionFortable_option84: 7436377 false) 
	#(215 2 #reduceActionFortable_option84: 7436383 false) 
	#(215 2 #reduceActionFortable_option97: 7436385 false) 
	#(265 1 #liftFirstValue: 13630465 false) 
	#(164 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 1296385 false) 
	#(164 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__2: 1296386 false) 
	#(165 1 #reduceActionForFile1: 1296386 false) 
	#(166 0 #nil 1352705 false) 
	#(212 2 #reduceActionFortable_options1: 7354369 false) 
	#(159 5 #reduceActionForDropTable2: 521218 false) 
	#(263 1 #liftFirstValue: 13560833 false) 
	#(252 1 #liftFirstValue: 13154305 false) 
	#(172 0 #reduceActionForindex_type_1: 2618369 false) 
	#(171 1 #liftFirstValue: 2593794 false) 
	#(203 1 #liftFirstValue: 5481473 false) 
	#(203 1 #liftFirstValue: 5481474 false) 
	#(203 1 #liftFirstValue: 5481475 false) 
	#(203 1 #liftFirstValue: 5481476 false) 
	#(203 1 #liftFirstValue: 5481477 false) 
	#(203 1 #liftFirstValue: 5481478 false) 
	#(203 1 #liftFirstValue: 5481479 false) 
	#(203 1 #liftFirstValue: 5481480 false) 
	#(203 1 #liftFirstValue: 5481481 false) 
	#(203 1 #liftFirstValue: 5481482 false) 
	#(203 1 #liftFirstValue: 5481483 false) 
	#(203 1 #liftFirstValue: 5481484 false) 
	#(203 1 #liftFirstValue: 5481485 false) 
	#(203 1 #liftFirstValue: 5481486 false) 
	#(203 1 #liftFirstValue: 5481487 false) 
	#(203 1 #liftFirstValue: 5481488 false) 
	#(203 1 #liftFirstValue: 5481489 false) 
	#(203 1 #liftFirstValue: 5481490 false) 
	#(203 1 #liftFirstValue: 5481491 false) 
	#(203 1 #liftFirstValue: 5481492 false) 
	#(203 1 #liftFirstValue: 5481493 false) 
	#(203 1 #liftFirstValue: 5481494 false) 
	#(167 2 #reduceActionForcreate_definition1: 1700865 false) 
	#(177 0 #reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen____1: 3288065 false) 
	#(201 0 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName_____1: 4925441 false) 
	#(215 3 #reduceActionFortable_option2: 7436290 false) 
	#(215 3 #reduceActionFortable_option4: 7436292 false) 
	#(215 3 #reduceActionFortable_option6: 7436294 false) 
	#(215 3 #reduceActionFortable_option7: 7436295 false) 
	#(215 3 #reduceActionFortable_option10: 7436298 false) 
	#(215 3 #reduceActionFortable_option17: 7436305 false) 
	#(215 3 #reduceActionFortable_option17: 7436306 false) 
	#(215 3 #reduceActionFortable_option20: 7436308 false) 
	#(215 3 #reduceActionFortable_option24: 7436312 false) 
	#(215 3 #reduceActionFortable_option29: 7436317 false) 
	#(215 3 #reduceActionFortable_option29: 7436318 false) 
	#(215 3 #reduceActionFortable_option29: 7436316 false) 
	#(215 3 #reduceActionFortable_option32: 7436320 false) 
	#(215 3 #reduceActionFortable_option33: 7436321 false) 
	#(215 3 #reduceActionFortable_option13: 7436301 false) 
	#(215 3 #reduceActionFortable_option21: 7436309 false) 
	#(215 3 #reduceActionFortable_option39: 7436327 false) 
	#(215 3 #reduceActionFortable_option39: 7436328 false) 
	#(215 3 #reduceActionFortable_option44: 7436332 false) 
	#(215 3 #reduceActionFortable_option44: 7436331 false) 
	#(215 3 #reduceActionFortable_option46: 7436334 false) 
	#(215 3 #reduceActionFortable_option48: 7436336 false) 
	#(215 3 #reduceActionFortable_option35: 7436323 false) 
	#(215 3 #reduceActionFortable_option53: 7436341 false) 
	#(215 3 #reduceActionFortable_option53: 7436342 false) 
	#(215 3 #reduceActionFortable_option53: 7436340 false) 
	#(215 3 #reduceActionFortable_option56: 7436344 false) 
	#(215 3 #reduceActionFortable_option58: 7436346 false) 
	#(215 3 #reduceActionFortable_option60: 7436348 false) 
	#(215 3 #reduceActionFortable_option64: 7436352 false) 
	#(215 3 #reduceActionFortable_option64: 7436353 false) 
	#(215 3 #reduceActionFortable_option64: 7436354 false) 
	#(219 1 #liftFirstValue: 10181634 false) 
	#(215 3 #reduceActionFortable_option68: 7436356 false) 
	#(215 3 #reduceActionFortable_option80: 7436368 false) 
	#(215 3 #reduceActionFortable_option80: 7436366 false) 
	#(215 3 #reduceActionFortable_option80: 7436363 false) 
	#(215 3 #reduceActionFortable_option80: 7436364 false) 
	#(215 3 #reduceActionFortable_option80: 7436365 false) 
	#(215 3 #reduceActionFortable_option80: 7436367 false) 
	#(215 3 #reduceActionFortable_option82: 7436370 false) 
	#(215 3 #reduceActionFortable_option87: 7436375 false) 
	#(215 3 #reduceActionFortable_option87: 7436376 false) 
	#(215 3 #reduceActionFortable_option87: 7436374 false) 
	#(215 3 #reduceActionFortable_option87: 7436381 false) 
	#(215 3 #reduceActionFortable_option87: 7436382 false) 
	#(215 3 #reduceActionFortable_option87: 7436380 false) 
	#(215 3 #reduceActionFortable_option87: 7436384 false) 
	#(217 0 #reduceActionFor_Statement__statement_______semicolon___1: 9952257 false) 
	#(166 1 #liftFirstValue: 1352706 false) 
	#(214 2 #reduceActionFor_Statement__statement_______semicolon___2: 7394306 false) 
	#(213 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 7394305 false) 
	#(160 6 #reduceActionForCreateTable37: 647205 false) 
	#(258 1 #liftFirstValue: 13385729 false) 
	#(169 0 #reduceActionFor______comma__key_part__1: 1893377 false) 
	#(204 1 #reduceActionForkey_part1: 5781505 false) 
	#(205 2 #reduceActionForindex_type1: 5968897 false) 
	#(205 2 #reduceActionForindex_type2: 5968898 false) 
	#(160 7 #reduceActionForCreateTable34: 647202 false) 
	#(172 1 #reduceActionForFile1: 2618370 false) 
	#(160 7 #reduceActionForCreateTable1: 647169 false) 
	#(162 2 #reduceActionFor_Statement__statement_______semicolon___2: 869378 false) 
	#(177 1 #reduceActionForFile1: 3288066 false) 
	#(179 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3399681 false) 
	#(201 1 #reduceActionForFile1: 4925442 false) 
	#(199 2 #reduceActionFordata_type1: 4733953 false) 
	#(251 3 #liftFirstValue: 13031429 false) 
	#(215 4 #reduceActionFortable_option8: 7436296 false) 
	#(215 4 #reduceActionFortable_option34: 7436322 false) 
	#(215 4 #reduceActionFortable_option11: 7436299 false) 
	#(215 4 #reduceActionFortable_option14: 7436302 false) 
	#(215 4 #reduceActionFortable_option22: 7436310 false) 
	#(215 4 #reduceActionFortable_option36: 7436324 false) 
	#(221 0 #reduceActionForindex_type_1: 10223617 false) 
	#(215 4 #reduceActionFortable_option98: 7436386 false) 
	#(215 4 #reduceActionFortable_option99: 7436387 false) 
	#(160 7 #reduceActionForCreateTable17: 647185 false) 
	#(257 1 #liftFirstValue: 13338625 false) 
	#(213 2 #reduceActionFor______comma___table_option__option__2: 7394306 false) 
	#(160 8 #reduceActionForCreateTable35: 647203 false) 
	#(207 4 #reduceActionForcheck_constraint_definition1: 6523905 false) 
	#(174 0 #reduceActionFor_Statement__statement_______semicolon___1: 2920449 false) 
	#(204 2 #reduceActionForkey_part2: 5781506 false) 
	#(204 2 #reduceActionForkey_part2: 5781507 false) 
	#(160 8 #reduceActionForCreateTable3: 647171 false) 
	#(160 8 #reduceActionForCreateTable2: 647170 false) 
	#(161 2 #reduceActionFor_Statement__statement_______semicolon__1: 869377 false) 
	#(199 3 #reduceActionFordata_type13: 4733965 false) 
	#(202 1 #reduceActionForenum_values1: 5393409 false) 
	#(178 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__2: 3399682 false) 
	#(178 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3399681 false) 
	#(179 1 #reduceActionForFile1: 3399682 false) 
	#(180 0 #nil 3462145 false) 
	#(200 2 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____5: 4925445 false) 
	#(199 3 #reduceActionFordata_type3: 4733955 false) 
	#(199 3 #reduceActionFordata_type2: 4733954 false) 
	#(215 5 #reduceActionFortable_option12: 7436300 false) 
	#(221 1 #reduceActionForFile1: 10223618 false) 
	#(215 5 #reduceActionFortable_option100: 7436388 false) 
	#(217 2 #reduceActionFor_Statement__statement_______semicolon___2: 9952258 false) 
	#(160 8 #reduceActionForCreateTable18: 647186 false) 
	#(160 8 #reduceActionForCreateTable38: 647206 false) 
	#(160 8 #reduceActionForCreateTable9: 647177 false) 
	#(160 8 #reduceActionForCreateTable25: 647193 false) 
	#(207 5 #reduceActionForcheck_constraint_definition2: 6523906 false) 
	#(207 5 #reduceActionForcheck_constraint_definition4: 6523908 false) 
	#(204 3 #reduceActionForkey_part7: 5781511 false) 
	#(170 0 #nil 2178049 false) 
	#(169 2 #reduceActionFor______comma__key_part__2: 1893378 false) 
	#(255 1 #liftFirstValue: 13266945 false) 
	#(167 5 #reduceActionForcreate_definition2: 1700866 false) 
	#(167 5 #reduceActionForcreate_definition10: 1700874 false) 
	#(160 9 #reduceActionForCreateTable4: 647172 false) 
	#(199 4 #reduceActionFordata_type18: 4733970 false) 
	#(176 3 #reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen___1: 3288065 false) 
	#(180 1 #liftFirstValue: 3462146 false) 
	#(182 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3502081 false) 
	#(200 3 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____1: 4925441 false) 
	#(200 3 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____7: 4925447 false) 
	#(199 4 #reduceActionFordata_type4: 4733956 false) 
	#(218 6 #reduceActionForpartition_options2: 10014722 false) 
	#(223 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 10644481 false) 
	#(218 6 #reduceActionForpartition_options5: 10014725 false) 
	#(216 2 #reduceActionFor_Statement__statement_______semicolon__1: 9952257 false) 
	#(215 6 #reduceActionFortable_option101: 7436389 false) 
	#(160 9 #reduceActionForCreateTable39: 647207 false) 
	#(160 9 #reduceActionForCreateTable11: 647179 false) 
	#(160 9 #reduceActionForCreateTable10: 647178 false) 
	#(160 9 #reduceActionForCreateTable26: 647194 false) 
	#(160 10 #reduceActionForCreateTable36: 647204 false) 
	#(160 10 #reduceActionForCreateTable5: 647173 false) 
	#(160 10 #reduceActionForCreateTable21: 647189 false) 
	#(207 6 #reduceActionForcheck_constraint_definition3: 6523907 false) 
	#(207 6 #reduceActionForcheck_constraint_definition5: 6523909 false) 
	#(207 6 #reduceActionForcheck_constraint_definition7: 6523911 false) 
	#(174 2 #reduceActionFor_Statement__statement_______semicolon___2: 2920450 false) 
	#(204 4 #reduceActionForkey_part8: 5781512 false) 
	#(204 4 #reduceActionForkey_part8: 5781513 false) 
	#(206 1 #reduceActionForindex_option7: 6052871 false) 
	#(206 1 #reduceActionForindex_option6: 6052870 false) 
	#(167 6 #reduceActionForcreate_definition18: 1700882 false) 
	#(206 1 #reduceActionForindex_option3: 6052867 false) 
	#(170 1 #liftFirstValue: 2178050 false) 
	#(168 2 #reduceActionFor______comma__key_part_1: 1893377 false) 
	#(204 4 #reduceActionForkey_part4: 5781508 false) 
	#(167 6 #reduceActionForcreate_definition3: 1700867 false) 
	#(167 6 #reduceActionForcreate_definition4: 1700868 false) 
	#(167 6 #reduceActionForcreate_definition6: 1700870 false) 
	#(167 6 #reduceActionForcreate_definition11: 1700875 false) 
	#(167 6 #reduceActionForcreate_definition12: 1700876 false) 
	#(167 6 #reduceActionForcreate_definition14: 1700878 false) 
	#(167 6 #reduceActionForcreate_definition30: 1700894 false) 
	#(167 6 #reduceActionForcreate_definition24: 1700888 false) 
	#(202 3 #reduceActionForenum_values2: 5393410 false) 
	#(188 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3638273 false) 
	#(181 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3502081 false) 
	#(182 1 #reduceActionForFile1: 3502082 false) 
	#(184 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3547137 false) 
	#(199 5 #reduceActionFordata_type5: 4733957 false) 
	#(200 4 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____3: 4925443 false) 
	#(200 4 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____6: 4925446 false) 
	#(218 7 #reduceActionForpartition_options3: 10014723 false) 
	#(223 1 #reduceActionForFile1: 10644482 false) 
	#(218 7 #reduceActionForpartition_options6: 10014726 false) 
	#(220 3 #reduceActionFor__ALGORITHM___algorithmToken_______equals____1___value_____2___value___1: 10223617 false) 
	#(220 3 #reduceActionFor__ALGORITHM___algorithmToken_______equals____1___value_____2___value___1: 10223618 false) 
	#(160 10 #reduceActionForCreateTable12: 647180 false) 
	#(160 11 #reduceActionForCreateTable7: 647175 false) 
	#(160 11 #reduceActionForCreateTable6: 647174 false) 
	#(160 11 #reduceActionForCreateTable22: 647190 false) 
	#(207 7 #reduceActionForcheck_constraint_definition6: 6523910 false) 
	#(167 7 #reduceActionForcreate_definition34: 1700898 false) 
	#(207 7 #reduceActionForcheck_constraint_definition8: 6523912 false) 
	#(167 7 #reduceActionForcreate_definition51: 1700915 false) 
	#(173 2 #reduceActionFor_Statement__statement_______semicolon__1: 2920449 false) 
	#(206 2 #reduceActionForindex_option5: 6052869 false) 
	#(206 2 #reduceActionForindex_option8: 6052872 false) 
	#(206 2 #reduceActionForindex_option1: 6052865 false) 
	#(206 2 #reduceActionForindex_option10: 6052874 false) 
	#(204 5 #reduceActionForkey_part5: 5781509 false) 
	#(204 5 #reduceActionForkey_part5: 5781510 false) 
	#(167 7 #reduceActionForcreate_definition20: 1700884 false) 
	#(167 7 #reduceActionForcreate_definition22: 1700886 false) 
	#(167 7 #reduceActionForcreate_definition19: 1700883 false) 
	#(167 7 #reduceActionForcreate_definition5: 1700869 false) 
	#(167 7 #reduceActionForcreate_definition7: 1700871 false) 
	#(167 7 #reduceActionForcreate_definition8: 1700872 false) 
	#(167 7 #reduceActionForcreate_definition13: 1700877 false) 
	#(167 7 #reduceActionForcreate_definition15: 1700879 false) 
	#(167 7 #reduceActionForcreate_definition16: 1700880 false) 
	#(167 7 #reduceActionForcreate_definition31: 1700895 false) 
	#(167 7 #reduceActionForcreate_definition32: 1700896 false) 
	#(167 7 #reduceActionForcreate_definition26: 1700890 false) 
	#(167 7 #reduceActionForcreate_definition28: 1700892 false) 
	#(167 7 #reduceActionForcreate_definition25: 1700889 false) 
	#(160 11 #reduceActionForCreateTable19: 647187 false) 
	#(188 1 #reduceActionForFile1: 3638274 false) 
	#(199 6 #reduceActionFordata_type16: 4733968 false) 
	#(176 5 #reduceActionFor__ON___onToken___UPDATE___updateToken___literal__value_________leftParen__expr__value_______rightParen___2: 3288066 false) 
	#(181 2 #reduceActionFor_Statement__statement_______semicolon__1: 3502082 false) 
	#(183 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3547137 false) 
	#(184 1 #reduceActionForFile1: 3547138 false) 
	#(186 0 #nil 3596289 false) 
	#(199 6 #reduceActionFordata_type7: 4733959 false) 
	#(199 6 #reduceActionFordata_type6: 4733958 false) 
	#(200 5 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____2: 4925442 false) 
	#(200 5 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____8: 4925448 false) 
	#(266 1 #liftFirstValue: 13676545 false) 
	#(222 2 #reduceActionFor_Statement__statement_______semicolon__1: 10644481 false) 
	#(262 3 #reduceActionForcolumn_list1: 13483009 false) 
	#(218 8 #reduceActionForpartition_options4: 10014724 false) 
	#(160 11 #reduceActionForCreateTable40: 647208 false) 
	#(160 11 #reduceActionForCreateTable13: 647181 false) 
	#(160 11 #reduceActionForCreateTable29: 647197 false) 
	#(160 12 #reduceActionForCreateTable8: 647176 false) 
	#(167 8 #reduceActionForcreate_definition53: 1700917 false) 
	#(167 8 #reduceActionForcreate_definition35: 1700899 false) 
	#(167 8 #reduceActionForcreate_definition36: 1700900 false) 
	#(207 8 #reduceActionForcheck_constraint_definition9: 6523913 false) 
	#(167 8 #reduceActionForcreate_definition38: 1700902 false) 
	#(167 8 #reduceActionForcreate_definition52: 1700916 false) 
	#(206 3 #reduceActionForindex_option9: 6052873 false) 
	#(206 3 #reduceActionForindex_option2: 6052866 false) 
	#(206 3 #reduceActionForindex_option11: 6052875 false) 
	#(264 1 #liftFirstValue: 13597697 false) 
	#(206 3 #reduceActionForindex_option4: 6052868 false) 
	#(167 8 #reduceActionForcreate_definition21: 1700885 false) 
	#(167 8 #reduceActionForcreate_definition23: 1700887 false) 
	#(167 8 #reduceActionForcreate_definition9: 1700873 false) 
	#(167 8 #reduceActionForcreate_definition17: 1700881 false) 
	#(167 8 #reduceActionForcreate_definition33: 1700897 false) 
	#(167 8 #reduceActionForcreate_definition27: 1700891 false) 
	#(167 8 #reduceActionForcreate_definition29: 1700893 false) 
	#(167 8 #reduceActionForcreate_definition42: 1700906 false) 
	#(160 12 #reduceActionForCreateTable20: 647188 false) 
	#(199 7 #reduceActionFordata_type21: 4733973 false) 
	#(199 7 #reduceActionFordata_type14: 4733966 false) 
	#(199 7 #reduceActionFordata_type17: 4733969 false) 
	#(187 2 #reduceActionFor_Statement__statement_______semicolon__1: 3638273 false) 
	#(183 2 #reduceActionFor______comma___table_option__option__2: 3547138 false) 
	#(186 1 #liftFirstValue: 3596290 false) 
	#(199 7 #reduceActionFordata_type8: 4733960 false) 
	#(199 7 #reduceActionFordata_type9: 4733961 false) 
	#(200 6 #reduceActionFor____CHARACTER___characterToken___SET___setToken_____CHARSET___charsetToken________equals___charset_name__charsetName_____COLLATE___collateToken__collation_name__collationName____4: 4925444 false) 
	#(160 12 #reduceActionForCreateTable15: 647183 false) 
	#(160 12 #reduceActionForCreateTable14: 647182 false) 
	#(160 12 #reduceActionForCreateTable30: 647198 false) 
	#(160 12 #reduceActionForCreateTable27: 647195 false) 
	#(167 9 #reduceActionForcreate_definition54: 1700918 false) 
	#(167 9 #reduceActionForcreate_definition37: 1700901 false) 
	#(167 9 #reduceActionForcreate_definition45: 1700909 false) 
	#(167 9 #reduceActionForcreate_definition55: 1700919 false) 
	#(167 9 #reduceActionForcreate_definition39: 1700903 false) 
	#(167 9 #reduceActionForcreate_definition40: 1700904 false) 
	#(167 9 #reduceActionForcreate_definition43: 1700907 false) 
	#(167 9 #reduceActionForcreate_definition44: 1700908 false) 
	#(199 8 #reduceActionFordata_type19: 4733971 false) 
	#(199 8 #reduceActionFordata_type22: 4733974 false) 
	#(199 8 #reduceActionFordata_type15: 4733967 false) 
	#(185 2 #liftFirstValue: 3596289 false) 
	#(190 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3700737 false) 
	#(199 8 #reduceActionFordata_type11: 4733963 false) 
	#(199 8 #reduceActionFordata_type10: 4733962 false) 
	#(160 13 #reduceActionForCreateTable16: 647184 false) 
	#(160 13 #reduceActionForCreateTable28: 647196 false) 
	#(160 14 #reduceActionForCreateTable23: 647191 false) 
	#(167 10 #reduceActionForcreate_definition46: 1700910 false) 
	#(167 10 #reduceActionForcreate_definition47: 1700911 false) 
	#(167 10 #reduceActionForcreate_definition56: 1700920 false) 
	#(167 10 #reduceActionForcreate_definition41: 1700905 false) 
	#(167 10 #reduceActionForcreate_definition48: 1700912 false) 
	#(199 9 #reduceActionFordata_type20: 4733972 false) 
	#(190 1 #reduceActionForFile1: 3700738 false) 
	#(192 0 #reduceActionForindex_type_1: 3823617 false) 
	#(199 9 #reduceActionFordata_type12: 4733964 false) 
	#(160 15 #reduceActionForCreateTable24: 647192 false) 
	#(167 11 #reduceActionForcreate_definition49: 1700913 false) 
	#(167 11 #reduceActionForcreate_definition50: 1700914 false) 
	#(197 0 #reduceActionForreference_definition_1: 4094977 false) 
	#(189 2 #reduceActionFor_Statement__statement_______semicolon__1: 3700739 false) 
	#(189 2 #reduceActionFor_Statement__statement_______semicolon__1: 3700738 false) 
	#(189 2 #reduceActionFor_Statement__statement_______semicolon__1: 3700737 false) 
	#(192 1 #reduceActionForFile1: 3823618 false) 
	#(194 0 #reduceActionForindex_type_1: 3913729 false) 
	#(160 15 #reduceActionForCreateTable31: 647199 false) 
	#(210 0 #reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option__1: 7088129 false) 
	#(198 0 #reduceActionForcheck_constraint_definition_1: 4119553 false) 
	#(197 1 #reduceActionForFile1: 4094978 false) 
	#(191 2 #reduceActionForindex_type1: 3823617 false) 
	#(194 1 #reduceActionForFile1: 3913730 false) 
	#(196 0 #reduceActionForindex_type_1: 4017153 false) 
	#(160 16 #reduceActionForCreateTable32: 647200 false) 
	#(210 1 #reduceActionForFile1: 7088130 false) 
	#(208 7 #reduceActionForreference_definition1: 6736897 false) 
	#(175 12 #reduceActionForcolumn_definition13: 3085325 false) 
	#(198 1 #reduceActionForFile1: 4119554 false) 
	#(175 12 #reduceActionForcolumn_definition10: 3085322 false) 
	#(191 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 3823618 false) 
	#(193 2 #reduceActionForindex_type1: 3913729 false) 
	#(196 1 #reduceActionForFile1: 4017154 false) 
	#(225 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 11018241 false) 
	#(175 13 #reduceActionForcolumn_definition15: 3085327 false) 
	#(175 13 #reduceActionForcolumn_definition12: 3085324 false) 
	#(193 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 3913730 false) 
	#(195 2 #reduceActionForindex_type1: 4017153 false) 
	#(195 2 #reduceActionForindex_type2: 4017154 false) 
	#(225 1 #reduceActionForFile1: 11018242 false) 
	#(208 9 #reduceActionForreference_definition3: 6736899 false) 
	#(208 9 #reduceActionForreference_definition5: 6736901 false) 
	#(208 9 #reduceActionForreference_definition7: 6736903 false) 
	#(211 1 #reduceActionForreference_option2: 7150594 false) 
	#(211 1 #reduceActionForreference_option1: 7150593 false) 
	#(209 3 #reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option_1: 7088129 false) 
	#(175 14 #reduceActionForcolumn_definition14: 3085326 false) 
	#(175 14 #reduceActionForcolumn_definition11: 3085323 false) 
	#(175 14 #reduceActionForcolumn_definition25: 3085337 false) 
	#(175 14 #reduceActionForcolumn_definition22: 3085334 false) 
	#(175 14 #reduceActionForcolumn_definition19: 3085331 false) 
	#(175 14 #reduceActionForcolumn_definition16: 3085328 false) 
	#(175 14 #reduceActionForcolumn_definition1: 3085313 false) 
	#(224 2 #reduceActionFor_Statement__statement_______semicolon__1: 11018241 false) 
	#(211 2 #reduceActionForreference_option4: 7150596 false) 
	#(211 2 #reduceActionForreference_option5: 7150597 false) 
	#(211 2 #reduceActionForreference_option3: 7150595 false) 
	#(208 10 #reduceActionForreference_definition2: 6736898 false) 
	#(175 15 #reduceActionForcolumn_definition27: 3085339 false) 
	#(175 15 #reduceActionForcolumn_definition24: 3085336 false) 
	#(175 15 #reduceActionForcolumn_definition21: 3085333 false) 
	#(175 15 #reduceActionForcolumn_definition18: 3085330 false) 
	#(175 15 #reduceActionForcolumn_definition7: 3085319 false) 
	#(227 0 #reduceActionFor_Statement__statement_______semicolon___1: 11138049 false) 
	#(175 16 #reduceActionForcolumn_definition26: 3085338 false) 
	#(175 16 #reduceActionForcolumn_definition23: 3085335 false) 
	#(175 16 #reduceActionForcolumn_definition31: 3085343 false) 
	#(175 16 #reduceActionForcolumn_definition28: 3085340 false) 
	#(175 16 #reduceActionForcolumn_definition2: 3085314 false) 
	#(175 16 #reduceActionForcolumn_definition20: 3085332 false) 
	#(175 16 #reduceActionForcolumn_definition17: 3085329 false) 
	#(175 16 #reduceActionForcolumn_definition4: 3085316 false) 
	#(230 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 11539457 false) 
	#(267 1 #liftFirstValue: 13697025 false) 
	#(208 12 #reduceActionForreference_definition4: 6736900 false) 
	#(208 12 #reduceActionForreference_definition6: 6736902 false) 
	#(208 12 #reduceActionForreference_definition8: 6736904 false) 
	#(175 17 #reduceActionForcolumn_definition33: 3085345 false) 
	#(175 17 #reduceActionForcolumn_definition30: 3085342 false) 
	#(175 17 #reduceActionForcolumn_definition8: 3085320 false) 
	#(230 1 #reduceActionForFile1: 11539458 false) 
	#(232 0 #reduceActionForindex_type_1: 11634689 false) 
	#(218 19 #reduceActionForpartition_options7: 10014727 false) 
	#(227 2 #reduceActionFor_Statement__statement_______semicolon___2: 11138050 false) 
	#(175 18 #reduceActionForcolumn_definition32: 3085344 false) 
	#(175 18 #reduceActionForcolumn_definition29: 3085341 false) 
	#(175 18 #reduceActionForcolumn_definition3: 3085315 false) 
	#(175 18 #reduceActionForcolumn_definition5: 3085317 false) 
	#(218 20 #reduceActionForpartition_options8: 10014728 false) 
	#(229 2 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__1: 11539457 false) 
	#(232 1 #reduceActionForFile1: 11634690 false) 
	#(234 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 11705345 false) 
	#(226 2 #reduceActionFor_Statement__statement_______semicolon__1: 11138049 false) 
	#(218 20 #reduceActionForpartition_options9: 10014729 false) 
	#(175 19 #reduceActionForcolumn_definition9: 3085321 false) 
	#(229 3 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__2: 11539458 false) 
	#(229 3 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__3: 11539459 false) 
	#(259 0 #reduceActionFor_Statement__statement_______semicolon___1: 13420546 false) 
	#(231 2 #reduceActionForindex_type1: 11634689 false) 
	#(234 1 #reduceActionForFile1: 11705346 false) 
	#(236 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 11805697 false) 
	#(218 21 #reduceActionForpartition_options10: 10014730 false) 
	#(175 20 #reduceActionForcolumn_definition6: 3085318 false) 
	#(229 4 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__4: 11539460 false) 
	#(261 0 #reduceActionFor_Statement__statement_______semicolon___1: 13448193 false) 
	#(231 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11634690 false) 
	#(236 1 #reduceActionForFile1: 11805698 false) 
	#(238 0 #reduceActionForindex_type_1: 11909121 false) 
	#(259 2 #reduceActionForvalue_list1: 13420545 false) 
	#(233 3 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__1: 11705345 false) 
	#(238 1 #reduceActionForFile1: 11909122 false) 
	#(240 0 #reduceActionForindex_type_1: 11981825 false) 
	#(261 2 #reduceActionFor_Statement__statement_______semicolon___2: 13448194 false) 
	#(233 4 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__2: 11705346 false) 
	#(235 3 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__1: 11805697 false) 
	#(237 2 #reduceActionForindex_type1: 11909121 false) 
	#(240 1 #reduceActionForFile1: 11981826 false) 
	#(242 0 #reduceActionForindex_type_1: 12054529 false) 
	#(260 2 #reduceActionFor_Statement__statement_______semicolon__1: 13448193 false) 
	#(235 4 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__2: 11805698 false) 
	#(237 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11909122 false) 
	#(239 2 #reduceActionForindex_type1: 11981825 false) 
	#(242 1 #reduceActionForFile1: 12054530 false) 
	#(244 0 #reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen___1: 12145665 false) 
	#(239 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11981826 false) 
	#(241 2 #reduceActionForindex_type1: 12054529 false) 
	#(244 1 #reduceActionForFile1: 12145666 false) 
	#(228 10 #reduceActionForpartition_definition1: 11211777 false) 
	#(241 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 12054530 false) 
	#(246 0 #reduceActionFor_Statement__statement_______semicolon___1: 12200961 false) 
	#(268 1 #liftFirstValue: 13742081 false) 
	#(248 0 #nil 12502017 false) 
	#(243 4 #reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen__1: 12145665 false) 
	#(246 2 #reduceActionFor_Statement__statement_______semicolon___2: 12200962 false) 
	#(228 14 #reduceActionForpartition_definition4: 11211780 false) 
	#(248 1 #liftFirstValue: 12502018 false) 
	#(245 2 #reduceActionFor_Statement__statement_______semicolon__1: 12200961 false) 
	#(228 15 #reduceActionForpartition_definition5: 11211781 false) 
	#(228 15 #reduceActionForpartition_definition2: 11211778 false) 
	#(228 15 #reduceActionForpartition_definition3: 11211779 false) 
	#(247 7 #reduceActionForsubpartition_definition1: 12281857 false) 
	#(247 9 #reduceActionForsubpartition_definition3: 12281859 false) 
	#(247 10 #reduceActionForsubpartition_definition2: 12281858 false) 
	#(247 10 #reduceActionForsubpartition_definition5: 12281861 false) 
	#(247 10 #reduceActionForsubpartition_definition7: 12281863 false) 
	#(247 11 #reduceActionForsubpartition_definition9: 12281865 false) 
	#(247 12 #reduceActionForsubpartition_definition4: 12281860 false) 
	#(247 13 #reduceActionForsubpartition_definition6: 12281862 false) 
	#(247 13 #reduceActionForsubpartition_definition8: 12281864 false) 
	#(247 14 #reduceActionForsubpartition_definition10: 12281866 false)
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
	^ #('"''LZ4''"' '"''N''"' '"''NONE''"' '"''Y''"' '"''ZLIB''"' '"("' '")"' '","' '"0"' '"1"' '"2"' '";"' '"="' '"ACTION"' '"ALGORITHM"' '"ALWAYS"' '"AS"' '"ASC"' '"AUTOEXTEND_SIZE"' '"AUTO_INCREMENT"' '"AVG_ROW_LENGTH"' '"BIGINT"' '"BLOB"' '"BTREE"' '"BY"' '"CASCADE"' '"CHAR"' '"CHARACTER"' '"CHARSET"' '"CHECK"' '"CHECKSUM"' '"COLLATE"' '"COLUMNS"' '"COLUMN_FORMAT"' '"COMMENT"' '"COMPACT"' '"COMPRESSED"' '"COMPRESSION"' '"CONNECTION"' '"CONSTRAINT"' '"CREATE"' '"CURRENT_TIMESTAMP"' '"DATA"' '"DATE"' '"DATETIME"' '"DECIMAL"' '"DEFAULT"' '"DELAY_KEY_WRITE"' '"DELETE"' '"DESC"' '"DIRECTORY"' '"DISK"' '"DOUBLE"' '"DROP"' '"DYNAMIC"' '"ENCRYPTION"' '"ENFORCED"' '"ENGINE"' '"ENGINE_ATTRIBUTE"' '"ENUM"' '"EXISTS"' '"FIRST"' '"FIXED"' '"FLOAT"' '"FOREIGN"' '"FULL"' '"FULLTEXT"' '"GENERATED"' '"HASH"' '"IF"' '"IGNORE"' '"IN"' '"INDEX"' '"INSERT_METHOD"' '"INT"' '"INVISIBLE"' '"InnoDB"' '"JSON"' '"KEY"' '"KEY_BLOCK_SIZE"' '"LAST"' '"LESS"' '"LIKE"' '"LINEAR"' '"LIST"' '"LONGBLOB"' '"LONGTEXT"' '"MATCH"' '"MAXVALUE"' '"MAX_ROWS"' '"MEDIUMBLOB"' '"MEDIUMTEXT"' '"MEMORY"' '"MIN_ROWS"' '"MyISAM"' '"NO"' '"NOT"' '"NULL"' '"ON"' '"PACK_KEYS"' '"PARSER"' '"PARTIAL"' '"PARTITION"' '"PARTITIONS"' '"PASSWORD"' '"PRIMARY"' '"RANGE"' '"REDUNDANT"' '"REFERENCES"' '"REPLACE"' '"RESTRICT"' '"ROW_FORMAT"' '"SECONDARY_ENGINE_ATTRIBUTE"' '"SET"' '"SIMPLE"' '"SMALLINT"' '"SPATIAL"' '"STATS_AUTO_RECALC"' '"STATS_PERSISTENT"' '"STATS_SAMPLE_PAGES"' '"STORAGE"' '"STORED"' '"SUBPARTITION"' '"SUBPARTITIONS"' '"TABLE"' '"TABLESPACE"' '"TEMPORARY"' '"TEXT"' '"THAN"' '"TIME"' '"TIMESTAMP"' '"TINYINT"' '"TINYTEXT"' '"UNION"' '"UNIQUE"' '"UPDATE"' '"USING"' '"VALUES"' '"VARBINARY"' '"VARCHAR"' '"VIRTUAL"' '"VISIBLE"' '"WITH"' '"unsigned"' '"zerofill"' '<string>' '<integer>' '<number>' '<name>' '<comment>' '<whitespace>' '<simple_name>' 'B e g i n' 'File' 'Statements' '(Statement ''statement'' ";" ''semicolon'')' '(Statement ''statement'' ";" ''semicolon'')*' 'Statement' 'DropTable' 'CreateTable' '("," ''comma'' create_definition ''definition'')' '("," ''comma'' create_definition ''definition'')*' 'partition_options?' '("IGNORE" ''ignoreToken'' | "REPLACE" ''replaceToken'')' '("IGNORE" ''ignoreToken'' | "REPLACE" ''replaceToken'')?' '"AS" ''asToken''?' 'create_definition' '("," ''comma'' key_part)' '("," ''comma'' key_part)*' 'index_option ''option''?' 'index_name ''indexName''?' 'index_type?' '("," ''comma'' col_name ''columnName'')' '("," ''comma'' col_name ''columnName'')*' 'column_definition' '("ON" ''onToken'' "UPDATE" ''updateToken'' (literal ''value'' | "(" ''leftParen'' expr ''value'' ")" ''rightParen''))' '("ON" ''onToken'' "UPDATE" ''updateToken'' (literal ''value'' | "(" ''leftParen'' expr ''value'' ")" ''rightParen''))?' '("VISIBLE" ''visibleToken'' | "INVISIBLE" ''invisibleToken'')' '("VISIBLE" ''visibleToken'' | "INVISIBLE" ''invisibleToken'')?' '"AUTO_INCREMENT" ''autoIncrementToken''?' '("UNIQUE" ''uniqueToken'' "KEY" ''keyToken''?)' '("UNIQUE" ''uniqueToken'' "KEY" ''keyToken''?)?' '("PRIMARY" ''primaryToken''? "KEY" ''keyToken'')' '("PRIMARY" ''primaryToken''? "KEY" ''keyToken'')?' '("COMMENT" ''commentToken'' <string>)' '("COMMENT" ''commentToken'' <string>)?' '("COLLATE" ''collateToken'' collation_name ''collationName'')' '("COLLATE" ''collateToken'' collation_name ''collationName'')?' '("COLUMN_FORMAT" ''columnFormatToken'' ("FIXED" ''columnFormat'' | "DYNAMIC" ''columnFormat'' | "DEFAULT" ''columnFormat''))' '("COLUMN_FORMAT" ''columnFormatToken'' ("FIXED" ''columnFormat'' | "DYNAMIC" ''columnFormat'' | "DEFAULT" ''columnFormat''))?' '("ENGINE_ATTRIBUTE" ''engineAttributeToken'' "=" ''equals''? <string> ''engineAttribute'')' '("ENGINE_ATTRIBUTE" ''engineAttributeToken'' "=" ''equals''? <string> ''engineAttribute'')?' '("SECONDARY_ENGINE_ATTRIBUTE" ''secondaryToken'' "=" ''equals''? <string> ''secondaryEngineAttribute'')' '("SECONDARY_ENGINE_ATTRIBUTE" ''secondaryToken'' "=" ''equals''? <string> ''secondaryEngineAttribute'')?' '("STORAGE" ''storageToken'' ("DISK" ''diskToken'' | "MEMORY" ''memoryToken''))' '("STORAGE" ''storageToken'' ("DISK" ''diskToken'' | "MEMORY" ''memoryToken''))?' 'reference_definition?' 'check_constraint_definition?' 'data_type' '((("CHARACTER" ''characterToken'' "SET" ''setToken'' | "CHARSET" ''charsetToken'') "=" ''equals''? charset_name ''charsetName'') ("COLLATE" ''collateToken'' collation_name ''collationName'')?)' '((("CHARACTER" ''characterToken'' "SET" ''setToken'' | "CHARSET" ''charsetToken'') "=" ''equals''? charset_name ''charsetName'') ("COLLATE" ''collateToken'' collation_name ''collationName'')?)?' 'enum_values' 'data_type_name' 'key_part' 'index_type' 'index_option' 'check_constraint_definition' 'reference_definition' '("ON" ''onToken'' "UPDATE" ''updateToken'' reference_option)' '("ON" ''onToken'' "UPDATE" ''updateToken'' reference_option)?' 'reference_option' 'table_options' '("," ''comma''? table_option ''option'')' '("," ''comma''? table_option ''option'')*' 'table_option' '("," ''comma'' tbl_name ''tableName'')' '("," ''comma'' tbl_name ''tableName'')*' 'partition_options' '"LINEAR" ''linearToken''?' '("ALGORITHM" ''algorithmToken'' "=" ''equals'' ("1" ''value'' | "2" ''value''))' '("ALGORITHM" ''algorithmToken'' "=" ''equals'' ("1" ''value'' | "2" ''value''))?' '("PARTITIONS" ''partitionsToken'' num ''partitions'')' '("PARTITIONS" ''partitionsToken'' num ''partitions'')?' '("SUBPARTITIONS" ''subpartitionsToken'' num ''subpartitions'')' '("SUBPARTITIONS" ''subpartitionsToken'' num ''subpartitions'')?' '("," ''comma'' partition_definition ''definition'')' '("," ''comma'' partition_definition ''definition'')*' 'partition_definition' '("STORAGE" ''storageToken''? "ENGINE" ''engineToken'' "=" ''equals''? engine_name ''engineName'')' '("STORAGE" ''storageToken''? "ENGINE" ''engineToken'' "=" ''equals''? engine_name ''engineName'')?' '("COMMENT" ''commentToken'' "=" ''equals''? <string> ''comment'')' '("COMMENT" ''commentToken'' "=" ''equals''? <string> ''comment'')?' '("DATA" ''dataToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''dataDirectory'')' '("DATA" ''dataToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''dataDirectory'')?' '("INDEX" ''indexToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''indexDirectory'')' '("INDEX" ''indexToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''indexDirectory'')?' '("MAX_ROWS" ''maxRowsToken'' "=" ''equals''? <integer> ''maxRows'')' '("MAX_ROWS" ''maxRowsToken'' "=" ''equals''? <integer> ''maxRows'')?' '("MIN_ROWS" ''minRowsToken'' "=" ''equals''? <integer> ''minRows'')' '("MIN_ROWS" ''minRowsToken'' "=" ''equals''? <integer> ''minRows'')?' '("TABLESPACE" ''tableSpaceToken'' "=" ''equals''? tablespace_name ''tablespaceName'')' '("TABLESPACE" ''tableSpaceToken'' "=" ''equals''? tablespace_name ''tablespaceName'')?' '("(" ''leftParen'' subpartition_definition ''definition'' ("," ''comma'' subpartition_definition ''definition'')* ")" ''rightParen'')' '("(" ''leftParen'' subpartition_definition ''definition'' ("," ''comma'' subpartition_definition ''definition'')* ")" ''rightParen'')?' '("," ''comma'' subpartition_definition ''definition'')' '("," ''comma'' subpartition_definition ''definition'')*' 'subpartition_definition' '"=" ''equals''?' 'tbl_name' 'col_name' 'literal' 'index_name' 'engine_name' 'charset_name' 'length' 'collation_name' 'query_expression' 'expr' 'value_list' '("," ''comma'' expr ''value'')' '("," ''comma'' expr ''value'')*' 'column_list' 'symbol' 'parser_name' 'tablespace_name' 'num' 'partition_name' 'logical_name' 'value' 'E O F' 'error')
]

{ #category : #generated }
MysqlParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #MysqlFileNode #MysqlFileNode #MysqlFileNode #OrderedCollection #OrderedCollection #MysqlProgramNode #MysqlDropTableNode #MysqlCreateTableNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #MysqlProgramNode #OrderedCollection #OrderedCollection #MysqlIndexOptionNode #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlDataTypeNode #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #MysqlIndexOptionNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlTableOptionNode #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlPartitionDefinitionNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlSubpartitionDefinitionNode #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode #SmaCCErrorNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCErrorNode #SmaCCToken #SmaCCErrorNode #SmaCCToken #SmaCCErrorNode #SmaCCErrorNode #Object #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
MysqlParser class >> transitionTable [
^#(
#[1 0 6 0 12 0 6 0 41 0 6 0 54 0 9 0 154 0 13 0 155 0 17 0 157 0 6 1 14] 
#[0 0 0 1 14] 
#[0 0 10 1 14] 
#[1 0 14 0 12 0 21 0 41 0 25 0 54 0 29 0 156 0 33 0 158 0 33 0 159 0 33 0 160 0 14 1 14] 
#[1 0 45 0 125 0 49 0 127] 
#[0 0 53 0 125] 
#[0 0 18 0 12 0 41 0 54 1 14] 
#[1 0 57 0 12 0 22 1 14] 
#[0 0 26 0 12 1 14] 
#[0 0 30 0 12 1 14] 
#[1 0 61 0 70 0 69 0 149 0 69 0 249] 
#[0 0 73 0 125] 
#[1 0 77 0 70 0 81 0 149 0 81 0 249] 
#[0 0 34 0 12 0 41 0 54 1 14] 
#[0 0 85 0 97] 
#[0 0 38 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 83 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 0 89 0 6 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 0 169 0 83 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 0 221 0 163 0 225 0 212 0 229 0 215 0 233 0 218 0 42 1 15] 
#[1 0 237 0 70 0 241 0 149 0 241 0 249] 
#[0 0 245 0 61] 
#[0 0 46 0 12 1 14] 
#[0 0 249 0 61] 
#[1 0 253 0 30 1 1 0 40 1 5 0 65 1 9 0 67 1 13 0 73 1 17 0 79 1 21 0 83 1 25 0 106 1 29 0 117 1 33 0 135 1 49 0 149 1 41 0 167 1 45 0 207 1 49 0 250] 
#[1 1 53 0 13 1 57 0 42 1 77 0 98 1 77 0 146 1 77 0 148 1 77 0 251 1 77 1 13 1 77 1 15] 
#[1 1 85 0 13 1 57 0 42 1 89 0 98 1 89 0 146 1 89 0 148 1 89 0 251 1 89 1 13 1 89 1 15] 
#[1 1 93 0 13 1 57 0 42 1 97 0 98 1 97 0 146 1 97 0 148 1 97 0 251 1 97 1 13 1 97 1 15] 
#[0 1 101 0 114] 
#[1 1 105 0 13 1 113 0 152 1 113 0 254] 
#[1 1 117 0 9 1 121 0 10 1 125 0 13] 
#[1 1 129 0 13 1 141 0 146 1 141 0 152 1 141 1 0] 
#[1 1 145 0 13 1 149 0 146] 
#[1 1 153 0 1 1 157 0 3 1 161 0 5 1 165 0 13] 
#[1 1 169 0 13 1 173 0 146] 
#[0 1 177 0 51] 
#[1 1 181 0 28 1 185 0 29 1 189 0 32] 
#[1 1 193 0 9 1 197 0 10 1 201 0 13] 
#[1 1 205 0 2 1 209 0 4 1 213 0 13] 
#[1 1 217 0 13 1 229 0 77 1 229 0 95 1 229 0 253] 
#[1 1 233 0 13 1 237 0 146] 
#[0 1 241 0 51] 
#[1 1 245 0 13 1 249 0 62 1 253 0 81 2 1 0 96] 
#[1 2 5 0 13 1 57 0 42 2 9 0 98 2 9 0 146 2 9 0 148 2 9 0 251 2 9 1 13 2 9 1 15] 
#[0 2 13 0 149 0 249] 
#[1 2 17 0 13 1 57 0 42 2 21 0 98 2 21 0 146 2 21 0 148 2 21 0 251 2 21 1 13 2 21 1 15] 
#[1 2 25 0 13 1 57 0 42 2 29 0 98 2 29 0 146 2 29 0 148 2 29 0 251 2 29 1 13 2 29 1 15] 
#[1 2 33 0 9 2 37 0 10 2 41 0 13 2 45 0 47] 
#[0 2 49 0 25] 
#[1 2 53 0 13 2 57 0 146] 
#[1 2 61 0 13 2 65 0 36 2 69 0 37 2 73 0 47 2 77 0 55 2 81 0 63 2 85 0 108] 
#[1 2 89 0 13 2 93 0 146] 
#[1 2 97 0 9 2 101 0 10 2 105 0 13 2 109 0 47] 
#[1 2 113 0 9 2 117 0 10 2 121 0 13 2 125 0 47] 
#[1 2 129 0 13 1 57 0 42 2 133 0 98 2 133 0 146 2 133 0 148 2 133 0 251 2 133 1 13 2 133 1 15] 
#[0 2 137 1 9 1 15] 
#[1 2 145 0 6 2 149 0 13] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 2 165 0 165 0 50 1 15] 
#[1 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 2 169 0 163 0 233 0 218 0 42 1 15] 
#[1 0 54 0 8 0 54 0 12 0 54 0 17 0 54 0 19 0 54 0 20 0 54 0 21 0 54 0 28 0 54 0 29 0 54 0 31 0 54 0 32 0 54 0 35 0 54 0 38 0 54 0 39 0 54 0 43 0 54 0 47 0 54 0 48 0 54 0 56 0 54 0 58 0 54 0 59 0 54 0 71 0 54 0 73 0 54 0 74 0 54 0 80 0 54 0 90 0 54 0 94 0 54 0 100 0 54 0 103 0 54 0 105 0 54 0 110 0 54 0 112 0 54 0 113 0 54 0 118 0 54 0 119 0 54 0 120 0 54 0 126 0 54 0 134 2 173 0 214 0 54 1 14 0 54 1 15] 
#[0 0 58 0 17 0 71 0 110 1 15] 
#[0 2 177 0 97] 
#[1 2 181 0 6 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 2 185 0 83 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 2 189 0 163 2 193 0 212 0 229 0 215 0 233 0 218 0 42 1 15] 
#[0 2 197 0 149 0 249] 
#[0 2 201 0 149 0 249] 
#[0 2 205 0 6] 
#[1 2 209 0 30 2 213 0 65 2 217 0 106 2 221 0 135 2 225 1 7 2 225 1 15] 
#[0 2 233 0 79] 
#[1 2 237 0 6 2 241 0 73 2 245 0 79 2 253 0 149 2 253 0 252] 
#[1 3 1 0 6 3 5 0 137 3 13 0 149 3 9 0 205 3 13 0 252] 
#[1 3 17 0 6 3 5 0 137 3 25 0 149 3 21 0 205 3 25 0 252] 
#[0 3 29 0 149 0 249] 
#[0 3 33 0 79] 
#[1 3 37 0 6 3 41 0 73 3 45 0 79 3 49 0 149 3 49 0 252] 
#[1 0 62 0 6 3 53 0 73 3 57 0 79 0 62 0 137 3 61 0 149 3 61 0 171 3 61 0 252] 
#[0 0 66 0 6 0 7 0 8 0 18 0 22 0 23 0 27 0 44 0 45 0 46 0 50 0 53 0 60 0 64 0 75 0 78 0 86 0 87 0 91 0 92 0 116 0 128 0 130 0 131 0 132 0 133 0 139 0 140] 
#[1 0 70 0 7 0 70 0 8 3 69 0 162] 
#[0 0 74 0 7 0 8] 
#[1 3 173 0 22 3 173 0 23 3 173 0 27 3 173 0 44 3 173 0 45 3 173 0 46 3 173 0 53 3 101 0 60 3 173 0 64 3 173 0 75 3 173 0 78 3 173 0 86 3 173 0 87 3 173 0 91 3 173 0 92 3 173 0 116 3 173 0 128 3 173 0 130 3 173 0 131 3 173 0 132 3 173 0 133 3 173 0 139 3 173 0 140 3 165 0 175 3 169 0 199 3 173 0 203] 
#[1 1 57 0 42 3 177 0 98 3 177 0 146 3 177 0 148 3 177 0 251 3 177 1 13 3 177 1 15] 
#[1 3 181 0 6 0 78 0 7 0 78 0 8 0 78 0 12 0 78 0 17 0 78 0 19 0 78 0 20 0 78 0 21 0 78 0 28 0 78 0 29 0 78 0 30 0 78 0 31 0 78 0 32 0 78 0 34 0 78 0 35 0 78 0 38 0 78 0 39 0 78 0 40 0 78 0 43 0 78 0 47 0 78 0 48 0 78 0 56 0 78 0 58 0 78 0 59 0 78 0 68 0 78 0 71 0 78 0 73 0 78 0 74 0 78 0 76 0 78 0 79 0 78 0 80 0 78 0 90 0 78 0 94 0 78 0 97 0 78 0 98 0 78 0 99 0 78 0 100 0 78 0 103 0 78 0 105 0 78 0 106 0 78 0 109 0 78 0 110 0 78 0 112 0 78 0 113 0 78 0 118 0 78 0 119 0 78 0 120 0 78 0 121 0 78 0 126 0 78 0 134 0 78 0 135 0 78 0 142 0 78 1 14 0 78 1 15] 
#[0 0 82 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 56 0 58 0 59 0 68 0 71 0 73 0 74 0 76 0 79 0 80 0 90 0 94 0 97 0 98 0 99 0 100 0 103 0 105 0 106 0 109 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 0 135 0 142 1 14 1 15] 
#[0 0 86 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 56 0 58 0 59 0 68 0 71 0 73 0 74 0 76 0 79 0 80 0 90 0 94 0 97 0 98 0 99 0 100 0 103 0 105 0 106 0 109 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 0 135 0 142 1 14 1 15] 
#[0 0 90 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 56 0 58 0 59 0 68 0 71 0 73 0 74 0 76 0 79 0 80 0 90 0 94 0 97 0 98 0 99 0 100 0 103 0 105 0 106 0 109 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 0 135 0 142 1 14 1 15] 
#[0 0 94 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 98 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 102 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 1 57 0 42 3 185 0 98 3 185 0 146 3 185 0 148 3 185 0 251 3 185 1 13 3 185 1 15] 
#[0 0 106 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 1 57 0 42 3 189 0 98 3 189 0 146 3 189 0 148 3 189 0 251 3 189 1 13 3 189 1 15] 
#[0 0 110 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 3 193 0 13 3 197 0 152 3 197 0 254] 
#[0 3 201 0 152 0 254] 
#[0 0 114 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 56 0 58 0 59 0 68 0 71 0 73 0 74 0 76 0 79 0 80 0 90 0 94 0 97 0 98 0 99 0 100 0 103 0 105 0 106 0 109 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 0 135 0 142 1 14 1 15] 
#[0 0 118 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 122 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 126 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 3 205 0 9 3 209 0 10] 
#[0 3 213 0 146 0 152 1 0] 
#[0 0 130 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 56 0 58 0 59 0 68 0 71 0 73 0 74 0 76 0 79 0 80 0 90 0 94 0 97 0 98 0 99 0 100 0 103 0 105 0 106 0 109 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 0 135 0 142 1 14 1 15] 
#[0 0 134 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 56 0 58 0 59 0 68 0 71 0 73 0 74 0 76 0 79 0 80 0 90 0 94 0 97 0 98 0 99 0 100 0 103 0 105 0 106 0 109 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 0 135 0 142 1 14 1 15] 
#[0 0 138 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 3 217 0 146] 
#[0 0 142 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 146 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 150 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 154 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 3 221 0 1 3 225 0 3 3 229 0 5] 
#[0 3 233 0 146] 
#[0 0 158 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 3 237 0 13 3 241 0 146] 
#[0 3 245 0 114] 
#[1 3 249 0 13 3 253 0 152 3 253 0 254] 
#[1 4 1 0 13 4 5 0 146 4 5 0 152 4 5 1 0] 
#[0 0 162 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 166 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 4 9 0 9 4 13 0 10] 
#[0 0 170 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 174 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 4 17 0 2 4 21 0 4] 
#[0 4 25 0 77 0 95 0 253] 
#[0 0 178 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 182 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 186 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 4 29 0 146] 
#[0 0 190 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 4 33 0 13 4 37 0 146] 
#[1 4 41 0 62 4 45 0 81 4 49 0 96] 
#[0 0 194 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 198 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 202 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 1 57 0 42 4 53 0 98 4 53 0 146 4 53 0 148 4 53 0 251 4 53 1 13 4 53 1 15] 
#[0 0 206 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 210 0 12 1 14] 
#[1 1 57 0 42 4 57 0 98 4 57 0 146 4 57 0 148 4 57 0 251 4 57 1 13 4 57 1 15] 
#[0 0 214 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 1 57 0 42 4 61 0 98 4 61 0 146 4 61 0 148 4 61 0 251 4 61 1 13 4 61 1 15] 
#[0 0 218 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 222 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 226 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 4 65 0 9 4 69 0 10 4 73 0 47] 
#[0 0 230 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 0 234 0 12 0 234 0 17 4 77 0 69 0 234 0 71 0 238 0 79 4 81 0 84 4 85 0 85 4 89 0 107 0 234 0 110 4 93 0 219 0 234 1 14 0 234 1 15] 
#[0 4 97 0 146] 
#[0 0 242 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 4 101 0 36 4 105 0 37 4 109 0 47 4 113 0 55 4 117 0 63 4 121 0 108] 
#[0 0 246 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 250 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 0 254 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 2 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 6 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 10 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 4 125 0 146] 
#[0 1 14 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 18 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 22 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 4 129 0 9 4 133 0 10 4 137 0 47] 
#[0 1 26 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 30 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 34 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 4 141 0 9 4 145 0 10 4 149 0 47] 
#[0 1 38 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 1 57 0 42 4 153 0 98 4 153 0 146 4 153 0 148 4 153 0 251 4 153 1 13 4 153 1 15] 
#[0 1 42 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 1 46 0 8 1 46 0 12 1 46 0 17 1 46 0 19 1 46 0 20 1 46 0 21 1 46 0 28 1 46 0 29 1 46 0 31 1 46 0 32 1 46 0 35 1 46 0 38 1 46 0 39 1 46 0 43 1 46 0 47 1 46 0 48 1 46 0 56 1 46 0 58 1 46 0 59 1 46 0 71 1 46 0 73 1 46 0 74 1 46 0 80 1 46 0 90 1 46 0 94 1 46 0 100 1 46 0 103 1 46 0 105 1 46 0 110 1 46 0 112 1 46 0 113 1 46 0 118 1 46 0 119 1 46 0 120 4 157 0 121 1 46 0 126 1 46 0 134 1 46 1 14 1 46 1 15] 
#[0 1 50 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 1 14 1 15] 
#[0 4 161 0 149 0 249] 
#[0 4 165 0 6] 
#[0 1 54 0 17 1 15] 
#[0 1 58 0 17 1 15] 
#[0 1 62 0 17 1 15] 
#[1 4 173 0 17 4 173 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 4 177 0 165 0 50 1 15] 
#[1 4 181 0 8 1 70 0 12 1 70 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 1 70 0 71 0 157 0 73 0 161 0 74 0 165 0 80 0 173 0 90 0 177 0 94 0 181 0 100 1 70 0 103 0 189 0 105 1 70 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 4 185 0 213 4 189 0 215 1 70 1 14 1 70 1 15] 
#[0 4 193 0 61] 
#[1 0 253 0 30 1 1 0 40 1 5 0 65 1 9 0 67 1 13 0 73 1 17 0 79 4 197 0 83 1 25 0 106 1 29 0 117 1 33 0 135 1 49 0 149 4 201 0 167 1 45 0 207 1 49 0 250] 
#[0 4 205 0 149 0 249] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 4 209 0 165 0 50 1 15] 
#[1 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 4 213 0 163 0 233 0 218 0 42 1 15] 
#[0 1 74 0 12 1 14] 
#[1 4 217 0 6 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 4 221 0 83 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 4 225 0 163 4 229 0 212 0 229 0 215 0 233 0 218 0 42 1 15] 
#[0 4 233 1 2 1 15] 
#[0 4 241 0 6] 
#[0 4 245 0 79] 
#[0 4 249 0 79] 
#[1 0 62 0 6 4 253 0 73 5 1 0 79 0 62 0 137 5 5 0 149 5 5 0 171 5 5 0 252] 
#[1 5 9 0 30 5 13 0 65 5 17 0 106 5 21 0 135] 
#[0 1 78 0 30 0 65 0 106 0 135] 
#[1 5 25 0 6 5 29 0 149 5 29 0 252] 
#[1 5 33 0 6 5 41 0 149 5 37 0 204 5 41 0 250] 
#[1 5 45 0 6 5 49 0 149 5 49 0 252] 
#[1 5 53 0 6 5 57 0 149 5 57 0 252] 
#[0 1 82 0 6 0 137] 
#[0 5 61 0 6] 
#[1 5 33 0 6 5 41 0 149 5 65 0 204 5 41 0 250] 
#[1 5 69 0 24 5 73 0 69] 
#[0 5 77 0 6] 
#[1 5 81 0 6 3 5 0 137 5 85 0 205] 
#[1 5 33 0 6 5 41 0 149 5 89 0 204 5 41 0 250] 
#[0 5 93 0 6] 
#[1 5 97 0 6 3 5 0 137 5 101 0 205] 
#[0 5 105 0 7] 
#[1 5 109 0 6 3 5 0 137 5 113 0 205] 
#[1 5 33 0 6 5 41 0 149 5 117 0 204 5 41 0 250] 
#[1 5 121 0 6 5 125 0 149 5 125 0 252] 
#[1 5 129 0 6 5 133 0 149 5 133 0 252] 
#[0 5 137 0 6] 
#[1 0 62 0 6 0 62 0 137 5 141 0 149 5 141 0 171 5 141 0 252] 
#[1 0 62 0 6 0 62 0 137 5 145 0 149 5 145 0 171 5 145 0 252] 
#[1 1 86 0 6 3 5 0 137 5 149 0 172 5 153 0 205] 
#[0 1 90 0 6 0 137] 
#[1 5 157 0 7 5 161 0 8 5 165 0 161] 
#[0 1 94 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 98 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 102 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 106 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 110 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 114 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 118 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 5 169 0 6] 
#[0 1 122 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 126 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 130 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 134 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 138 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 142 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 146 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 150 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 154 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 158 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 162 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 166 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 170 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 174 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 178 0 6 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142 0 144 0 145] 
#[0 1 182 0 7 0 8] 
#[1 1 186 0 7 1 186 0 8 5 173 0 17 1 186 0 20 1 186 0 30 0 7 0 32 1 186 0 34 1 186 0 35 1 186 0 40 5 181 0 47 1 186 0 59 5 185 0 68 1 186 0 76 1 186 0 79 5 189 0 97 5 193 0 98 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 5 205 0 177] 
#[1 5 209 0 6 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 5 221 0 144 5 225 0 145 5 229 0 200 5 233 0 201] 
#[0 1 194 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 5 237 0 7] 
#[0 1 198 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 202 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 5 241 0 152 0 254] 
#[0 1 206 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 210 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 214 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 218 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 222 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 226 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 230 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 234 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 238 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 1 242 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 5 245 0 146] 
#[0 1 246 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 5 249 0 13 5 253 0 152 5 253 0 254] 
#[0 6 1 0 152 0 254] 
#[0 1 250 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 6 5 0 146 0 152 1 0] 
#[0 1 254 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 2 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 6 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 10 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 14 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 18 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 22 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 6 9 0 146] 
#[0 2 26 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 30 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 34 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 38 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 42 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 46 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 50 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 54 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 58 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 62 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 6 13 0 6] 
#[1 6 17 0 69 2 66 0 79] 
#[1 6 21 0 6 6 25 0 33] 
#[1 6 29 0 6 6 33 0 33] 
#[0 6 37 0 79] 
#[0 2 70 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 74 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 78 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 82 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 86 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 90 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 94 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 98 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 102 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 106 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 110 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 114 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 118 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 122 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 126 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 6 41 0 52 6 45 0 93] 
#[1 2 130 0 7 2 130 0 8 6 49 0 217] 
#[0 6 53 0 149 0 249] 
#[0 2 134 1 15] 
#[0 6 57 1 1 1 15] 
#[1 6 65 0 17 6 65 0 166 1 66 1 15] 
#[1 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 157 0 73 0 161 0 74 0 165 0 80 0 173 0 90 0 177 0 94 0 181 0 100 0 189 0 105 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 6 69 0 215] 
#[0 2 138 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 142 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 6 73 0 149 0 249] 
#[0 6 77 0 149 0 249] 
#[1 0 70 0 7 0 70 0 8 6 81 0 162] 
#[0 2 146 0 12 1 14] 
#[1 6 85 0 17 6 85 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 6 89 0 165 0 50 1 15] 
#[1 0 253 0 30 1 1 0 40 1 5 0 65 1 9 0 67 1 13 0 73 1 17 0 79 6 93 0 83 1 25 0 106 1 29 0 117 1 33 0 135 1 49 0 149 6 97 0 167 1 45 0 207 1 49 0 250] 
#[0 6 101 0 149 0 249] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 6 105 0 165 0 50 1 15] 
#[1 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 6 109 0 163 0 233 0 218 0 42 1 15] 
#[0 6 113 0 7] 
#[0 2 150 0 6 0 7 0 8 0 35 0 43 0 58 0 73 0 90 0 94 0 121 0 126] 
#[0 6 117 1 2 1 15] 
#[1 6 121 0 6 6 125 0 149 6 125 0 252] 
#[1 6 129 0 6 3 5 0 137 6 133 0 205] 
#[1 0 62 0 6 0 62 0 137 6 137 0 149 6 137 0 171 6 137 0 252] 
#[1 0 62 0 6 0 62 0 137 6 141 0 149 6 141 0 171 6 141 0 252] 
#[1 1 86 0 6 3 5 0 137 6 145 0 172 5 153 0 205] 
#[0 6 149 0 6] 
#[0 6 153 0 79] 
#[0 6 157 0 79] 
#[1 0 62 0 6 6 161 0 73 6 165 0 79 0 62 0 137 6 169 0 149 6 169 0 171 6 169 0 252] 
#[0 6 173 0 149 0 250] 
#[0 6 177 0 6] 
#[0 6 181 1 2 1 15] 
#[1 2 154 0 7 2 154 0 8 6 185 0 169] 
#[1 6 189 0 6 2 158 0 7 2 158 0 8 6 193 0 18 6 197 0 50] 
#[1 5 33 0 6 5 41 0 149 6 201 0 204 5 41 0 250] 
#[0 6 205 0 6] 
#[1 5 33 0 6 5 41 0 149 6 209 0 204 5 41 0 250] 
#[0 6 213 0 6] 
#[1 5 33 0 6 5 41 0 149 6 217 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 6 221 0 169] 
#[0 2 162 0 6 0 7 0 8] 
#[0 2 166 0 6 0 7 0 8] 
#[1 5 33 0 6 5 41 0 149 6 225 0 204 5 41 0 250] 
#[1 5 33 0 6 5 41 0 149 6 229 0 204 5 41 0 250] 
#[0 6 233 0 6] 
#[1 2 154 0 7 2 154 0 8 6 237 0 169] 
#[1 5 33 0 6 5 41 0 149 6 241 0 204 5 41 0 250] 
#[1 5 33 0 6 5 41 0 149 6 245 0 204 5 41 0 250] 
#[0 6 249 0 6] 
#[0 2 170 0 12 1 14] 
#[1 5 33 0 6 5 41 0 149 6 253 0 204 5 41 0 250] 
#[0 7 1 0 6] 
#[1 2 154 0 7 2 154 0 8 7 5 0 169] 
#[1 5 33 0 6 5 41 0 149 7 9 0 204 5 41 0 250] 
#[0 7 13 0 6] 
#[1 5 33 0 6 5 41 0 149 7 17 0 204 5 41 0 250] 
#[0 7 21 0 6] 
#[1 5 33 0 6 5 41 0 149 7 25 0 204 5 41 0 250] 
#[1 1 86 0 6 3 5 0 137 7 29 0 172 5 153 0 205] 
#[1 1 86 0 6 3 5 0 137 7 33 0 172 5 153 0 205] 
#[0 7 37 0 6] 
#[0 2 174 0 6] 
#[1 2 178 0 12 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 7 41 0 163 7 45 0 212 0 229 0 215 7 49 0 218 2 178 1 14 0 42 1 15] 
#[1 0 253 0 30 1 1 0 40 1 5 0 65 1 9 0 67 1 13 0 73 1 17 0 79 1 25 0 106 1 29 0 117 1 33 0 135 1 49 0 149 7 53 0 167 1 45 0 207 1 49 0 250] 
#[0 2 182 0 7 0 8] 
#[1 1 57 0 42 7 61 0 98 7 61 0 146 7 61 0 148 7 57 0 202 7 61 0 251] 
#[0 7 65 0 6] 
#[0 7 69 0 146 0 152 1 0] 
#[1 7 73 0 6 1 57 0 42 7 77 0 98 7 77 0 146 7 77 0 148 7 77 0 251] 
#[0 7 81 0 16] 
#[0 7 85 0 98] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 7 89 0 47 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 7 93 0 177] 
#[0 7 97 0 136] 
#[0 2 186 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 59 0 76 0 79 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 7 113 0 179] 
#[0 7 117 0 147] 
#[0 7 121 0 114] 
#[1 7 125 0 13 7 129 0 152 7 129 0 254] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 7 133 0 145 5 229 0 200 7 137 0 201] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 5 229 0 200 7 141 0 201] 
#[0 2 194 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 2 198 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 2 202 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 30 0 31 0 32 0 34 0 35 0 38 0 39 0 40 0 43 0 47 0 48 0 56 0 58 0 59 0 68 0 71 0 73 0 74 0 76 0 79 0 80 0 90 0 94 0 97 0 98 0 99 0 100 0 103 0 105 0 106 0 109 0 110 0 112 0 113 0 118 0 119 0 120 0 121 0 126 0 134 0 135 0 142 1 14 1 15] 
#[0 2 206 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 210 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 7 145 0 152 0 254] 
#[0 2 214 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 218 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 222 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 226 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 7 149 1 2 1 15] 
#[0 7 153 0 6] 
#[0 7 157 1 2 1 15] 
#[0 7 161 0 6] 
#[0 7 165 1 2 1 15] 
#[0 7 169 0 6] 
#[1 2 230 0 6 7 173 0 15 7 177 0 220 7 181 0 221] 
#[0 2 234 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 2 238 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 7 185 0 7 7 189 0 8 7 193 0 216] 
#[1 2 130 0 7 2 130 0 8 7 197 0 217] 
#[0 2 242 0 12 1 14] 
#[0 2 246 0 12 1 14] 
#[0 7 201 1 1 1 15] 
#[0 2 250 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[1 7 205 0 6 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 7 209 0 83 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 7 213 0 163 7 217 0 212 0 229 0 215 0 233 0 218 0 42 1 15] 
#[0 7 221 0 7] 
#[1 7 225 0 7 5 161 0 8 5 165 0 161] 
#[0 7 229 1 1 1 15] 
#[1 7 233 0 17 7 233 0 166 1 66 1 15] 
#[0 7 237 0 149 0 249] 
#[1 0 70 0 7 0 70 0 8 7 241 0 162] 
#[0 2 254 0 12 1 14] 
#[1 7 245 0 17 7 245 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 7 249 0 165 0 50 1 15] 
#[1 3 2 0 7 3 2 0 8 7 253 0 57 8 1 0 97] 
#[0 8 5 0 7] 
#[0 8 9 0 149 0 250] 
#[0 8 13 0 6] 
#[1 5 33 0 6 5 41 0 149 8 17 0 204 5 41 0 250] 
#[0 8 21 0 6] 
#[1 1 86 0 6 3 5 0 137 8 25 0 172 5 153 0 205] 
#[1 1 86 0 6 3 5 0 137 8 29 0 172 5 153 0 205] 
#[0 8 33 0 6] 
#[0 8 37 1 2 1 15] 
#[1 8 41 0 6 8 45 0 149 8 45 0 252] 
#[1 8 49 0 6 3 5 0 137 8 53 0 205] 
#[1 0 62 0 6 0 62 0 137 8 57 0 149 8 57 0 171 8 57 0 252] 
#[1 0 62 0 6 0 62 0 137 8 61 0 149 8 61 0 171 8 61 0 252] 
#[1 1 86 0 6 3 5 0 137 8 65 0 172 5 153 0 205] 
#[1 3 6 0 7 3 6 0 8 8 69 0 174] 
#[0 8 73 0 149 0 250] 
#[0 8 77 0 7] 
#[1 8 81 0 7 8 85 0 8 8 89 0 168] 
#[0 8 97 0 147 0 255] 
#[0 3 10 0 7 0 8] 
#[0 3 14 0 7 0 8] 
#[1 2 154 0 7 2 154 0 8 8 101 0 169] 
#[1 5 33 0 6 5 41 0 149 8 105 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 8 109 0 169] 
#[1 5 33 0 6 5 41 0 149 8 113 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 8 117 0 169] 
#[1 8 121 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 8 125 0 169] 
#[1 2 154 0 7 2 154 0 8 8 129 0 169] 
#[1 5 33 0 6 5 41 0 149 8 133 0 204 5 41 0 250] 
#[1 8 137 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 8 141 0 169] 
#[1 2 154 0 7 2 154 0 8 8 145 0 169] 
#[1 5 33 0 6 5 41 0 149 8 149 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 8 153 0 169] 
#[1 5 33 0 6 5 41 0 149 8 157 0 204 5 41 0 250] 
#[1 8 161 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 8 165 0 169] 
#[1 5 33 0 6 5 41 0 149 8 169 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 8 173 0 169] 
#[1 5 33 0 6 5 41 0 149 8 177 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 8 181 0 169] 
#[0 8 185 0 6] 
#[0 8 189 0 6] 
#[1 5 33 0 6 5 41 0 149 8 193 0 204 5 41 0 250] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 8 197 0 165 0 50 1 15] 
#[1 3 18 0 12 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 8 201 0 163 8 205 0 218 3 18 1 14 0 42 1 15] 
#[1 3 22 0 12 0 58 0 17 0 58 0 71 0 58 0 110 3 22 1 14 0 58 1 15] 
#[0 3 26 0 7 0 8] 
#[1 0 11 0 7 0 15 0 8 3 30 0 17 3 30 0 20 8 217 0 28 8 221 0 29 3 30 0 30 3 30 0 32 3 30 0 34 3 30 0 35 3 30 0 40 3 30 0 47 3 30 0 59 3 30 0 68 3 30 0 76 3 30 0 79 3 30 0 97 3 30 0 98 3 30 0 99 3 30 0 106 3 30 0 109 3 30 0 113 3 30 0 121 3 30 0 135 3 30 0 142] 
#[0 3 34 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 8 225 1 2 1 15] 
#[1 8 229 0 17 8 233 0 68] 
#[0 8 237 1 2 1 15] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 8 241 0 177] 
#[0 8 245 0 17] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 8 249 0 47 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 8 253 0 177] 
#[1 9 1 0 6 1 57 0 42 9 5 0 98 9 5 0 146 9 5 0 148 9 5 0 251] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 9 9 0 179] 
#[1 9 13 0 6 1 57 0 42 9 17 0 98 9 17 0 146 9 17 0 148 9 17 0 251] 
#[0 3 38 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 59 0 79 0 106 0 109 0 113 0 121 0 135] 
#[0 3 42 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 59 0 79 0 106 0 109 0 113 0 121 0 135] 
#[0 3 46 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 59 0 79 0 106 0 109 0 113 0 121 0 135] 
#[1 3 50 0 7 3 50 0 8 9 25 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 9 25 0 180] 
#[1 9 29 0 7 9 33 0 8] 
#[1 9 37 0 13 9 41 0 152 9 41 0 254] 
#[0 9 45 0 152 0 254] 
#[1 3 54 0 7 3 54 0 8 3 54 0 17 3 54 0 20 3 54 0 30 0 19 0 32 3 54 0 34 3 54 0 35 3 54 0 40 3 54 0 47 3 54 0 59 3 54 0 68 3 54 0 76 3 54 0 79 3 54 0 97 3 54 0 98 3 54 0 99 3 54 0 106 3 54 0 109 3 54 0 113 3 54 0 121 3 54 0 135 3 54 0 142] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 5 229 0 200 9 53 0 201] 
#[0 3 58 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 3 62 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 3 66 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 9 57 0 7] 
#[0 9 61 1 2 1 15] 
#[0 9 65 0 7] 
#[1 9 69 0 149 9 69 0 250 9 73 1 6] 
#[0 9 77 0 7] 
#[1 9 69 0 149 9 69 0 250 9 81 1 6] 
#[0 9 85 0 13] 
#[0 3 70 0 6] 
#[0 9 89 0 6] 
#[0 3 74 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 9 93 0 149 0 249] 
#[0 3 78 0 7 0 8] 
#[1 9 97 0 7 7 189 0 8 7 193 0 216] 
#[0 3 82 0 12 1 14] 
#[1 0 253 0 30 1 1 0 40 1 5 0 65 1 9 0 67 1 13 0 73 1 17 0 79 9 101 0 83 1 25 0 106 1 29 0 117 1 33 0 135 1 49 0 149 9 105 0 167 1 45 0 207 1 49 0 250] 
#[0 9 109 0 149 0 249] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 9 113 0 165 0 50 1 15] 
#[1 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 9 117 0 163 0 233 0 218 0 42 1 15] 
#[0 3 86 0 12 1 14] 
#[1 3 90 0 12 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 9 121 0 163 9 125 0 212 0 229 0 215 9 129 0 218 3 90 1 14 0 42 1 15] 
#[0 3 94 0 12 1 14] 
#[0 9 133 1 1 1 15] 
#[0 9 137 0 7] 
#[1 9 141 0 7 5 161 0 8 5 165 0 161] 
#[0 9 145 1 1 1 15] 
#[1 9 149 0 17 9 149 0 166 1 66 1 15] 
#[0 3 98 0 7 0 8] 
#[0 9 153 0 57] 
#[1 3 102 0 7 3 102 0 8 9 157 0 57 9 161 0 97] 
#[1 3 6 0 7 3 6 0 8 9 165 0 174] 
#[0 9 169 0 149 0 250] 
#[1 2 154 0 7 2 154 0 8 9 173 0 169] 
#[1 5 33 0 6 5 41 0 149 9 177 0 204 5 41 0 250] 
#[0 9 181 0 6] 
#[0 9 185 0 6] 
#[1 5 33 0 6 5 41 0 149 9 189 0 204 5 41 0 250] 
#[0 9 193 0 7] 
#[0 9 197 0 149 0 250] 
#[0 9 201 0 6] 
#[1 5 33 0 6 5 41 0 149 9 205 0 204 5 41 0 250] 
#[0 9 209 0 6] 
#[1 1 86 0 6 3 5 0 137 9 213 0 172 5 153 0 205] 
#[1 1 86 0 6 3 5 0 137 9 217 0 172 5 153 0 205] 
#[0 9 221 0 6] 
#[1 9 225 0 7 9 229 0 8 9 233 0 173] 
#[1 3 6 0 7 3 6 0 8 9 237 0 174] 
#[1 3 106 0 7 3 106 0 8 9 241 0 18 9 245 0 50] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 21 0 170 10 25 0 205 10 21 0 206] 
#[1 5 33 0 6 5 41 0 149 10 33 0 204 5 41 0 250] 
#[0 3 114 0 7 0 8] 
#[0 3 118 0 7] 
#[0 10 37 0 7] 
#[1 10 41 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 10 45 0 169] 
#[1 10 49 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 10 53 0 169] 
#[1 10 57 0 7 8 85 0 8 8 89 0 168] 
#[1 3 122 0 7 3 122 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 10 61 0 206] 
#[1 10 65 0 7 8 85 0 8 8 89 0 168] 
#[1 10 69 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 10 73 0 169] 
#[1 3 126 0 7 3 126 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 10 77 0 206] 
#[1 10 81 0 7 8 85 0 8 8 89 0 168] 
#[1 10 85 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 10 89 0 169] 
#[1 10 93 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 10 97 0 169] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 101 0 170 10 25 0 205 10 101 0 206] 
#[1 10 105 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 10 109 0 169] 
#[1 10 113 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 10 117 0 169] 
#[1 10 121 0 7 8 85 0 8 8 89 0 168] 
#[1 5 33 0 6 5 41 0 149 10 125 0 204 5 41 0 250] 
#[1 5 33 0 6 5 41 0 149 10 129 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 10 133 0 169] 
#[1 10 137 0 17 10 137 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 10 141 0 165 0 50 1 15] 
#[1 3 130 0 12 0 58 0 17 0 58 0 71 0 58 0 110 3 130 1 14 0 58 1 15] 
#[1 3 134 0 7 3 134 0 8 3 134 0 17 3 134 0 20 10 145 0 28 10 149 0 29 3 134 0 30 3 134 0 32 3 134 0 34 3 134 0 35 3 134 0 40 3 134 0 47 3 134 0 59 3 134 0 68 3 134 0 76 3 134 0 79 3 134 0 97 3 134 0 98 3 134 0 99 3 134 0 106 3 134 0 109 3 134 0 113 3 134 0 121 3 134 0 135 3 134 0 142] 
#[1 1 57 0 42 10 153 0 98 10 153 0 146 10 153 0 148 10 153 0 251] 
#[0 10 157 0 114] 
#[1 10 161 0 13 10 165 0 152 10 165 0 254] 
#[0 10 169 0 7] 
#[0 10 173 0 6] 
#[0 10 177 0 16] 
#[0 10 181 0 7] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 10 185 0 179] 
#[0 10 189 0 6] 
#[1 10 193 0 6 1 57 0 42 10 197 0 98 10 197 0 146 10 197 0 148 10 197 0 251] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 10 201 0 179] 
#[0 10 205 1 2 1 15] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 10 209 0 177] 
#[1 3 50 0 7 3 50 0 8 10 213 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 10 213 0 180] 
#[0 10 217 1 2 1 15] 
#[0 3 138 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 59 0 76 0 79 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 3 142 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 59 0 79 0 106 0 109 0 113 0 121 0 135] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 10 229 0 182] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 10 233 0 144 10 237 0 145 5 229 0 200 10 241 0 201] 
#[0 10 245 0 147] 
#[0 10 249 0 152 0 254] 
#[1 3 150 0 7 3 150 0 8 3 150 0 17 3 150 0 20 3 150 0 30 0 23 0 32 3 150 0 34 3 150 0 35 3 150 0 40 3 150 0 47 3 150 0 59 3 150 0 68 3 150 0 76 3 150 0 79 3 150 0 97 3 150 0 98 3 150 0 99 3 150 0 106 3 150 0 109 3 150 0 113 3 150 0 121 3 150 0 135 3 150 0 142] 
#[1 3 154 0 7 3 154 0 8 3 154 0 17 3 154 0 20 3 154 0 30 0 27 0 32 3 154 0 34 3 154 0 35 3 154 0 40 3 154 0 47 3 154 0 59 3 154 0 68 3 154 0 76 3 154 0 79 3 154 0 97 3 154 0 98 3 154 0 99 3 154 0 106 3 154 0 109 3 154 0 113 3 154 0 121 3 154 0 135 3 154 0 142] 
#[0 11 5 0 146 0 152 1 0] 
#[0 3 158 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 3 162 0 12 0 17 0 71 0 110 1 14 1 15] 
#[0 11 9 0 7] 
#[1 11 13 0 104 3 166 0 123 11 17 0 222 11 21 0 223] 
#[0 11 25 0 8] 
#[0 11 29 0 7] 
#[0 3 170 0 12 0 17 0 71 0 110 1 14 1 15] 
#[0 11 33 0 7] 
#[1 11 37 0 10 11 41 0 11] 
#[1 9 69 0 149 9 69 0 250 11 45 1 6] 
#[0 3 174 0 7 0 8] 
#[0 3 178 0 8 0 12 0 17 0 19 0 20 0 21 0 28 0 29 0 31 0 32 0 35 0 38 0 39 0 43 0 47 0 48 0 56 0 58 0 59 0 71 0 73 0 74 0 80 0 90 0 94 0 100 0 103 0 105 0 110 0 112 0 113 0 118 0 119 0 120 0 126 0 134 1 14 1 15] 
#[0 11 49 0 149 0 249] 
#[1 0 70 0 7 0 70 0 8 11 53 0 162] 
#[0 3 182 0 12 1 14] 
#[1 11 57 0 17 11 57 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 11 61 0 165 0 50 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 11 65 0 165 0 50 1 15] 
#[1 3 186 0 12 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 11 69 0 163 11 73 0 218 3 186 1 14 0 42 1 15] 
#[1 3 190 0 12 0 58 0 17 0 58 0 71 0 58 0 110 3 190 1 14 0 58 1 15] 
#[0 3 194 0 12 1 14] 
#[0 3 198 0 12 1 14] 
#[1 3 202 0 12 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 11 77 0 163 11 81 0 212 0 229 0 215 11 85 0 218 3 202 1 14 0 42 1 15] 
#[0 3 206 0 12 1 14] 
#[0 11 89 1 1 1 15] 
#[0 3 210 0 7 0 8] 
#[0 3 214 0 7 0 8] 
#[0 11 93 0 57] 
#[1 11 97 0 7 9 229 0 8 9 233 0 173] 
#[1 3 6 0 7 3 6 0 8 11 101 0 174] 
#[1 11 105 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 11 109 0 169] 
#[1 5 33 0 6 5 41 0 149 11 113 0 204 5 41 0 250] 
#[1 5 33 0 6 5 41 0 149 11 117 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 11 121 0 169] 
#[1 3 218 0 7 3 218 0 8 11 125 0 57 11 129 0 97] 
#[1 3 6 0 7 3 6 0 8 11 133 0 174] 
#[0 11 137 0 149 0 250] 
#[1 2 154 0 7 2 154 0 8 11 141 0 169] 
#[1 5 33 0 6 5 41 0 149 11 145 0 204 5 41 0 250] 
#[0 11 149 0 6] 
#[0 11 153 0 6] 
#[1 5 33 0 6 5 41 0 149 11 157 0 204 5 41 0 250] 
#[1 11 161 0 109 11 165 0 208] 
#[0 11 169 0 149 0 250] 
#[0 3 222 0 7 0 8] 
#[1 11 173 0 7 9 229 0 8 9 233 0 173] 
#[0 3 226 0 7 0 8] 
#[0 3 230 0 7 0 8] 
#[0 11 177 0 146] 
#[1 11 181 0 13 11 185 0 146] 
#[0 3 234 0 7 0 8] 
#[1 11 189 0 13 1 57 0 42 11 193 0 98 11 193 0 146 11 193 0 148 11 193 0 251 11 193 1 13 11 193 1 15] 
#[1 11 197 0 13 11 201 0 146] 
#[0 3 238 0 7 0 8] 
#[0 11 205 0 101] 
#[0 3 242 0 7 0 8] 
#[0 3 246 0 7 0 8] 
#[0 3 250 0 7 0 8] 
#[0 3 254 0 7 0 8] 
#[1 4 2 0 7 4 2 0 8 11 209 0 18 11 213 0 50] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 11 217 0 170 10 25 0 205 11 217 0 206] 
#[1 11 221 0 7 8 85 0 8 8 89 0 168] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 11 225 0 170 10 25 0 205 11 225 0 206] 
#[1 11 229 0 7 8 85 0 8 8 89 0 168] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 11 233 0 170 10 25 0 205 11 233 0 206] 
#[0 4 6 0 7 0 8] 
#[1 4 10 0 7 4 10 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 11 237 0 206] 
#[1 4 14 0 7 4 14 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 11 241 0 206] 
#[1 11 245 0 7 8 85 0 8 8 89 0 168] 
#[0 4 18 0 7 0 8] 
#[1 4 22 0 7 4 22 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 11 249 0 206] 
#[1 4 26 0 7 4 26 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 11 253 0 206] 
#[1 12 1 0 7 8 85 0 8 8 89 0 168] 
#[1 4 30 0 7 4 30 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 12 5 0 206] 
#[1 12 9 0 7 8 85 0 8 8 89 0 168] 
#[0 4 34 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 12 13 0 170 10 25 0 205 12 13 0 206] 
#[1 12 17 0 7 8 85 0 8 8 89 0 168] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 12 21 0 170 10 25 0 205 12 21 0 206] 
#[1 12 25 0 7 8 85 0 8 8 89 0 168] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 12 29 0 170 10 25 0 205 12 29 0 206] 
#[1 2 154 0 7 2 154 0 8 12 33 0 169] 
#[1 2 154 0 7 2 154 0 8 12 37 0 169] 
#[1 12 41 0 7 8 85 0 8 8 89 0 168] 
#[0 12 45 1 1 1 15] 
#[1 12 49 0 17 12 49 0 166 1 66 1 15] 
#[0 12 53 0 114] 
#[1 12 57 0 13 12 61 0 152 12 61 0 254] 
#[0 4 38 0 7 0 8 0 17 0 20 0 28 0 29 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 12 65 0 13 12 69 0 152 12 69 0 254] 
#[0 12 73 0 152 0 254] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 12 85 0 188] 
#[1 12 89 0 122 12 93 0 141] 
#[0 12 97 1 2 1 15] 
#[0 12 101 0 17] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 12 105 0 177] 
#[1 3 50 0 7 3 50 0 8 12 109 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 12 109 0 180] 
#[0 12 113 1 2 1 15] 
#[0 12 117 1 2 1 15] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 12 121 0 177] 
#[1 3 50 0 7 3 50 0 8 12 125 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 12 125 0 180] 
#[0 12 129 0 7] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 12 133 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 12 137 0 182] 
#[0 12 141 0 7] 
#[1 4 46 0 7 4 46 0 8 4 46 0 30 4 46 0 32 4 46 0 34 4 46 0 35 4 46 0 40 4 46 0 59 0 35 0 79 4 46 0 106 4 46 0 109 4 46 0 113 4 46 0 121] 
#[0 4 50 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 59 0 79 0 106 0 109 0 113 0 121] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 12 161 0 184] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 12 165 0 145 5 229 0 200 12 169 0 201] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 5 229 0 200 12 173 0 201] 
#[0 4 58 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 12 177 0 7] 
#[1 4 62 0 7 4 62 0 8 4 62 0 17 4 62 0 20 4 62 0 30 0 39 0 32 4 62 0 34 4 62 0 35 4 62 0 40 4 62 0 47 4 62 0 59 4 62 0 68 4 62 0 76 4 62 0 79 4 62 0 97 4 62 0 98 4 62 0 99 4 62 0 106 4 62 0 109 4 62 0 113 4 62 0 121 4 62 0 135 4 62 0 142] 
#[0 12 185 0 146 0 152 1 0] 
#[0 12 189 0 146 0 152 1 0] 
#[0 4 66 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 4 70 0 12 0 17 0 71 0 110 1 14 1 15] 
#[0 12 197 0 147 1 10] 
#[0 4 74 0 123] 
#[0 12 201 0 123] 
#[0 12 205 0 149 0 250] 
#[1 11 13 0 104 3 166 0 123 11 17 0 222 12 209 0 223] 
#[0 4 78 0 12 0 17 0 71 0 110 1 14 1 15] 
#[0 4 82 0 6] 
#[0 4 86 0 6] 
#[0 12 213 0 7] 
#[0 12 217 0 7] 
#[1 12 221 0 7 5 161 0 8 5 165 0 161] 
#[0 12 225 1 1 1 15] 
#[1 12 229 0 17 12 229 0 166 1 66 1 15] 
#[1 12 233 0 17 12 233 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 12 237 0 165 0 50 1 15] 
#[1 4 90 0 12 0 58 0 17 0 58 0 71 0 58 0 110 4 90 1 14 0 58 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 12 241 0 165 0 50 1 15] 
#[1 4 94 0 12 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 12 245 0 163 12 249 0 218 4 94 1 14 0 42 1 15] 
#[1 4 98 0 12 0 58 0 17 0 58 0 71 0 58 0 110 4 98 1 14 0 58 1 15] 
#[0 4 102 0 12 1 14] 
#[0 4 106 0 7 0 8] 
#[1 11 161 0 109 12 253 0 208] 
#[1 13 1 0 7 9 229 0 8 9 233 0 173] 
#[1 4 110 0 7 4 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 13 5 0 206] 
#[1 13 9 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 13 13 0 169] 
#[1 2 154 0 7 2 154 0 8 13 17 0 169] 
#[1 13 21 0 7 8 85 0 8 8 89 0 168] 
#[0 4 114 0 7 0 8] 
#[0 13 25 0 57] 
#[1 13 29 0 7 9 229 0 8 9 233 0 173] 
#[1 3 6 0 7 3 6 0 8 13 33 0 174] 
#[1 13 37 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 13 41 0 169] 
#[1 5 33 0 6 5 41 0 149 13 45 0 204 5 41 0 250] 
#[1 5 33 0 6 5 41 0 149 13 49 0 204 5 41 0 250] 
#[1 2 154 0 7 2 154 0 8 13 53 0 169] 
#[0 13 57 0 149 0 249] 
#[0 4 118 0 7 0 8] 
#[0 4 122 0 7 0 8] 
#[1 11 161 0 109 13 61 0 208] 
#[0 4 126 0 7 0 8] 
#[0 13 65 0 146] 
#[0 4 130 0 7 0 8] 
#[1 1 57 0 42 13 69 0 98 13 69 0 146 13 69 0 148 13 69 0 251 13 69 1 13 13 69 1 15] 
#[0 4 134 0 7 0 8] 
#[0 13 73 0 146] 
#[0 4 138 0 7 0 8] 
#[0 13 81 0 152 1 8] 
#[0 4 142 0 7 0 8] 
#[0 4 146 0 7 0 8] 
#[0 4 150 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 13 85 0 170 10 25 0 205 13 85 0 206] 
#[0 4 154 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 13 89 0 170 10 25 0 205 13 89 0 206] 
#[0 4 158 0 7 0 8] 
#[0 4 162 0 7 0 8] 
#[0 4 166 0 7 0 8] 
#[1 4 170 0 7 4 170 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 13 93 0 206] 
#[0 4 174 0 7 0 8] 
#[0 4 178 0 7 0 8] 
#[1 4 182 0 7 4 182 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 13 97 0 206] 
#[0 4 186 0 7 0 8] 
#[1 4 190 0 7 4 190 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 13 101 0 206] 
#[0 4 194 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 13 105 0 170 10 25 0 205 13 105 0 206] 
#[0 4 198 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 13 109 0 170 10 25 0 205 13 109 0 206] 
#[0 4 202 0 7 0 8] 
#[1 13 113 0 7 8 85 0 8 8 89 0 168] 
#[1 13 117 0 7 8 85 0 8 8 89 0 168] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 13 121 0 170 10 25 0 205 13 121 0 206] 
#[0 4 206 0 12 1 14] 
#[0 13 125 1 1 1 15] 
#[1 13 129 0 13 13 133 0 152 13 133 0 254] 
#[0 13 137 0 152 0 254] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 13 141 0 188] 
#[0 13 145 0 152 0 254] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 13 149 0 188] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 13 153 0 188] 
#[0 13 157 0 146 0 152 1 0] 
#[0 4 210 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 4 214 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 13 161 0 97 13 165 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 13 169 0 179] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 13 173 0 97 13 177 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 13 181 0 179] 
#[0 13 185 0 7] 
#[0 13 189 0 6] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 13 193 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 13 197 0 182] 
#[0 13 201 0 7] 
#[0 13 205 0 7] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 13 209 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 13 213 0 182] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 13 217 0 177] 
#[1 3 50 0 7 3 50 0 8 13 221 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 13 221 0 180] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 13 225 0 184] 
#[0 4 218 0 7 0 8 0 20 0 30 0 32 0 34 0 35 0 40 0 59 0 76 0 79 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 4 222 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 59 0 79 0 106 0 109 0 113 0 121] 
#[0 4 226 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 59 0 109 0 113 0 121] 
#[0 13 229 0 79] 
#[0 4 230 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 59 0 109 0 113 0 121] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 13 241 0 185 13 241 0 186] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 5 229 0 200 13 245 0 201] 
#[0 4 238 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 4 242 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 13 249 0 144 13 253 0 145 5 229 0 200 14 1 0 201] 
#[0 14 5 0 146 0 152 1 0] 
#[0 4 246 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 4 250 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 4 254 0 6 0 123] 
#[0 5 2 0 123] 
#[0 14 9 0 25] 
#[0 5 6 0 7] 
#[0 14 13 0 123] 
#[0 5 10 0 12 0 17 0 71 0 110 1 14 1 15] 
#[0 5 14 0 12 1 14] 
#[1 5 18 0 12 0 42 0 17 0 93 0 19 0 97 0 20 0 101 0 21 0 105 0 28 0 109 0 29 0 113 0 31 0 117 0 32 0 121 0 35 0 125 0 38 0 129 0 39 0 133 0 43 0 137 0 47 0 141 0 48 0 145 0 56 0 149 0 58 0 153 0 59 0 42 0 71 0 157 0 73 0 161 0 74 0 165 0 80 0 173 0 90 0 177 0 94 0 181 0 100 0 185 0 103 0 189 0 105 0 42 0 110 0 193 0 112 0 197 0 113 0 201 0 118 0 205 0 119 0 209 0 120 0 213 0 126 0 217 0 134 14 17 0 163 14 21 0 212 0 229 0 215 14 25 0 218 5 18 1 14 0 42 1 15] 
#[0 5 22 0 12 1 14] 
#[0 14 29 1 1 1 15] 
#[0 14 33 1 1 1 15] 
#[1 14 37 0 17 14 37 0 166 1 66 1 15] 
#[1 14 41 0 17 14 41 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 14 45 0 165 0 50 1 15] 
#[1 5 26 0 12 0 58 0 17 0 58 0 71 0 58 0 110 5 26 1 14 0 58 1 15] 
#[0 5 30 0 7 0 8] 
#[1 11 161 0 109 14 49 0 208] 
#[0 5 34 0 7 0 8] 
#[1 5 38 0 7 5 38 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 14 53 0 206] 
#[1 14 57 0 7 8 85 0 8 8 89 0 168] 
#[1 14 61 0 7 8 85 0 8 8 89 0 168] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 14 65 0 170 10 25 0 205 14 65 0 206] 
#[0 5 42 0 7 0 8] 
#[1 11 161 0 109 14 69 0 208] 
#[1 14 73 0 7 9 229 0 8 9 233 0 173] 
#[1 5 46 0 7 5 46 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 14 77 0 206] 
#[1 14 81 0 7 8 85 0 8 8 89 0 168] 
#[1 2 154 0 7 2 154 0 8 14 85 0 169] 
#[1 2 154 0 7 2 154 0 8 14 89 0 169] 
#[1 14 93 0 7 8 85 0 8 8 89 0 168] 
#[0 14 97 0 6] 
#[0 5 50 0 7 0 8] 
#[0 5 54 0 7 0 8] 
#[0 5 58 0 7 0 8] 
#[0 5 62 0 7 0 8] 
#[0 5 66 0 7 0 8] 
#[0 5 70 0 7 0 8] 
#[0 5 74 0 7 0 8] 
#[0 5 78 0 7 0 8] 
#[0 5 82 0 7 0 8] 
#[0 5 86 0 7 0 8] 
#[0 5 90 0 7 0 8] 
#[0 5 94 0 7 0 8] 
#[0 5 98 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 14 101 0 170 10 25 0 205 14 101 0 206] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 14 105 0 170 10 25 0 205 14 105 0 206] 
#[0 5 102 0 7 0 8] 
#[0 5 106 0 12 1 14] 
#[0 14 109 0 152 0 254] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 14 113 0 188] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 14 117 0 188] 
#[0 5 110 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 14 121 0 188] 
#[0 5 114 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 5 118 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 5 122 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 14 125 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 14 129 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 14 133 0 182] 
#[0 14 137 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 14 141 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 14 145 0 182] 
#[1 14 149 0 122 14 153 0 141] 
#[0 14 157 1 2 1 15] 
#[1 3 50 0 7 3 50 0 8 14 161 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 14 161 0 180] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 14 165 0 184] 
#[1 14 169 0 122 14 173 0 141] 
#[1 1 186 0 7 1 186 0 8 1 186 0 20 1 186 0 30 1 186 0 32 1 186 0 34 1 186 0 35 1 186 0 40 1 186 0 59 1 186 0 76 1 186 0 79 5 197 0 99 1 186 0 106 1 186 0 109 1 186 0 113 1 186 0 121 1 186 0 135 1 186 0 142 5 201 0 176 14 177 0 177] 
#[1 3 50 0 7 3 50 0 8 14 181 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 14 181 0 180] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 14 185 0 184] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 14 189 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 14 193 0 182] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 14 197 0 185 14 197 0 186] 
#[0 5 126 0 7 0 8 0 30 0 32 0 34 0 35 0 40 0 59 0 109 0 113 0 121] 
#[0 14 201 0 146] 
#[0 5 130 0 7 0 8 0 30 0 32 0 34 0 40 0 59 0 109 0 113 0 121] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 14 205 0 188] 
#[0 5 134 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 14 209 0 145 5 229 0 200 14 213 0 201] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 5 229 0 200 14 217 0 201] 
#[0 5 138 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 5 142 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 0 238 0 69 14 221 0 84 14 225 0 219] 
#[0 14 229 0 25] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 14 233 0 165 0 50 1 15] 
#[1 5 146 0 12 0 42 0 17 0 42 0 71 0 185 0 103 0 42 0 110 14 237 0 163 14 241 0 218 5 146 1 14 0 42 1 15] 
#[1 5 150 0 12 0 58 0 17 0 58 0 71 0 58 0 110 5 150 1 14 0 58 1 15] 
#[0 5 154 0 12 1 14] 
#[0 5 158 0 12 1 14] 
#[0 14 245 1 1 1 15] 
#[0 14 249 1 1 1 15] 
#[1 14 253 0 17 14 253 0 166 1 66 1 15] 
#[0 5 162 0 7 0 8] 
#[0 5 166 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 15 1 0 170 10 25 0 205 15 1 0 206] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 15 5 0 170 10 25 0 205 15 5 0 206] 
#[0 5 170 0 7 0 8] 
#[0 5 174 0 7 0 8] 
#[1 11 161 0 109 15 9 0 208] 
#[0 5 178 0 7 0 8] 
#[1 5 182 0 7 5 182 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 10 25 0 205 15 13 0 206] 
#[1 15 17 0 7 8 85 0 8 8 89 0 168] 
#[1 15 21 0 7 8 85 0 8 8 89 0 168] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 15 25 0 170 10 25 0 205 15 25 0 206] 
#[1 5 33 0 6 5 41 0 149 15 29 0 204 5 41 0 250] 
#[0 5 186 0 7 0 8] 
#[0 5 190 0 7 0 8] 
#[1 4 42 0 7 4 42 0 8 4 42 0 17 4 42 0 20 4 42 0 30 0 31 0 32 4 42 0 34 4 42 0 35 4 42 0 40 4 42 0 47 4 42 0 59 4 42 0 68 4 42 0 76 4 42 0 79 4 42 0 97 4 42 0 98 4 42 0 99 4 42 0 106 4 42 0 109 4 42 0 113 4 42 0 121 4 42 0 135 4 42 0 142 12 81 0 187 15 33 0 188] 
#[0 5 194 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 5 198 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 5 202 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 37 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 15 41 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 15 45 0 184] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 49 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 15 53 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 15 57 0 184] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 15 61 0 97 15 65 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 69 0 179] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 15 73 0 97 15 77 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 81 0 179] 
#[0 15 85 0 7] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 15 89 0 182] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 15 93 0 185 15 93 0 186] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 15 97 0 97 15 101 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 105 0 179] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 15 109 0 97 15 113 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 117 0 179] 
#[1 2 190 0 7 2 190 0 8 2 190 0 20 2 190 0 30 2 190 0 32 2 190 0 34 2 190 0 35 2 190 0 40 2 190 0 59 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 113 2 190 0 121 2 190 0 135 7 105 0 142 7 109 0 178 15 121 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 15 125 0 182] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 15 129 0 185 15 129 0 186] 
#[1 3 50 0 7 3 50 0 8 15 133 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 15 133 0 180] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 15 137 0 184] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 15 141 0 188] 
#[0 5 206 0 7 0 8 0 30 0 32 0 34 0 40 0 59 0 109 0 113 0 121] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 15 153 0 190] 
#[1 1 190 0 7 1 190 0 8 1 190 0 17 1 190 0 20 5 213 0 28 5 217 0 29 1 190 0 30 1 190 0 32 1 190 0 34 1 190 0 35 1 190 0 40 1 190 0 47 1 190 0 59 1 190 0 68 1 190 0 76 1 190 0 79 1 190 0 97 1 190 0 98 1 190 0 99 1 190 0 106 1 190 0 109 1 190 0 113 1 190 0 121 1 190 0 135 1 190 0 142 5 229 0 200 15 157 0 201] 
#[0 5 214 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[0 5 218 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 2 66 0 69 15 161 0 79] 
#[0 15 165 0 69] 
#[1 0 238 0 69 15 169 0 84 15 173 0 219] 
#[1 15 177 0 17 15 177 0 166 1 66 1 15] 
#[1 0 50 0 17 2 153 0 71 2 157 0 110 2 161 0 164 15 181 0 165 0 50 1 15] 
#[1 5 222 0 12 0 58 0 17 0 58 0 71 0 58 0 110 5 222 1 14 0 58 1 15] 
#[0 5 226 0 12 1 14] 
#[0 5 230 0 12 1 14] 
#[0 15 185 1 1 1 15] 
#[0 5 234 0 7 0 8] 
#[0 5 238 0 7 0 8] 
#[0 5 242 0 7 0 8] 
#[0 5 246 0 7 0 8] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 15 189 0 170 10 25 0 205 15 189 0 206] 
#[1 3 110 0 7 3 110 0 8 9 249 0 35 9 253 0 59 10 1 0 76 10 5 0 80 10 9 0 113 3 5 0 137 10 13 0 142 10 17 0 143 15 193 0 170 10 25 0 205 15 193 0 206] 
#[0 5 250 0 7 0 8] 
#[1 2 154 0 7 2 154 0 8 15 197 0 169] 
#[0 5 254 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 15 201 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 15 205 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 15 209 0 185 15 209 0 186] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 15 213 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 15 217 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 15 221 0 185 15 221 0 186] 
#[0 15 225 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 229 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 15 233 0 182] 
#[0 15 237 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 15 241 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 15 245 0 182] 
#[1 15 249 0 122 15 253 0 141] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 16 1 0 184] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 16 5 0 188] 
#[0 16 9 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 13 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 16 17 0 182] 
#[0 16 21 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 25 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 16 29 0 182] 
#[1 3 50 0 7 3 50 0 8 16 33 0 20 3 50 0 30 3 50 0 32 3 50 0 34 3 50 0 35 3 50 0 40 3 50 0 59 3 50 0 79 3 50 0 106 3 50 0 109 3 50 0 113 3 50 0 121 3 50 0 135 16 33 0 180] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 16 37 0 184] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 16 41 0 188] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 16 45 0 182] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 16 49 0 185 16 49 0 186] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 16 53 0 190] 
#[1 16 57 0 47 16 61 0 55 16 65 0 63] 
#[0 6 2 0 7 0 8 0 30 0 40 0 59 0 109 0 113 0 121] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 16 77 0 192] 
#[0 6 10 0 7 0 8 0 17 0 20 0 30 0 32 0 34 0 35 0 40 0 47 0 59 0 68 0 76 0 79 0 97 0 98 0 99 0 106 0 109 0 113 0 121 0 135 0 142] 
#[1 2 230 0 6 7 173 0 15 7 177 0 220 16 81 0 221] 
#[0 16 85 0 6] 
#[1 2 66 0 69 16 89 0 79] 
#[0 16 93 0 69] 
#[0 16 97 1 1 1 15] 
#[1 16 101 0 17 16 101 0 166 1 66 1 15] 
#[0 6 14 0 12 1 14] 
#[0 6 18 0 7 0 8] 
#[0 6 22 0 7 0 8] 
#[1 16 105 0 7 8 85 0 8 8 89 0 168] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 16 109 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 16 113 0 185 16 113 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 16 117 0 197 16 121 0 208] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 16 125 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 16 129 0 185 16 129 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 16 133 0 197 16 121 0 208] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 137 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 16 141 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 16 145 0 184] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 149 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 16 153 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 16 157 0 184] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 16 161 0 97 16 165 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 169 0 179] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 16 173 0 97 16 177 0 98 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 181 0 179] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 16 185 0 185 16 185 0 186] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 16 189 0 190] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 193 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 16 197 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 16 201 0 184] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 16 205 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 16 209 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 16 213 0 184] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 32 3 146 0 34 3 146 0 35 3 146 0 40 3 146 0 59 3 146 0 79 3 146 0 106 3 146 0 109 3 146 0 113 3 146 0 121 10 221 0 135 10 225 0 181 16 217 0 182] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 16 221 0 185 16 221 0 186] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 16 225 0 190] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 16 229 0 184] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 16 233 0 188] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 16 237 0 192] 
#[0 6 30 0 7 0 8 0 30 0 40 0 59 0 109 0 113 0 121] 
#[0 6 34 0 7 0 8 0 30 0 40 0 59 0 109 0 113 0 121] 
#[0 6 38 0 7 0 8 0 30 0 40 0 59 0 109 0 113 0 121] 
#[1 16 241 0 13 16 245 0 146] 
#[0 6 42 0 7 0 8 0 30 0 40 0 109 0 113 0 121] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 17 1 0 194] 
#[0 17 5 0 6] 
#[0 17 9 1 2 1 15] 
#[1 2 230 0 6 7 173 0 15 7 177 0 220 17 13 0 221] 
#[0 17 17 0 6] 
#[0 6 50 0 12 1 14] 
#[0 17 21 1 1 1 15] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 17 25 0 88 17 29 0 99 17 33 0 209 17 37 0 210] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 17 41 0 185 17 41 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 17 45 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 17 53 0 198 17 57 0 207] 
#[0 6 62 0 7 0 8 0 30 0 40] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 17 61 0 185 17 61 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 17 65 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 17 69 0 198 17 57 0 207] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 17 73 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 17 77 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 17 81 0 185 17 81 0 186] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 17 85 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 17 89 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 17 93 0 185 17 93 0 186] 
#[0 17 97 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 17 101 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 17 105 0 182] 
#[0 17 109 0 98] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 17 113 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 17 117 0 182] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 17 121 0 188] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 17 125 0 192] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 17 129 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 17 133 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 17 137 0 185 17 137 0 186] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 17 141 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 17 145 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 17 149 0 185 17 149 0 186] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 32 4 54 0 34 4 54 0 35 4 54 0 40 4 54 0 59 12 149 0 79 12 153 0 106 4 54 0 109 4 54 0 113 4 54 0 121 12 157 0 183 17 153 0 184] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 17 157 0 188] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 17 161 0 192] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 17 165 0 185 17 165 0 186] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 17 169 0 190] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 17 173 0 194] 
#[0 17 177 0 146] 
#[0 6 66 0 7 0 8 0 30 0 40 0 109 0 113 0 121] 
#[1 17 181 0 13 17 185 0 146] 
#[0 6 70 0 7 0 8 0 30 0 40 0 109 0 121] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 17 197 0 196] 
#[1 9 69 0 149 9 69 0 250 17 201 1 6] 
#[0 17 205 0 7] 
#[0 17 209 0 6] 
#[0 17 213 1 2 1 15] 
#[0 6 78 0 12 1 14] 
#[1 17 217 0 66 17 221 0 102 17 225 0 115] 
#[1 17 229 0 49 17 233 0 136] 
#[0 6 82 0 7 0 8 0 30 0 40] 
#[0 6 86 0 7 0 8 0 30 0 40] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 17 237 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 17 241 0 198 17 57 0 207] 
#[1 2 209 0 30 17 245 1 7 17 245 1 15] 
#[0 6 90 0 7 0 8] 
#[0 6 94 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 17 249 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 17 253 0 198 17 57 0 207] 
#[0 6 98 0 7 0 8] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 1 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 5 0 185 18 5 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 18 9 0 197 16 121 0 208] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 13 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 17 0 185 18 17 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 18 21 0 197 16 121 0 208] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 18 25 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 18 29 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 33 0 184] 
#[1 2 190 0 7 2 190 0 8 2 190 0 30 2 190 0 35 2 190 0 40 7 101 0 76 2 190 0 79 2 190 0 106 2 190 0 109 2 190 0 135 7 105 0 142 7 109 0 178 18 37 0 179] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 18 41 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 45 0 184] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 18 49 0 190] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 18 53 0 194] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 57 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 61 0 185 18 61 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 18 65 0 197 16 121 0 208] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 69 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 73 0 185 18 73 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 18 77 0 197 16 121 0 208] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 4 234 0 32 4 234 0 34 13 233 0 35 4 234 0 40 4 234 0 59 4 234 0 109 4 234 0 113 4 234 0 121 18 81 0 185 18 81 0 186] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 18 85 0 190] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 18 89 0 194] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 18 93 0 188] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 18 97 0 192] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 18 101 0 196] 
#[0 6 102 0 7 0 8 0 30 0 40 0 109 0 113 0 121] 
#[0 18 105 0 146] 
#[0 6 106 0 7 0 8 0 30 0 40 0 109 0 121] 
#[1 18 109 0 52 18 113 0 93] 
#[0 6 110 0 7 0 8 0 30 0 40 0 109] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 18 117 0 197 16 121 0 208] 
#[0 18 121 0 7] 
#[1 6 114 0 6 18 125 0 124 18 129 0 224 18 133 0 225] 
#[1 9 69 0 149 9 69 0 250 18 137 1 6] 
#[0 18 141 0 7] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 18 145 0 99 17 33 0 209 18 149 0 210] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 18 153 0 99 17 33 0 209 18 157 0 210] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 18 161 0 99 17 33 0 209 18 165 0 210] 
#[1 18 169 0 26 18 173 0 96 18 177 0 111 18 181 0 114 18 185 0 211] 
#[1 18 169 0 26 18 173 0 96 18 177 0 111 18 181 0 114 18 189 0 211] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 18 193 0 198 17 57 0 207] 
#[0 6 118 0 7 0 8] 
#[0 5 9 0 30] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 18 197 0 198 17 57 0 207] 
#[0 6 122 0 7 0 8] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 201 0 185 18 201 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 18 205 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 18 209 0 198 17 57 0 207] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 213 0 185 18 213 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 18 217 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 18 221 0 198 17 57 0 207] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 18 225 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 229 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 233 0 185 18 233 0 186] 
#[1 3 146 0 7 3 146 0 8 3 146 0 30 3 146 0 35 3 146 0 40 3 146 0 79 3 146 0 106 3 146 0 109 10 221 0 135 10 225 0 181 18 237 0 182] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 18 241 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 18 245 0 185 18 245 0 186] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 18 249 0 192] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 18 253 0 196] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 19 1 0 185 19 1 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 5 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 9 0 198 17 57 0 207] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 19 13 0 185 19 13 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 17 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 21 0 198 17 57 0 207] 
#[1 4 42 0 7 4 42 0 8 4 42 0 30 12 77 0 32 4 42 0 34 4 42 0 40 4 42 0 59 4 42 0 109 4 42 0 113 4 42 0 121 12 81 0 187 19 25 0 188] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 19 29 0 192] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 19 33 0 196] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 19 37 0 190] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 19 41 0 194] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 45 0 197 16 121 0 208] 
#[0 6 126 0 7 0 8 0 30 0 40 0 109 0 121] 
#[0 6 130 0 7 0 8 0 30 0 40 0 109] 
#[0 6 134 0 7 0 8 0 30 0 40 0 109] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 49 0 198 17 57 0 207] 
#[1 6 114 0 6 18 125 0 124 18 129 0 224 19 53 0 225] 
#[0 19 57 0 147 1 10] 
#[0 6 138 0 6] 
#[0 19 61 0 6] 
#[0 19 65 0 7] 
#[1 6 114 0 6 18 125 0 124 18 129 0 224 19 69 0 225] 
#[1 19 73 0 49 17 233 0 136] 
#[0 6 142 0 7 0 8 0 30 0 40] 
#[1 19 77 0 49 17 233 0 136] 
#[0 6 146 0 7 0 8 0 30 0 40] 
#[1 19 81 0 49 17 233 0 136] 
#[0 6 150 0 7 0 8 0 30 0 40] 
#[0 6 154 0 7 0 8 0 30 0 40 0 99] 
#[0 19 85 0 14] 
#[0 6 158 0 7 0 8 0 30 0 40 0 99] 
#[1 19 89 0 47 19 93 0 98] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 19 97 0 99 17 33 0 209 19 101 0 210] 
#[0 6 162 0 7 0 8 0 30 0 40] 
#[0 6 166 0 7 0 8] 
#[0 6 170 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 105 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 109 0 198 17 57 0 207] 
#[0 6 174 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 113 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 117 0 198 17 57 0 207] 
#[0 6 178 0 7 0 8] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 19 121 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 19 125 0 185 19 125 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 129 0 197 16 121 0 208] 
#[1 4 54 0 7 4 54 0 8 4 54 0 30 4 54 0 35 4 54 0 40 12 149 0 79 12 153 0 106 4 54 0 109 12 157 0 183 19 133 0 184] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 19 137 0 185 19 137 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 141 0 197 16 121 0 208] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 19 145 0 194] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 149 0 197 16 121 0 208] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 153 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 157 0 198 17 57 0 207] 
#[0 6 182 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 161 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 165 0 198 17 57 0 207] 
#[0 6 186 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 5 210 0 30 15 145 0 34 5 210 0 40 5 210 0 59 5 210 0 109 5 210 0 113 5 210 0 121 15 149 0 189 19 169 0 190] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 19 173 0 194] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 177 0 197 16 121 0 208] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 19 181 0 192] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 19 185 0 196] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 189 0 198 17 57 0 207] 
#[0 6 190 0 7 0 8] 
#[0 19 193 0 6] 
#[0 6 194 0 6] 
#[1 19 197 0 103 19 201 0 228] 
#[1 6 114 0 6 18 125 0 124 18 129 0 224 19 205 0 225] 
#[0 19 209 0 6] 
#[1 18 169 0 26 18 173 0 96 18 177 0 111 18 181 0 114 19 213 0 211] 
#[1 18 169 0 26 18 173 0 96 18 177 0 111 18 181 0 114 19 217 0 211] 
#[1 18 169 0 26 18 173 0 96 18 177 0 111 18 181 0 114 19 221 0 211] 
#[0 6 198 0 7 0 8 0 30 0 40 0 99] 
#[0 6 202 0 7 0 8 0 30 0 40 0 99] 
#[0 6 206 0 7 0 8 0 30 0 40 0 99] 
#[0 17 233 0 136] 
#[0 6 210 0 7 0 8 0 30 0 40] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 225 0 198 17 57 0 207] 
#[0 6 214 0 7 0 8] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 229 0 198 17 57 0 207] 
#[0 6 218 0 7 0 8] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 19 233 0 185 19 233 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 237 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 241 0 198 17 57 0 207] 
#[1 4 234 0 7 4 234 0 8 4 234 0 30 13 233 0 35 4 234 0 40 4 234 0 109 19 245 0 185 19 245 0 186] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 19 249 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 19 253 0 198 17 57 0 207] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 20 1 0 196] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 5 0 198 17 57 0 207] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 9 0 198 17 57 0 207] 
#[0 6 222 0 7 0 8] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 13 0 198 17 57 0 207] 
#[0 6 226 0 7 0 8] 
#[1 6 6 0 7 6 6 0 8 6 6 0 30 6 6 0 40 16 69 0 59 6 6 0 109 6 6 0 113 6 6 0 121 16 73 0 191 20 17 0 192] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 20 21 0 196] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 25 0 198 17 57 0 207] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 20 29 0 194] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 20 33 0 197 16 121 0 208] 
#[0 6 230 0 7 0 8] 
#[1 19 197 0 103 20 37 0 228] 
#[0 20 41 1 11 1 15] 
#[1 6 234 0 7 6 234 0 8 20 49 0 227] 
#[0 20 53 0 6] 
#[1 19 197 0 103 20 57 0 228] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 19 97 0 99 17 33 0 209 20 61 0 210] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 19 97 0 99 17 33 0 209 20 65 0 210] 
#[1 6 54 0 7 6 54 0 8 6 54 0 30 6 54 0 40 19 97 0 99 17 33 0 209 20 69 0 210] 
#[0 6 238 0 7 0 8] 
#[0 6 242 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 20 73 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 77 0 198 17 57 0 207] 
#[0 6 246 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 20 81 0 197 16 121 0 208] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 85 0 198 17 57 0 207] 
#[0 6 250 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 20 89 0 197 16 121 0 208] 
#[0 6 254 0 7 0 8] 
#[0 7 2 0 7 0 8] 
#[0 7 6 0 7 0 8] 
#[1 6 46 0 7 6 46 0 8 6 46 0 30 6 46 0 40 6 46 0 109 16 249 0 113 6 46 0 121 16 253 0 193 20 93 0 194] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 20 97 0 197 16 121 0 208] 
#[0 7 10 0 7 0 8] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 20 101 0 196] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 105 0 198 17 57 0 207] 
#[1 6 234 0 7 6 234 0 8 20 109 0 227] 
#[1 7 14 0 6 7 14 0 7 7 14 0 8 7 14 0 35 7 14 0 43 20 113 0 58 7 14 0 73 7 14 0 90 7 14 0 94 20 117 0 121 7 14 0 126 20 121 0 138 20 125 0 229 20 129 0 230] 
#[0 7 18 0 6 0 7 0 8 0 35 0 43 0 58 0 73 0 90 0 94 0 121 0 126 0 138] 
#[1 20 133 0 7 20 137 0 8 20 141 0 226] 
#[1 19 197 0 103 20 145 0 228] 
#[1 6 234 0 7 6 234 0 8 20 149 0 227] 
#[0 7 22 0 7 0 8 0 30 0 40] 
#[0 7 26 0 7 0 8 0 30 0 40] 
#[0 7 30 0 7 0 8 0 30 0 40] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 153 0 198 17 57 0 207] 
#[0 7 34 0 7 0 8] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 157 0 198 17 57 0 207] 
#[0 7 38 0 7 0 8] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 161 0 198 17 57 0 207] 
#[1 6 74 0 7 6 74 0 8 6 74 0 30 6 74 0 40 6 74 0 109 17 189 0 121 17 193 0 195 20 165 0 196] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 169 0 198 17 57 0 207] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 20 173 0 197 16 121 0 208] 
#[0 7 42 0 7 0 8] 
#[1 20 177 0 7 20 137 0 8 20 141 0 226] 
#[1 20 181 0 13 20 185 0 77 20 185 0 95 20 185 0 253] 
#[0 20 189 0 58] 
#[1 20 193 0 72 20 197 0 82] 
#[0 7 46 0 6 0 7 0 8 0 35 0 43 0 73 0 90 0 94 0 126] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 201 0 35 7 50 0 43 7 50 0 73 7 50 0 90 7 50 0 94 7 50 0 126 20 205 0 231 20 209 0 232] 
#[0 7 54 0 12 0 17 0 71 0 110 1 14 1 15] 
#[1 19 197 0 103 20 213 0 228] 
#[0 7 58 0 7 0 8] 
#[1 6 234 0 7 6 234 0 8 20 217 0 227] 
#[1 20 221 0 7 20 137 0 8 20 141 0 226] 
#[0 7 62 0 7 0 8] 
#[0 7 66 0 7 0 8] 
#[0 7 70 0 7 0 8] 
#[1 6 26 0 7 6 26 0 8 6 26 0 30 6 26 0 40 11 161 0 109 20 225 0 197 16 121 0 208] 
#[0 7 74 0 7 0 8] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 20 229 0 198 17 57 0 207] 
#[0 7 78 0 12 0 17 0 71 0 110 1 14 1 15] 
#[0 20 233 0 77 0 95 0 253] 
#[0 7 82 0 6 0 7 0 8 0 35 0 43 0 73 0 90 0 94 0 126] 
#[1 20 237 0 13 20 241 0 77 20 241 0 95 20 241 0 253] 
#[0 20 245 0 6] 
#[0 20 249 0 129] 
#[1 20 253 0 13 21 1 0 146] 
#[0 7 86 0 6 0 7 0 8 0 43 0 73 0 90 0 94 0 126] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 21 13 0 234] 
#[0 7 94 0 7 0 8] 
#[1 21 17 0 7 20 137 0 8 20 141 0 226] 
#[0 7 98 0 12 0 17 0 71 0 110 1 14 1 15] 
#[1 6 58 0 7 6 58 0 8 0 253 0 30 17 49 0 40 21 21 0 198 17 57 0 207] 
#[0 7 102 0 7 0 8] 
#[0 7 106 0 6 0 7 0 8 0 35 0 43 0 73 0 90 0 94 0 126] 
#[0 21 25 0 77 0 95 0 253] 
#[0 7 110 0 6 0 7 0 8 0 35 0 43 0 73 0 90 0 94 0 126] 
#[1 7 114 0 7 21 29 1 2 21 33 1 3 21 29 1 15] 
#[1 21 37 0 6 7 114 0 7 21 41 0 89 21 29 1 2 21 45 1 3 21 29 1 15] 
#[0 21 49 0 146] 
#[0 7 118 0 6 0 7 0 8 0 43 0 73 0 90 0 94 0 126] 
#[0 21 53 0 51] 
#[0 7 122 0 6 0 7 0 8 0 73 0 90 0 94 0 126] 
#[1 7 126 0 6 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 21 65 0 236] 
#[0 7 130 0 12 0 17 0 71 0 110 1 14 1 15] 
#[0 7 134 0 7 0 8] 
#[0 7 138 0 6 0 7 0 8 0 35 0 43 0 73 0 90 0 94 0 126] 
#[1 7 142 0 7 7 142 0 8 21 69 1 5] 
#[0 21 73 0 7] 
#[0 21 77 1 2 1 15] 
#[1 7 14 0 6 7 14 0 7 7 14 0 8 7 14 0 35 7 14 0 43 20 113 0 58 7 14 0 73 7 14 0 90 7 14 0 94 20 117 0 121 7 14 0 126 20 125 0 229 21 81 0 230] 
#[0 21 85 0 7] 
#[0 7 146 0 6 0 7 0 8 0 43 0 73 0 90 0 94 0 126] 
#[1 21 89 0 13 21 93 0 146] 
#[0 21 97 0 51] 
#[0 7 150 0 6 0 7 0 8 0 90 0 94 0 126] 
#[1 7 154 0 6 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 21 109 0 238] 
#[1 7 158 0 7 21 113 0 8 21 117 1 4] 
#[1 7 14 0 6 7 14 0 7 7 14 0 8 7 14 0 35 7 14 0 43 20 113 0 58 7 14 0 73 7 14 0 90 7 14 0 94 20 117 0 121 7 14 0 126 20 125 0 229 21 121 0 230] 
#[1 7 14 0 6 7 14 0 7 7 14 0 8 7 14 0 35 7 14 0 43 20 113 0 58 7 14 0 73 7 14 0 90 7 14 0 94 20 117 0 121 7 14 0 126 20 125 0 229 21 125 0 230] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 201 0 35 7 50 0 43 7 50 0 73 7 50 0 90 7 50 0 94 7 50 0 126 20 205 0 231 21 129 0 232] 
#[1 7 14 0 6 7 14 0 7 7 14 0 8 7 14 0 35 7 14 0 43 20 113 0 58 7 14 0 73 7 14 0 90 7 14 0 94 20 117 0 121 7 14 0 126 20 125 0 229 21 133 0 230] 
#[0 21 137 0 146] 
#[0 7 162 0 6 0 7 0 8 0 73 0 90 0 94 0 126] 
#[1 21 141 0 13 21 145 0 146] 
#[1 21 149 0 13 21 153 0 147] 
#[0 7 166 0 6 0 7 0 8 0 94 0 126] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 21 165 0 240] 
#[0 21 169 1 2 1 15] 
#[0 7 174 0 7 0 8] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 201 0 35 7 50 0 43 7 50 0 73 7 50 0 90 7 50 0 94 7 50 0 126 20 205 0 231 21 173 0 232] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 201 0 35 7 50 0 43 7 50 0 73 7 50 0 90 7 50 0 94 7 50 0 126 20 205 0 231 21 177 0 232] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 21 181 0 234] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 201 0 35 7 50 0 43 7 50 0 73 7 50 0 90 7 50 0 94 7 50 0 126 20 205 0 231 21 185 0 232] 
#[0 7 178 0 6 0 7 0 8 0 73 0 90 0 94 0 126] 
#[0 21 189 0 146] 
#[0 7 182 0 6 0 7 0 8 0 90 0 94 0 126] 
#[0 21 193 0 147] 
#[0 7 186 0 6 0 7 0 8 0 94 0 126] 
#[1 21 197 0 13 21 201 0 147] 
#[0 7 190 0 6 0 7 0 8 0 126] 
#[1 7 194 0 6 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 21 213 0 242] 
#[0 7 198 0 7 0 8] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 21 217 0 234] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 21 221 0 234] 
#[1 7 126 0 6 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 21 225 0 236] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 21 229 0 234] 
#[0 7 202 0 6 0 7 0 8 0 90 0 94 0 126] 
#[0 7 206 0 6 0 7 0 8 0 94 0 126] 
#[0 21 233 0 147] 
#[0 7 210 0 6 0 7 0 8 0 126] 
#[1 21 237 0 13 21 241 1 9 21 241 1 15] 
#[0 7 214 0 6 0 7 0 8] 
#[1 21 245 0 6 7 218 0 7 7 218 0 8 21 249 0 243 21 253 0 244] 
#[1 7 126 0 6 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 1 0 236] 
#[1 7 126 0 6 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 5 0 236] 
#[1 7 154 0 6 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 22 9 0 238] 
#[1 7 126 0 6 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 13 0 236] 
#[0 7 222 0 6 0 7 0 8 0 126] 
#[0 22 17 1 9 1 15] 
#[0 7 226 0 6 0 7 0 8] 
#[1 22 21 0 123 22 25 0 247] 
#[0 7 230 0 7 0 8] 
#[0 7 234 0 7 0 8] 
#[1 7 154 0 6 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 22 29 0 238] 
#[1 7 154 0 6 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 22 33 0 238] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 22 37 0 240] 
#[1 7 154 0 6 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 22 41 0 238] 
#[0 7 238 0 6 0 7 0 8] 
#[0 22 45 1 12 1 15] 
#[1 7 242 0 7 7 242 0 8 22 53 0 246] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 22 57 0 240] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 22 61 0 240] 
#[1 7 194 0 6 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 22 65 0 242] 
#[1 7 170 0 6 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 22 69 0 240] 
#[1 7 90 0 7 7 90 0 8 22 73 0 35 21 5 0 43 22 77 0 58 7 90 0 73 7 90 0 90 7 90 0 94 22 81 0 121 7 90 0 126 21 9 0 233 22 85 0 234] 
#[0 7 246 0 7 0 8 0 35 0 43 0 58 0 73 0 90 0 94 0 121 0 126] 
#[1 22 89 0 7 22 93 0 8 22 97 0 245] 
#[1 7 194 0 6 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 22 101 0 242] 
#[1 7 194 0 6 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 22 105 0 242] 
#[1 21 245 0 6 7 218 0 7 7 218 0 8 21 249 0 243 22 109 0 244] 
#[1 7 194 0 6 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 22 113 0 242] 
#[1 22 121 0 13 7 250 0 146 22 121 0 248] 
#[1 22 125 0 13 22 129 0 77 22 129 0 95 22 129 0 253] 
#[0 22 133 0 58] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 137 0 236] 
#[0 7 254 0 7 0 8] 
#[1 22 21 0 123 22 141 0 247] 
#[0 8 2 0 7 0 8] 
#[1 21 245 0 6 7 218 0 7 7 218 0 8 21 249 0 243 22 145 0 244] 
#[1 21 245 0 6 7 218 0 7 7 218 0 8 21 249 0 243 22 149 0 244] 
#[0 8 6 0 7 0 8] 
#[1 21 245 0 6 7 218 0 7 7 218 0 8 21 249 0 243 22 153 0 244] 
#[0 8 10 0 146] 
#[0 22 157 0 146] 
#[0 22 161 0 77 0 95 0 253] 
#[1 7 90 0 7 7 90 0 8 22 165 0 35 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 22 169 0 234] 
#[1 22 173 0 13 22 177 0 77 22 177 0 95 22 177 0 253] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 22 181 0 238] 
#[0 8 14 0 7 0 8] 
#[0 8 18 0 7 0 8] 
#[0 8 22 0 7 0 8] 
#[0 8 26 0 7 0 8] 
#[1 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 22 185 0 234] 
#[1 7 90 0 7 7 90 0 8 22 189 0 35 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 22 193 0 234] 
#[1 22 197 0 13 7 250 0 146 22 197 0 248] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 201 0 236] 
#[0 22 205 0 77 0 95 0 253] 
#[1 7 90 0 7 7 90 0 8 22 209 0 35 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 22 213 0 234] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 22 217 0 240] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 221 0 236] 
#[1 22 225 0 13 7 250 0 146 22 225 0 248] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 229 0 236] 
#[0 22 233 0 146] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 22 237 0 238] 
#[1 7 90 0 7 7 90 0 8 22 241 0 35 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 22 245 0 234] 
#[1 22 249 0 13 7 250 0 146 22 249 0 248] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 22 253 0 236] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 1 0 242] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 5 0 238] 
#[0 23 9 0 146] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 13 0 238] 
#[1 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 23 17 0 234] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 21 0 240] 
#[1 23 25 0 13 7 250 0 146 23 25 0 248] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 23 29 0 236] 
#[0 23 33 0 146] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 37 0 238] 
#[0 8 30 0 7 0 8] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 41 0 240] 
#[1 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 23 45 0 234] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 49 0 240] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 23 53 0 236] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 57 0 242] 
#[0 23 61 0 146] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 65 0 238] 
#[1 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 23 69 0 234] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 73 0 240] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 77 0 242] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 23 81 0 236] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 85 0 242] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 89 0 238] 
#[0 8 34 0 7 0 8] 
#[1 7 90 0 7 7 90 0 8 21 5 0 43 7 90 0 73 7 90 0 90 7 90 0 94 7 90 0 126 21 9 0 233 23 93 0 234] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 97 0 240] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 23 101 0 236] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 105 0 242] 
#[0 8 38 0 7 0 8] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 109 0 238] 
#[0 8 42 0 7 0 8] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 113 0 240] 
#[1 7 126 0 7 7 126 0 8 21 57 0 73 7 126 0 90 7 126 0 94 7 126 0 126 21 61 0 235 23 117 0 236] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 121 0 242] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 125 0 238] 
#[0 8 46 0 7 0 8] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 129 0 240] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 133 0 242] 
#[1 7 154 0 7 7 154 0 8 21 101 0 90 7 154 0 94 7 154 0 126 21 105 0 237 23 137 0 238] 
#[0 8 50 0 7 0 8] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 141 0 240] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 145 0 242] 
#[0 8 54 0 7 0 8] 
#[1 7 170 0 7 7 170 0 8 21 157 0 94 7 170 0 126 21 161 0 239 23 149 0 240] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 153 0 242] 
#[0 8 58 0 7 0 8] 
#[1 7 194 0 7 7 194 0 8 21 205 0 126 21 209 0 241 23 157 0 242] 
#[0 8 62 0 7 0 8] 
#[0 8 66 0 7 0 8]
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
MysqlParser >> reduceActionForDropTable1: nodes [
	| result |
	result := MysqlDropTableNode new.
	result dropToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result tableName: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForDropTable2: nodes [
	| result |
	result := MysqlDropTableNode new.
	result dropToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result ifToken: (nodes at: 3).
	result existsToken: (nodes at: 4).
	result tableName: (nodes at: 5).
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
