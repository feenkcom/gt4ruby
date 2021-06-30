Class {
	#name : #MysqlParser,
	#superclass : #SmaCCGLRParser,
	#category : #'SmaCC_Mysql'
}

{ #category : #generated }
MysqlParser class >> ambiguousTransitions [
^#(
#[ 1 158 5 121] 
#[ 3 86 10 77] 
#[ 3 102 10 117]
	).
]

{ #category : #'generated-accessing' }
MysqlParser class >> cacheId [
	^'2021-06-30T12:51:30.41886-05:00'
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
    	(""LIKE"" 'likeToken' tbl_name 'tableName' | ""("" 'leftParen' ""LIKE"" 'likeToken' tbl_name 'tableName' "")"" 'rightParen') {{}}
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
	: data_type_name 'typeName' (""("" 'leftParen' <integer> 'length' ("","" 'comma' <integer> 'precision')? "")"" 'rightParen')? ""unsigned"" 'unsignedToken'? (((""CHARACTER"" 'characterToken' ""SET"" 'setToken' | ""CHARSET"" 'charsetToken') ""="" 'equals'? charset_name 'charsetName') (""COLLATE"" 'collateToken' collation_name 'collationName')?)? {{DataType}}
	;
 data_type_name
	: ""BIGINT""
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
	: (col_name 'columnName' (""("" 'leftParen' length 'length' "")"" 'rightParen')? | ""("" 'leftParen' expr 'expr' "")"" 'rightParen') (""ASC"" 'direction' | ""DESC"" 'direction')?
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
	| <integer>
	| ""CURRENT_TIMESTAMP"" 'value'
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
	#(150 0 #reduceActionFor_Statement__statement_______semicolon___1: 349185 false ) 
	#(147 1 #reduceActionForFile1: 307201 false ) 
	#(151 0 #nil 425985 false ) 
	#(150 2 #reduceActionFor_Statement__statement_______semicolon___2: 349186 false ) 
	#(148 2 #reduceActionForStatements1: 334849 false ) 
	#(151 1 #liftFirstValue: 425986 false ) 
	#(149 2 #reduceActionFor_Statement__statement_______semicolon__1: 349185 false ) 
	#(236 1 #liftFirstValue: 12270593 false ) 
	#(155 0 #reduceActionForpartition_options_1: 1085441 false ) 
	#(157 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 1106945 false ) 
	#(202 0 #reduceActionFor_Statement__statement_______semicolon___1: 6678529 false ) 
	#(155 1 #reduceActionForFile1: 1085442 false ) 
	#(163 0 #nil 2396161 false ) 
	#(237 1 #liftFirstValue: 12293121 false ) 
	#(154 0 #reduceActionFor_Statement__statement_______semicolon___1: 679937 false ) 
	#(159 1 #reduceActionForcreate_definition57: 1503289 false ) 
	#(238 1 #liftFirstValue: 12315652 false ) 
	#(238 1 #liftFirstValue: 12315649 false ) 
	#(238 1 #liftFirstValue: 12315650 false ) 
	#(238 1 #liftFirstValue: 12315651 false ) 
	#(256 1 #liftFirstValue: 13001729 false ) 
	#(203 2 #reduceActionFortable_option1: 6720513 false ) 
	#(256 1 #liftFirstValue: 13001730 false ) 
	#(203 2 #reduceActionFortable_option3: 6720515 false ) 
	#(203 2 #reduceActionFortable_option5: 6720517 false ) 
	#(241 1 #liftFirstValue: 12462081 false ) 
	#(203 2 #reduceActionFortable_option9: 6720521 false ) 
	#(203 2 #reduceActionFortable_option15: 6720527 false ) 
	#(203 2 #reduceActionFortable_option15: 6720528 false ) 
	#(243 1 #liftFirstValue: 12519425 false ) 
	#(203 2 #reduceActionFortable_option19: 6720531 false ) 
	#(203 2 #reduceActionFortable_option23: 6720535 false ) 
	#(203 2 #reduceActionFortable_option26: 6720538 false ) 
	#(203 2 #reduceActionFortable_option26: 6720539 false ) 
	#(203 2 #reduceActionFortable_option26: 6720537 false ) 
	#(203 2 #reduceActionFortable_option31: 6720543 false ) 
	#(203 2 #reduceActionFortable_option37: 6720549 false ) 
	#(203 2 #reduceActionFortable_option37: 6720550 false ) 
	#(203 2 #reduceActionFortable_option42: 6720554 false ) 
	#(203 2 #reduceActionFortable_option42: 6720553 false ) 
	#(240 1 #liftFirstValue: 12427265 false ) 
	#(203 2 #reduceActionFortable_option45: 6720557 false ) 
	#(203 2 #reduceActionFortable_option47: 6720559 false ) 
	#(203 2 #reduceActionFortable_option50: 6720562 false ) 
	#(203 2 #reduceActionFortable_option50: 6720563 false ) 
	#(203 2 #reduceActionFortable_option50: 6720561 false ) 
	#(203 2 #reduceActionFortable_option55: 6720567 false ) 
	#(152 5 #reduceActionForCreateTable33: 457761 false ) 
	#(203 2 #reduceActionFortable_option57: 6720569 false ) 
	#(203 2 #reduceActionFortable_option59: 6720571 false ) 
	#(203 2 #reduceActionFortable_option61: 6720573 false ) 
	#(203 2 #reduceActionFortable_option61: 6720574 false ) 
	#(203 2 #reduceActionFortable_option61: 6720575 false ) 
	#(206 2 #reduceActionForpartition_options1: 9298945 false ) 
	#(207 0 #nil 9465857 false ) 
	#(203 2 #reduceActionFortable_option67: 6720579 false ) 
	#(203 2 #reduceActionFortable_option74: 6720586 false ) 
	#(203 2 #reduceActionFortable_option74: 6720584 false ) 
	#(203 2 #reduceActionFortable_option74: 6720581 false ) 
	#(203 2 #reduceActionFortable_option74: 6720582 false ) 
	#(203 2 #reduceActionFortable_option74: 6720583 false ) 
	#(203 2 #reduceActionFortable_option74: 6720585 false ) 
	#(203 2 #reduceActionFortable_option81: 6720593 false ) 
	#(203 2 #reduceActionFortable_option84: 6720596 false ) 
	#(203 2 #reduceActionFortable_option84: 6720597 false ) 
	#(203 2 #reduceActionFortable_option84: 6720595 false ) 
	#(203 2 #reduceActionFortable_option84: 6720602 false ) 
	#(203 2 #reduceActionFortable_option84: 6720603 false ) 
	#(203 2 #reduceActionFortable_option84: 6720601 false ) 
	#(203 2 #reduceActionFortable_option84: 6720607 false ) 
	#(203 2 #reduceActionFortable_option97: 6720609 false ) 
	#(252 1 #liftFirstValue: 12847105 false ) 
	#(156 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 1106945 false ) 
	#(156 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__2: 1106946 false ) 
	#(157 1 #reduceActionForFile1: 1106946 false ) 
	#(158 0 #nil 1163265 false ) 
	#(200 2 #reduceActionFortable_options1: 6638593 false ) 
	#(250 1 #liftFirstValue: 12777473 false ) 
	#(239 1 #liftFirstValue: 12402689 false ) 
	#(164 0 #reduceActionForindex_type_1: 2420737 false ) 
	#(163 1 #liftFirstValue: 2396162 false ) 
	#(191 1 #liftFirstValue: 4789249 false ) 
	#(191 1 #liftFirstValue: 4789250 false ) 
	#(191 1 #liftFirstValue: 4789251 false ) 
	#(191 1 #liftFirstValue: 4789252 false ) 
	#(191 1 #liftFirstValue: 4789253 false ) 
	#(191 1 #liftFirstValue: 4789254 false ) 
	#(191 1 #liftFirstValue: 4789255 false ) 
	#(191 1 #liftFirstValue: 4789256 false ) 
	#(191 1 #liftFirstValue: 4789257 false ) 
	#(191 1 #liftFirstValue: 4789258 false ) 
	#(191 1 #liftFirstValue: 4789259 false ) 
	#(191 1 #liftFirstValue: 4789260 false ) 
	#(191 1 #liftFirstValue: 4789261 false ) 
	#(191 1 #liftFirstValue: 4789262 false ) 
	#(191 1 #liftFirstValue: 4789263 false ) 
	#(191 1 #liftFirstValue: 4789264 false ) 
	#(191 1 #liftFirstValue: 4789265 false ) 
	#(191 1 #liftFirstValue: 4789266 false ) 
	#(191 1 #liftFirstValue: 4789267 false ) 
	#(191 1 #liftFirstValue: 4789268 false ) 
	#(159 2 #reduceActionForcreate_definition1: 1503233 false ) 
	#(169 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3090433 false ) 
	#(189 1 #reduceActionFordata_type1: 4424705 false ) 
	#(203 3 #reduceActionFortable_option2: 6720514 false ) 
	#(203 3 #reduceActionFortable_option4: 6720516 false ) 
	#(203 3 #reduceActionFortable_option6: 6720518 false ) 
	#(203 3 #reduceActionFortable_option7: 6720519 false ) 
	#(203 3 #reduceActionFortable_option10: 6720522 false ) 
	#(203 3 #reduceActionFortable_option17: 6720529 false ) 
	#(203 3 #reduceActionFortable_option17: 6720530 false ) 
	#(203 3 #reduceActionFortable_option20: 6720532 false ) 
	#(203 3 #reduceActionFortable_option24: 6720536 false ) 
	#(203 3 #reduceActionFortable_option29: 6720541 false ) 
	#(203 3 #reduceActionFortable_option29: 6720542 false ) 
	#(203 3 #reduceActionFortable_option29: 6720540 false ) 
	#(203 3 #reduceActionFortable_option32: 6720544 false ) 
	#(203 3 #reduceActionFortable_option33: 6720545 false ) 
	#(203 3 #reduceActionFortable_option13: 6720525 false ) 
	#(203 3 #reduceActionFortable_option21: 6720533 false ) 
	#(203 3 #reduceActionFortable_option39: 6720551 false ) 
	#(203 3 #reduceActionFortable_option39: 6720552 false ) 
	#(203 3 #reduceActionFortable_option44: 6720556 false ) 
	#(203 3 #reduceActionFortable_option44: 6720555 false ) 
	#(203 3 #reduceActionFortable_option46: 6720558 false ) 
	#(203 3 #reduceActionFortable_option48: 6720560 false ) 
	#(203 3 #reduceActionFortable_option35: 6720547 false ) 
	#(203 3 #reduceActionFortable_option53: 6720565 false ) 
	#(203 3 #reduceActionFortable_option53: 6720566 false ) 
	#(203 3 #reduceActionFortable_option53: 6720564 false ) 
	#(203 3 #reduceActionFortable_option56: 6720568 false ) 
	#(203 3 #reduceActionFortable_option58: 6720570 false ) 
	#(203 3 #reduceActionFortable_option60: 6720572 false ) 
	#(203 3 #reduceActionFortable_option64: 6720576 false ) 
	#(203 3 #reduceActionFortable_option64: 6720577 false ) 
	#(203 3 #reduceActionFortable_option64: 6720578 false ) 
	#(207 1 #liftFirstValue: 9465858 false ) 
	#(203 3 #reduceActionFortable_option68: 6720580 false ) 
	#(203 3 #reduceActionFortable_option80: 6720592 false ) 
	#(203 3 #reduceActionFortable_option80: 6720590 false ) 
	#(203 3 #reduceActionFortable_option80: 6720587 false ) 
	#(203 3 #reduceActionFortable_option80: 6720588 false ) 
	#(203 3 #reduceActionFortable_option80: 6720589 false ) 
	#(203 3 #reduceActionFortable_option80: 6720591 false ) 
	#(203 3 #reduceActionFortable_option82: 6720594 false ) 
	#(203 3 #reduceActionFortable_option87: 6720599 false ) 
	#(203 3 #reduceActionFortable_option87: 6720600 false ) 
	#(203 3 #reduceActionFortable_option87: 6720598 false ) 
	#(203 3 #reduceActionFortable_option87: 6720605 false ) 
	#(203 3 #reduceActionFortable_option87: 6720606 false ) 
	#(203 3 #reduceActionFortable_option87: 6720604 false ) 
	#(203 3 #reduceActionFortable_option87: 6720608 false ) 
	#(205 0 #reduceActionFor_Statement__statement_______semicolon___1: 9236481 false ) 
	#(158 1 #liftFirstValue: 1163266 false ) 
	#(202 2 #reduceActionFor_Statement__statement_______semicolon___2: 6678530 false ) 
	#(201 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 6678529 false ) 
	#(152 6 #reduceActionForCreateTable37: 457765 false ) 
	#(245 1 #liftFirstValue: 12602369 false ) 
	#(161 0 #reduceActionFor______comma__key_part__1: 1695745 false ) 
	#(192 1 #reduceActionForkey_part1: 5068801 false ) 
	#(193 2 #reduceActionForindex_type1: 5253121 false ) 
	#(193 2 #reduceActionForindex_type2: 5253122 false ) 
	#(152 7 #reduceActionForCreateTable34: 457762 false ) 
	#(164 1 #reduceActionForFile1: 2420738 false ) 
	#(152 7 #reduceActionForCreateTable1: 457729 false ) 
	#(154 2 #reduceActionFor_Statement__statement_______semicolon___2: 679938 false ) 
	#(168 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__2: 3090434 false ) 
	#(168 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3090433 false ) 
	#(169 1 #reduceActionForFile1: 3090434 false ) 
	#(170 0 #nil 3152897 false ) 
	#(190 0 #nil 4666369 false ) 
	#(189 2 #reduceActionFordata_type4: 4424708 false ) 
	#(203 4 #reduceActionFortable_option8: 6720520 false ) 
	#(203 4 #reduceActionFortable_option34: 6720546 false ) 
	#(203 4 #reduceActionFortable_option11: 6720523 false ) 
	#(203 4 #reduceActionFortable_option14: 6720526 false ) 
	#(203 4 #reduceActionFortable_option22: 6720534 false ) 
	#(203 4 #reduceActionFortable_option36: 6720548 false ) 
	#(209 0 #reduceActionForindex_type_1: 9507841 false ) 
	#(203 4 #reduceActionFortable_option98: 6720610 false ) 
	#(203 4 #reduceActionFortable_option99: 6720611 false ) 
	#(152 7 #reduceActionForCreateTable17: 457745 false ) 
	#(244 1 #liftFirstValue: 12555265 false ) 
	#(201 2 #reduceActionFor______comma___table_option__option__2: 6678530 false ) 
	#(152 8 #reduceActionForCreateTable35: 457763 false ) 
	#(195 4 #reduceActionForcheck_constraint_definition1: 5808129 false ) 
	#(166 0 #reduceActionFor_Statement__statement_______semicolon___1: 2722817 false ) 
	#(192 2 #reduceActionForkey_part2: 5068802 false ) 
	#(192 2 #reduceActionForkey_part2: 5068803 false ) 
	#(152 8 #reduceActionForCreateTable3: 457731 false ) 
	#(152 8 #reduceActionForCreateTable2: 457730 false ) 
	#(153 2 #reduceActionFor_Statement__statement_______semicolon__1: 679937 false ) 
	#(170 1 #liftFirstValue: 3152898 false ) 
	#(172 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3192833 false ) 
	#(190 1 #liftFirstValue: 4666370 false ) 
	#(203 5 #reduceActionFortable_option12: 6720524 false ) 
	#(209 1 #reduceActionForFile1: 9507842 false ) 
	#(203 5 #reduceActionFortable_option100: 6720612 false ) 
	#(205 2 #reduceActionFor_Statement__statement_______semicolon___2: 9236482 false ) 
	#(152 8 #reduceActionForCreateTable18: 457746 false ) 
	#(152 8 #reduceActionForCreateTable38: 457766 false ) 
	#(152 8 #reduceActionForCreateTable9: 457737 false ) 
	#(152 8 #reduceActionForCreateTable25: 457753 false ) 
	#(195 5 #reduceActionForcheck_constraint_definition2: 5808130 false ) 
	#(195 5 #reduceActionForcheck_constraint_definition4: 5808132 false ) 
	#(192 3 #reduceActionForkey_part7: 5068807 false ) 
	#(162 0 #nil 1980417 false ) 
	#(161 2 #reduceActionFor______comma__key_part__2: 1695746 false ) 
	#(242 1 #liftFirstValue: 12495873 false ) 
	#(159 5 #reduceActionForcreate_definition2: 1503234 false ) 
	#(159 5 #reduceActionForcreate_definition10: 1503242 false ) 
	#(152 9 #reduceActionForCreateTable4: 457732 false ) 
	#(171 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3192833 false ) 
	#(172 1 #reduceActionForFile1: 3192834 false ) 
	#(174 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3237889 false ) 
	#(189 4 #reduceActionFordata_type7: 4424711 false ) 
	#(178 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3329025 false ) 
	#(206 6 #reduceActionForpartition_options2: 9298946 false ) 
	#(211 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 9928705 false ) 
	#(206 6 #reduceActionForpartition_options5: 9298949 false ) 
	#(204 2 #reduceActionFor_Statement__statement_______semicolon__1: 9236481 false ) 
	#(203 6 #reduceActionFortable_option101: 6720613 false ) 
	#(152 9 #reduceActionForCreateTable39: 457767 false ) 
	#(152 9 #reduceActionForCreateTable11: 457739 false ) 
	#(152 9 #reduceActionForCreateTable10: 457738 false ) 
	#(152 9 #reduceActionForCreateTable26: 457754 false ) 
	#(152 10 #reduceActionForCreateTable36: 457764 false ) 
	#(152 10 #reduceActionForCreateTable5: 457733 false ) 
	#(152 10 #reduceActionForCreateTable21: 457749 false ) 
	#(195 6 #reduceActionForcheck_constraint_definition3: 5808131 false ) 
	#(195 6 #reduceActionForcheck_constraint_definition5: 5808133 false ) 
	#(195 6 #reduceActionForcheck_constraint_definition7: 5808135 false ) 
	#(166 2 #reduceActionFor_Statement__statement_______semicolon___2: 2722818 false ) 
	#(192 4 #reduceActionForkey_part8: 5068808 false ) 
	#(192 4 #reduceActionForkey_part8: 5068809 false ) 
	#(194 1 #reduceActionForindex_option7: 5337095 false ) 
	#(194 1 #reduceActionForindex_option6: 5337094 false ) 
	#(159 6 #reduceActionForcreate_definition18: 1503250 false ) 
	#(194 1 #reduceActionForindex_option3: 5337091 false ) 
	#(162 1 #liftFirstValue: 1980418 false ) 
	#(160 2 #reduceActionFor______comma__key_part_1: 1695745 false ) 
	#(192 4 #reduceActionForkey_part4: 5068804 false ) 
	#(159 6 #reduceActionForcreate_definition3: 1503235 false ) 
	#(159 6 #reduceActionForcreate_definition4: 1503236 false ) 
	#(159 6 #reduceActionForcreate_definition6: 1503238 false ) 
	#(159 6 #reduceActionForcreate_definition11: 1503243 false ) 
	#(159 6 #reduceActionForcreate_definition12: 1503244 false ) 
	#(159 6 #reduceActionForcreate_definition14: 1503246 false ) 
	#(159 6 #reduceActionForcreate_definition30: 1503262 false ) 
	#(159 6 #reduceActionForcreate_definition24: 1503256 false ) 
	#(171 2 #reduceActionFor_Statement__statement_______semicolon__1: 3192834 false ) 
	#(173 1 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken__1: 3237889 false ) 
	#(174 1 #reduceActionForFile1: 3237890 false ) 
	#(176 0 #nil 3287041 false ) 
	#(189 5 #reduceActionFordata_type10: 4424714 false ) 
	#(178 1 #reduceActionForFile1: 3329026 false ) 
	#(189 5 #reduceActionFordata_type3: 4424707 false ) 
	#(206 7 #reduceActionForpartition_options3: 9298947 false ) 
	#(211 1 #reduceActionForFile1: 9928706 false ) 
	#(206 7 #reduceActionForpartition_options6: 9298950 false ) 
	#(208 3 #reduceActionFor__ALGORITHM___algorithmToken_______equals____1___value_____2___value___1: 9507841 false ) 
	#(208 3 #reduceActionFor__ALGORITHM___algorithmToken_______equals____1___value_____2___value___1: 9507842 false ) 
	#(152 10 #reduceActionForCreateTable12: 457740 false ) 
	#(152 11 #reduceActionForCreateTable7: 457735 false ) 
	#(152 11 #reduceActionForCreateTable6: 457734 false ) 
	#(152 11 #reduceActionForCreateTable22: 457750 false ) 
	#(195 7 #reduceActionForcheck_constraint_definition6: 5808134 false ) 
	#(159 7 #reduceActionForcreate_definition34: 1503266 false ) 
	#(195 7 #reduceActionForcheck_constraint_definition8: 5808136 false ) 
	#(159 7 #reduceActionForcreate_definition51: 1503283 false ) 
	#(165 2 #reduceActionFor_Statement__statement_______semicolon__1: 2722817 false ) 
	#(194 2 #reduceActionForindex_option5: 5337093 false ) 
	#(194 2 #reduceActionForindex_option8: 5337096 false ) 
	#(194 2 #reduceActionForindex_option1: 5337089 false ) 
	#(194 2 #reduceActionForindex_option10: 5337098 false ) 
	#(192 5 #reduceActionForkey_part5: 5068805 false ) 
	#(192 5 #reduceActionForkey_part5: 5068806 false ) 
	#(159 7 #reduceActionForcreate_definition20: 1503252 false ) 
	#(159 7 #reduceActionForcreate_definition22: 1503254 false ) 
	#(159 7 #reduceActionForcreate_definition19: 1503251 false ) 
	#(159 7 #reduceActionForcreate_definition5: 1503237 false ) 
	#(159 7 #reduceActionForcreate_definition7: 1503239 false ) 
	#(159 7 #reduceActionForcreate_definition8: 1503240 false ) 
	#(159 7 #reduceActionForcreate_definition13: 1503245 false ) 
	#(159 7 #reduceActionForcreate_definition15: 1503247 false ) 
	#(159 7 #reduceActionForcreate_definition16: 1503248 false ) 
	#(159 7 #reduceActionForcreate_definition31: 1503263 false ) 
	#(159 7 #reduceActionForcreate_definition32: 1503264 false ) 
	#(159 7 #reduceActionForcreate_definition26: 1503258 false ) 
	#(159 7 #reduceActionForcreate_definition28: 1503260 false ) 
	#(159 7 #reduceActionForcreate_definition25: 1503257 false ) 
	#(152 11 #reduceActionForCreateTable19: 457747 false ) 
	#(173 2 #reduceActionFor______comma___table_option__option__2: 3237890 false ) 
	#(176 1 #liftFirstValue: 3287042 false ) 
	#(189 6 #reduceActionFordata_type13: 4424717 false ) 
	#(189 6 #reduceActionFordata_type2: 4424706 false ) 
	#(177 2 #reduceActionFor_Statement__statement_______semicolon__1: 3329025 false ) 
	#(189 6 #reduceActionFordata_type6: 4424710 false ) 
	#(253 1 #liftFirstValue: 12893185 false ) 
	#(210 2 #reduceActionFor_Statement__statement_______semicolon__1: 9928705 false ) 
	#(249 3 #reduceActionForcolumn_list1: 12699649 false ) 
	#(206 8 #reduceActionForpartition_options4: 9298948 false ) 
	#(152 11 #reduceActionForCreateTable40: 457768 false ) 
	#(152 11 #reduceActionForCreateTable13: 457741 false ) 
	#(152 11 #reduceActionForCreateTable29: 457757 false ) 
	#(152 12 #reduceActionForCreateTable8: 457736 false ) 
	#(159 8 #reduceActionForcreate_definition53: 1503285 false ) 
	#(159 8 #reduceActionForcreate_definition35: 1503267 false ) 
	#(159 8 #reduceActionForcreate_definition36: 1503268 false ) 
	#(195 8 #reduceActionForcheck_constraint_definition9: 5808137 false ) 
	#(159 8 #reduceActionForcreate_definition38: 1503270 false ) 
	#(159 8 #reduceActionForcreate_definition52: 1503284 false ) 
	#(194 3 #reduceActionForindex_option9: 5337097 false ) 
	#(194 3 #reduceActionForindex_option2: 5337090 false ) 
	#(194 3 #reduceActionForindex_option11: 5337099 false ) 
	#(251 1 #liftFirstValue: 12814337 false ) 
	#(194 3 #reduceActionForindex_option4: 5337092 false ) 
	#(159 8 #reduceActionForcreate_definition21: 1503253 false ) 
	#(159 8 #reduceActionForcreate_definition23: 1503255 false ) 
	#(159 8 #reduceActionForcreate_definition9: 1503241 false ) 
	#(159 8 #reduceActionForcreate_definition17: 1503249 false ) 
	#(159 8 #reduceActionForcreate_definition33: 1503265 false ) 
	#(159 8 #reduceActionForcreate_definition27: 1503259 false ) 
	#(159 8 #reduceActionForcreate_definition29: 1503261 false ) 
	#(159 8 #reduceActionForcreate_definition42: 1503274 false ) 
	#(152 12 #reduceActionForCreateTable20: 457748 false ) 
	#(175 2 #liftFirstValue: 3287041 false ) 
	#(180 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 3391489 false ) 
	#(189 7 #reduceActionFordata_type16: 4424720 false ) 
	#(189 7 #reduceActionFordata_type5: 4424709 false ) 
	#(152 12 #reduceActionForCreateTable15: 457743 false ) 
	#(152 12 #reduceActionForCreateTable14: 457742 false ) 
	#(152 12 #reduceActionForCreateTable30: 457758 false ) 
	#(152 12 #reduceActionForCreateTable27: 457755 false ) 
	#(159 9 #reduceActionForcreate_definition54: 1503286 false ) 
	#(159 9 #reduceActionForcreate_definition37: 1503269 false ) 
	#(159 9 #reduceActionForcreate_definition45: 1503277 false ) 
	#(159 9 #reduceActionForcreate_definition55: 1503287 false ) 
	#(159 9 #reduceActionForcreate_definition39: 1503271 false ) 
	#(159 9 #reduceActionForcreate_definition40: 1503272 false ) 
	#(159 9 #reduceActionForcreate_definition43: 1503275 false ) 
	#(159 9 #reduceActionForcreate_definition44: 1503276 false ) 
	#(180 1 #reduceActionForFile1: 3391490 false ) 
	#(182 0 #reduceActionForindex_type_1: 3514369 false ) 
	#(189 8 #reduceActionFordata_type9: 4424713 false ) 
	#(152 13 #reduceActionForCreateTable16: 457744 false ) 
	#(152 13 #reduceActionForCreateTable28: 457756 false ) 
	#(152 14 #reduceActionForCreateTable23: 457751 false ) 
	#(159 10 #reduceActionForcreate_definition46: 1503278 false ) 
	#(159 10 #reduceActionForcreate_definition47: 1503279 false ) 
	#(159 10 #reduceActionForcreate_definition56: 1503288 false ) 
	#(159 10 #reduceActionForcreate_definition41: 1503273 false ) 
	#(159 10 #reduceActionForcreate_definition48: 1503280 false ) 
	#(179 2 #reduceActionFor_Statement__statement_______semicolon__1: 3391491 false ) 
	#(179 2 #reduceActionFor_Statement__statement_______semicolon__1: 3391490 false ) 
	#(179 2 #reduceActionFor_Statement__statement_______semicolon__1: 3391489 false ) 
	#(182 1 #reduceActionForFile1: 3514370 false ) 
	#(184 0 #reduceActionForindex_type_1: 3604481 false ) 
	#(189 9 #reduceActionFordata_type8: 4424712 false ) 
	#(189 9 #reduceActionFordata_type12: 4424716 false ) 
	#(152 15 #reduceActionForCreateTable24: 457752 false ) 
	#(159 11 #reduceActionForcreate_definition49: 1503281 false ) 
	#(159 11 #reduceActionForcreate_definition50: 1503282 false ) 
	#(187 0 #reduceActionForreference_definition_1: 3785729 false ) 
	#(181 2 #reduceActionForindex_type1: 3514369 false ) 
	#(184 1 #reduceActionForFile1: 3604482 false ) 
	#(186 0 #reduceActionForindex_type_1: 3707905 false ) 
	#(189 10 #reduceActionFordata_type11: 4424715 false ) 
	#(189 10 #reduceActionFordata_type15: 4424719 false ) 
	#(152 15 #reduceActionForCreateTable31: 457759 false ) 
	#(198 0 #reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option__1: 6372353 false ) 
	#(188 0 #reduceActionForcheck_constraint_definition_1: 3810305 false ) 
	#(187 1 #reduceActionForFile1: 3785730 false ) 
	#(181 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 3514370 false ) 
	#(183 2 #reduceActionForindex_type1: 3604481 false ) 
	#(186 1 #reduceActionForFile1: 3707906 false ) 
	#(189 11 #reduceActionFordata_type14: 4424718 false ) 
	#(189 11 #reduceActionFordata_type18: 4424722 false ) 
	#(152 16 #reduceActionForCreateTable32: 457760 false ) 
	#(198 1 #reduceActionForFile1: 6372354 false ) 
	#(196 7 #reduceActionForreference_definition1: 6021121 false ) 
	#(167 12 #reduceActionForcolumn_definition13: 2887693 false ) 
	#(188 1 #reduceActionForFile1: 3810306 false ) 
	#(167 12 #reduceActionForcolumn_definition10: 2887690 false ) 
	#(183 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 3604482 false ) 
	#(185 2 #reduceActionForindex_type1: 3707905 false ) 
	#(185 2 #reduceActionForindex_type2: 3707906 false ) 
	#(189 12 #reduceActionFordata_type17: 4424721 false ) 
	#(213 0 #reduceActionFor__IGNORE___ignoreToken_____REPLACE___replaceToken___1: 10302465 false ) 
	#(167 13 #reduceActionForcolumn_definition15: 2887695 false ) 
	#(167 13 #reduceActionForcolumn_definition12: 2887692 false ) 
	#(167 13 #reduceActionForcolumn_definition1: 2887681 false ) 
	#(213 1 #reduceActionForFile1: 10302466 false ) 
	#(196 9 #reduceActionForreference_definition3: 6021123 false ) 
	#(196 9 #reduceActionForreference_definition5: 6021125 false ) 
	#(196 9 #reduceActionForreference_definition7: 6021127 false ) 
	#(199 1 #reduceActionForreference_option2: 6434818 false ) 
	#(199 1 #reduceActionForreference_option1: 6434817 false ) 
	#(197 3 #reduceActionFor__ON___onToken___UPDATE___updateToken__reference_option_1: 6372353 false ) 
	#(167 14 #reduceActionForcolumn_definition14: 2887694 false ) 
	#(167 14 #reduceActionForcolumn_definition11: 2887691 false ) 
	#(167 14 #reduceActionForcolumn_definition25: 2887705 false ) 
	#(167 14 #reduceActionForcolumn_definition22: 2887702 false ) 
	#(167 14 #reduceActionForcolumn_definition19: 2887699 false ) 
	#(167 14 #reduceActionForcolumn_definition16: 2887696 false ) 
	#(167 14 #reduceActionForcolumn_definition7: 2887687 false ) 
	#(212 2 #reduceActionFor_Statement__statement_______semicolon__1: 10302465 false ) 
	#(199 2 #reduceActionForreference_option4: 6434820 false ) 
	#(199 2 #reduceActionForreference_option5: 6434821 false ) 
	#(199 2 #reduceActionForreference_option3: 6434819 false ) 
	#(196 10 #reduceActionForreference_definition2: 6021122 false ) 
	#(167 15 #reduceActionForcolumn_definition27: 2887707 false ) 
	#(167 15 #reduceActionForcolumn_definition24: 2887704 false ) 
	#(167 15 #reduceActionForcolumn_definition2: 2887682 false ) 
	#(167 15 #reduceActionForcolumn_definition21: 2887701 false ) 
	#(167 15 #reduceActionForcolumn_definition18: 2887698 false ) 
	#(167 15 #reduceActionForcolumn_definition4: 2887684 false ) 
	#(215 0 #reduceActionFor_Statement__statement_______semicolon___1: 10422273 false ) 
	#(167 16 #reduceActionForcolumn_definition26: 2887706 false ) 
	#(167 16 #reduceActionForcolumn_definition23: 2887703 false ) 
	#(167 16 #reduceActionForcolumn_definition31: 2887711 false ) 
	#(167 16 #reduceActionForcolumn_definition28: 2887708 false ) 
	#(167 16 #reduceActionForcolumn_definition20: 2887700 false ) 
	#(167 16 #reduceActionForcolumn_definition17: 2887697 false ) 
	#(167 16 #reduceActionForcolumn_definition8: 2887688 false ) 
	#(218 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 10823681 false ) 
	#(254 1 #liftFirstValue: 12913665 false ) 
	#(196 12 #reduceActionForreference_definition4: 6021124 false ) 
	#(196 12 #reduceActionForreference_definition6: 6021126 false ) 
	#(196 12 #reduceActionForreference_definition8: 6021128 false ) 
	#(167 17 #reduceActionForcolumn_definition33: 2887713 false ) 
	#(167 17 #reduceActionForcolumn_definition30: 2887710 false ) 
	#(167 17 #reduceActionForcolumn_definition3: 2887683 false ) 
	#(167 17 #reduceActionForcolumn_definition5: 2887685 false ) 
	#(218 1 #reduceActionForFile1: 10823682 false ) 
	#(220 0 #reduceActionForindex_type_1: 10918913 false ) 
	#(206 19 #reduceActionForpartition_options7: 9298951 false ) 
	#(215 2 #reduceActionFor_Statement__statement_______semicolon___2: 10422274 false ) 
	#(167 18 #reduceActionForcolumn_definition32: 2887712 false ) 
	#(167 18 #reduceActionForcolumn_definition29: 2887709 false ) 
	#(167 18 #reduceActionForcolumn_definition9: 2887689 false ) 
	#(206 20 #reduceActionForpartition_options8: 9298952 false ) 
	#(217 2 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__1: 10823681 false ) 
	#(220 1 #reduceActionForFile1: 10918914 false ) 
	#(222 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 10989569 false ) 
	#(214 2 #reduceActionFor_Statement__statement_______semicolon__1: 10422273 false ) 
	#(206 20 #reduceActionForpartition_options9: 9298953 false ) 
	#(167 19 #reduceActionForcolumn_definition6: 2887686 false ) 
	#(217 3 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__2: 10823682 false ) 
	#(217 3 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__3: 10823683 false ) 
	#(246 0 #reduceActionFor_Statement__statement_______semicolon___1: 12637186 false ) 
	#(219 2 #reduceActionForindex_type1: 10918913 false ) 
	#(222 1 #reduceActionForFile1: 10989570 false ) 
	#(224 0 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName___1: 11089921 false ) 
	#(206 21 #reduceActionForpartition_options10: 9298954 false ) 
	#(217 4 #reduceActionFor__STORAGE___storageToken____ENGINE___engineToken_______equals___engine_name__engineName__4: 10823684 false ) 
	#(248 0 #reduceActionFor_Statement__statement_______semicolon___1: 12664833 false ) 
	#(219 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 10918914 false ) 
	#(224 1 #reduceActionForFile1: 11089922 false ) 
	#(226 0 #reduceActionForindex_type_1: 11193345 false ) 
	#(246 2 #reduceActionForvalue_list1: 12637185 false ) 
	#(221 3 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__1: 10989569 false ) 
	#(226 1 #reduceActionForFile1: 11193346 false ) 
	#(228 0 #reduceActionForindex_type_1: 11266049 false ) 
	#(248 2 #reduceActionFor_Statement__statement_______semicolon___2: 12664834 false ) 
	#(221 4 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__2: 10989570 false ) 
	#(223 3 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__1: 11089921 false ) 
	#(225 2 #reduceActionForindex_type1: 11193345 false ) 
	#(228 1 #reduceActionForFile1: 11266050 false ) 
	#(230 0 #reduceActionForindex_type_1: 11338753 false ) 
	#(247 2 #reduceActionFor_Statement__statement_______semicolon__1: 12664833 false ) 
	#(223 4 #reduceActionFor__DATA___dataToken___DIRECTORY___directoryToken_______equals____string___dataDirectory__2: 11089922 false ) 
	#(225 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11193346 false ) 
	#(227 2 #reduceActionForindex_type1: 11266049 false ) 
	#(230 1 #reduceActionForFile1: 11338754 false ) 
	#(232 0 #reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen___1: 11429889 false ) 
	#(227 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11266050 false ) 
	#(229 2 #reduceActionForindex_type1: 11338753 false ) 
	#(232 1 #reduceActionForFile1: 11429890 false ) 
	#(216 10 #reduceActionForpartition_definition1: 10496001 false ) 
	#(229 3 #reduceActionFor__ENGINE_ATTRIBUTE___engineAttributeToken_______equals____string___engineAttribute__2: 11338754 false ) 
	#(234 0 #reduceActionFor_Statement__statement_______semicolon___1: 11485185 false ) 
	#(255 1 #liftFirstValue: 12958721 false ) 
	#(231 4 #reduceActionFor______leftParen__subpartition_definition__definition________comma__subpartition_definition__definition_________rightParen__1: 11429889 false ) 
	#(234 2 #reduceActionFor_Statement__statement_______semicolon___2: 11485186 false ) 
	#(216 14 #reduceActionForpartition_definition4: 10496004 false ) 
	#(233 2 #reduceActionFor_Statement__statement_______semicolon__1: 11485185 false ) 
	#(216 15 #reduceActionForpartition_definition5: 10496005 false ) 
	#(216 15 #reduceActionForpartition_definition2: 10496002 false ) 
	#(216 15 #reduceActionForpartition_definition3: 10496003 false ) 
	#(235 7 #reduceActionForsubpartition_definition1: 11566081 false ) 
	#(235 9 #reduceActionForsubpartition_definition3: 11566083 false ) 
	#(235 10 #reduceActionForsubpartition_definition2: 11566082 false ) 
	#(235 10 #reduceActionForsubpartition_definition5: 11566085 false ) 
	#(235 10 #reduceActionForsubpartition_definition7: 11566087 false ) 
	#(235 11 #reduceActionForsubpartition_definition9: 11566089 false ) 
	#(235 12 #reduceActionForsubpartition_definition4: 11566084 false ) 
	#(235 13 #reduceActionForsubpartition_definition6: 11566086 false ) 
	#(235 13 #reduceActionForsubpartition_definition8: 11566088 false ) 
	#(235 14 #reduceActionForsubpartition_definition10: 11566090 false )
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
	^ #('"''LZ4''"' '"''N''"' '"''NONE''"' '"''Y''"' '"''ZLIB''"' '"("' '")"' '","' '"0"' '"1"' '"2"' '";"' '"="' '"ACTION"' '"ALGORITHM"' '"ALWAYS"' '"AS"' '"ASC"' '"AUTOEXTEND_SIZE"' '"AUTO_INCREMENT"' '"AVG_ROW_LENGTH"' '"BIGINT"' '"BTREE"' '"BY"' '"CASCADE"' '"CHAR"' '"CHARACTER"' '"CHARSET"' '"CHECK"' '"CHECKSUM"' '"COLLATE"' '"COLUMNS"' '"COLUMN_FORMAT"' '"COMMENT"' '"COMPACT"' '"COMPRESSED"' '"COMPRESSION"' '"CONNECTION"' '"CONSTRAINT"' '"CREATE"' '"CURRENT_TIMESTAMP"' '"DATA"' '"DATE"' '"DATETIME"' '"DECIMAL"' '"DEFAULT"' '"DELAY_KEY_WRITE"' '"DELETE"' '"DESC"' '"DIRECTORY"' '"DISK"' '"DOUBLE"' '"DYNAMIC"' '"ENCRYPTION"' '"ENFORCED"' '"ENGINE"' '"ENGINE_ATTRIBUTE"' '"EXISTS"' '"FIRST"' '"FIXED"' '"FLOAT"' '"FOREIGN"' '"FULL"' '"FULLTEXT"' '"GENERATED"' '"HASH"' '"IF"' '"IGNORE"' '"IN"' '"INDEX"' '"INSERT_METHOD"' '"INT"' '"INVISIBLE"' '"InnoDB"' '"JSON"' '"KEY"' '"KEY_BLOCK_SIZE"' '"LAST"' '"LESS"' '"LIKE"' '"LINEAR"' '"LIST"' '"LONGBLOB"' '"LONGTEXT"' '"MATCH"' '"MAXVALUE"' '"MAX_ROWS"' '"MEDIUMBLOB"' '"MEDIUMTEXT"' '"MEMORY"' '"MIN_ROWS"' '"NO"' '"NOT"' '"NULL"' '"ON"' '"PACK_KEYS"' '"PARSER"' '"PARTIAL"' '"PARTITION"' '"PARTITIONS"' '"PASSWORD"' '"PRIMARY"' '"RANGE"' '"REDUNDANT"' '"REFERENCES"' '"REPLACE"' '"RESTRICT"' '"ROW_FORMAT"' '"SECONDARY_ENGINE_ATTRIBUTE"' '"SET"' '"SIMPLE"' '"SMALLINT"' '"SPATIAL"' '"STATS_AUTO_RECALC"' '"STATS_PERSISTENT"' '"STATS_SAMPLE_PAGES"' '"STORAGE"' '"STORED"' '"SUBPARTITION"' '"SUBPARTITIONS"' '"TABLE"' '"TABLESPACE"' '"TEMPORARY"' '"TEXT"' '"THAN"' '"TIMESTAMP"' '"TINYINT"' '"TINYTEXT"' '"UNION"' '"UNIQUE"' '"UPDATE"' '"USING"' '"VALUES"' '"VARBINARY"' '"VARCHAR"' '"VIRTUAL"' '"VISIBLE"' '"WITH"' '"unsigned"' '<string>' '<integer>' '<name>' '<comment>' '<whitespace>' '<simple_name>' 'B e g i n' 'File' 'Statements' '(Statement ''statement'' ";" ''semicolon'')' '(Statement ''statement'' ";" ''semicolon'')*' 'Statement' 'CreateTable' '("," ''comma'' create_definition ''definition'')' '("," ''comma'' create_definition ''definition'')*' 'partition_options?' '("IGNORE" ''ignoreToken'' | "REPLACE" ''replaceToken'')' '("IGNORE" ''ignoreToken'' | "REPLACE" ''replaceToken'')?' '"AS" ''asToken''?' 'create_definition' '("," ''comma'' key_part)' '("," ''comma'' key_part)*' 'index_option ''option''?' 'index_name ''indexName''?' 'index_type?' '("," ''comma'' col_name ''columnName'')' '("," ''comma'' col_name ''columnName'')*' 'column_definition' '("VISIBLE" ''visibleToken'' | "INVISIBLE" ''invisibleToken'')' '("VISIBLE" ''visibleToken'' | "INVISIBLE" ''invisibleToken'')?' '"AUTO_INCREMENT" ''autoIncrementToken''?' '("UNIQUE" ''uniqueToken'' "KEY" ''keyToken''?)' '("UNIQUE" ''uniqueToken'' "KEY" ''keyToken''?)?' '("PRIMARY" ''primaryToken''? "KEY" ''keyToken'')' '("PRIMARY" ''primaryToken''? "KEY" ''keyToken'')?' '("COMMENT" ''commentToken'' <string>)' '("COMMENT" ''commentToken'' <string>)?' '("COLLATE" ''collateToken'' collation_name ''collationName'')' '("COLLATE" ''collateToken'' collation_name ''collationName'')?' '("COLUMN_FORMAT" ''columnFormatToken'' ("FIXED" ''columnFormat'' | "DYNAMIC" ''columnFormat'' | "DEFAULT" ''columnFormat''))' '("COLUMN_FORMAT" ''columnFormatToken'' ("FIXED" ''columnFormat'' | "DYNAMIC" ''columnFormat'' | "DEFAULT" ''columnFormat''))?' '("ENGINE_ATTRIBUTE" ''engineAttributeToken'' "=" ''equals''? <string> ''engineAttribute'')' '("ENGINE_ATTRIBUTE" ''engineAttributeToken'' "=" ''equals''? <string> ''engineAttribute'')?' '("SECONDARY_ENGINE_ATTRIBUTE" ''secondaryToken'' "=" ''equals''? <string> ''secondaryEngineAttribute'')' '("SECONDARY_ENGINE_ATTRIBUTE" ''secondaryToken'' "=" ''equals''? <string> ''secondaryEngineAttribute'')?' '("STORAGE" ''storageToken'' ("DISK" ''diskToken'' | "MEMORY" ''memoryToken''))' '("STORAGE" ''storageToken'' ("DISK" ''diskToken'' | "MEMORY" ''memoryToken''))?' 'reference_definition?' 'check_constraint_definition?' 'data_type' '"=" ''equals''?' 'data_type_name' 'key_part' 'index_type' 'index_option' 'check_constraint_definition' 'reference_definition' '("ON" ''onToken'' "UPDATE" ''updateToken'' reference_option)' '("ON" ''onToken'' "UPDATE" ''updateToken'' reference_option)?' 'reference_option' 'table_options' '("," ''comma''? table_option ''option'')' '("," ''comma''? table_option ''option'')*' 'table_option' '("," ''comma'' tbl_name ''tableName'')' '("," ''comma'' tbl_name ''tableName'')*' 'partition_options' '"LINEAR" ''linearToken''?' '("ALGORITHM" ''algorithmToken'' "=" ''equals'' ("1" ''value'' | "2" ''value''))' '("ALGORITHM" ''algorithmToken'' "=" ''equals'' ("1" ''value'' | "2" ''value''))?' '("PARTITIONS" ''partitionsToken'' num ''partitions'')' '("PARTITIONS" ''partitionsToken'' num ''partitions'')?' '("SUBPARTITIONS" ''subpartitionsToken'' num ''subpartitions'')' '("SUBPARTITIONS" ''subpartitionsToken'' num ''subpartitions'')?' '("," ''comma'' partition_definition ''definition'')' '("," ''comma'' partition_definition ''definition'')*' 'partition_definition' '("STORAGE" ''storageToken''? "ENGINE" ''engineToken'' "=" ''equals''? engine_name ''engineName'')' '("STORAGE" ''storageToken''? "ENGINE" ''engineToken'' "=" ''equals''? engine_name ''engineName'')?' '("COMMENT" ''commentToken'' "=" ''equals''? <string> ''comment'')' '("COMMENT" ''commentToken'' "=" ''equals''? <string> ''comment'')?' '("DATA" ''dataToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''dataDirectory'')' '("DATA" ''dataToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''dataDirectory'')?' '("INDEX" ''indexToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''indexDirectory'')' '("INDEX" ''indexToken'' "DIRECTORY" ''directoryToken'' "=" ''equals''? <string> ''indexDirectory'')?' '("MAX_ROWS" ''maxRowsToken'' "=" ''equals''? <integer> ''maxRows'')' '("MAX_ROWS" ''maxRowsToken'' "=" ''equals''? <integer> ''maxRows'')?' '("MIN_ROWS" ''minRowsToken'' "=" ''equals''? <integer> ''minRows'')' '("MIN_ROWS" ''minRowsToken'' "=" ''equals''? <integer> ''minRows'')?' '("TABLESPACE" ''tableSpaceToken'' "=" ''equals''? tablespace_name ''tablespaceName'')' '("TABLESPACE" ''tableSpaceToken'' "=" ''equals''? tablespace_name ''tablespaceName'')?' '("(" ''leftParen'' subpartition_definition ''definition'' ("," ''comma'' subpartition_definition ''definition'')* ")" ''rightParen'')' '("(" ''leftParen'' subpartition_definition ''definition'' ("," ''comma'' subpartition_definition ''definition'')* ")" ''rightParen'')?' '("," ''comma'' subpartition_definition ''definition'')' '("," ''comma'' subpartition_definition ''definition'')*' 'subpartition_definition' 'tbl_name' 'col_name' 'literal' 'index_name' 'engine_name' 'charset_name' 'length' 'collation_name' 'query_expression' 'expr' 'value_list' '("," ''comma'' expr ''value'')' '("," ''comma'' expr ''value'')*' 'column_list' 'symbol' 'parser_name' 'tablespace_name' 'num' 'partition_name' 'logical_name' 'value' 'E O F' 'error')
]

{ #category : #generated }
MysqlParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #MysqlFileNode #MysqlFileNode #MysqlFileNode #OrderedCollection #OrderedCollection #MysqlCreateTableNode #MysqlCreateTableNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #MysqlProgramNode #OrderedCollection #OrderedCollection #MysqlIndexOptionNode #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlDataTypeNode #SmaCCToken #SmaCCToken #OrderedCollection #OrderedCollection #MysqlIndexOptionNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlTableOptionNode #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlPartitionDefinitionNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #MysqlSubpartitionDefinitionNode #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode #SmaCCErrorNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCErrorNode #SmaCCToken #SmaCCErrorNode #SmaCCToken #SmaCCErrorNode #SmaCCErrorNode #Object #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
MysqlParser class >> transitionTable [
^#(
#[1 0 6 0 12 0 6 0 40 0 9 0 147 0 13 0 148 0 17 0 150 0 6 1 1] 
#[0 0 0 1 1] 
#[0 0 10 1 1] 
#[1 0 14 0 12 0 21 0 40 0 25 0 149 0 29 0 151 0 29 0 152 0 14 1 1] 
#[1 0 37 0 121 0 41 0 123] 
#[0 0 18 0 12 0 40 1 1] 
#[1 0 45 0 12 0 22 1 1] 
#[0 0 26 0 12 1 1] 
#[1 0 49 0 67 0 57 0 142 0 57 0 236] 
#[0 0 61 0 121] 
#[0 0 30 0 12 0 40 1 1] 
#[0 0 65 0 93] 
#[0 0 34 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 80 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 0 69 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 0 149 0 80 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 0 201 0 155 0 205 0 200 0 209 0 203 0 213 0 206 0 38 1 2] 
#[1 0 217 0 67 0 221 0 142 0 221 0 236] 
#[0 0 225 0 58] 
#[1 0 229 0 29 0 233 0 39 0 237 0 62 0 241 0 64 0 245 0 70 0 249 0 76 0 253 0 80 1 1 0 102 1 5 0 113 1 9 0 130 1 25 0 142 1 17 0 159 1 21 0 195 1 25 0 237] 
#[1 1 29 0 13 1 53 0 41 1 53 0 94 1 53 0 140 1 53 0 141 1 53 0 238 1 53 1 0 1 53 1 2] 
#[1 1 61 0 13 1 65 0 41 1 65 0 94 1 65 0 140 1 65 0 141 1 65 0 238 1 65 1 0 1 65 1 2] 
#[1 1 69 0 13 1 73 0 41 1 73 0 94 1 73 0 140 1 73 0 141 1 73 0 238 1 73 1 0 1 73 1 2] 
#[0 1 77 0 110] 
#[1 1 81 0 13 1 89 0 145 1 89 0 241] 
#[1 1 93 0 9 1 97 0 10 1 101 0 13] 
#[1 1 105 0 13 1 113 0 145 1 113 0 243] 
#[1 1 117 0 13 1 121 0 140] 
#[1 1 125 0 1 1 129 0 3 1 133 0 5 1 137 0 13] 
#[1 1 141 0 13 1 145 0 140] 
#[0 1 149 0 50] 
#[1 1 153 0 27 1 157 0 28 1 161 0 31] 
#[1 1 165 0 9 1 169 0 10 1 173 0 13] 
#[1 1 177 0 2 1 181 0 4 1 185 0 13] 
#[1 1 189 0 13 1 197 0 74 1 197 0 240] 
#[1 1 201 0 13 1 205 0 140] 
#[0 1 209 0 50] 
#[1 1 213 0 13 1 217 0 59 1 221 0 78 1 225 0 92] 
#[1 1 229 0 13 1 233 0 41 1 233 0 94 1 233 0 140 1 233 0 141 1 233 0 238 1 233 1 0 1 233 1 2] 
#[0 1 237 0 142 0 236] 
#[1 1 241 0 13 1 245 0 41 1 245 0 94 1 245 0 140 1 245 0 141 1 245 0 238 1 245 1 0 1 245 1 2] 
#[1 1 249 0 13 1 253 0 41 1 253 0 94 1 253 0 140 1 253 0 141 1 253 0 238 1 253 1 0 1 253 1 2] 
#[1 2 1 0 9 2 5 0 10 2 9 0 13 2 13 0 46] 
#[0 2 17 0 24] 
#[1 2 21 0 13 2 25 0 140] 
#[1 2 29 0 13 2 33 0 35 2 37 0 36 2 41 0 46 2 45 0 53 2 49 0 60 2 53 0 104] 
#[1 2 57 0 13 2 61 0 140] 
#[1 2 65 0 9 2 69 0 10 2 73 0 13 2 77 0 46] 
#[1 2 81 0 9 2 85 0 10 2 89 0 13 2 93 0 46] 
#[1 2 97 0 13 2 101 0 41 2 101 0 94 2 101 0 140 2 101 0 141 2 101 0 238 2 101 1 0 2 101 1 2] 
#[0 2 105 0 252 1 2] 
#[1 2 113 0 6 2 117 0 13] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 2 133 0 157 0 42 1 2] 
#[1 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 2 137 0 155 0 213 0 206 0 38 1 2] 
#[1 0 46 0 8 0 46 0 12 0 46 0 17 0 46 0 19 0 46 0 20 0 46 0 21 0 46 0 27 0 46 0 28 0 46 0 30 0 46 0 31 0 46 0 34 0 46 0 37 0 46 0 38 0 46 0 42 0 46 0 46 0 46 0 47 0 46 0 54 0 46 0 56 0 46 0 57 0 46 0 68 0 46 0 70 0 46 0 71 0 46 0 77 0 46 0 87 0 46 0 91 0 46 0 96 0 46 0 99 0 46 0 101 0 46 0 106 0 46 0 108 0 46 0 109 0 46 0 114 0 46 0 115 0 46 0 116 0 46 0 122 0 46 0 129 2 141 0 202 0 46 1 1 0 46 1 2] 
#[0 0 50 0 17 0 68 0 106 1 2] 
#[0 2 145 0 93] 
#[1 2 149 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 2 153 0 80 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 2 157 0 155 2 161 0 200 0 209 0 203 0 213 0 206 0 38 1 2] 
#[0 2 165 0 142 0 236] 
#[0 2 169 0 6] 
#[1 2 173 0 29 2 177 0 62 2 181 0 102 2 185 0 130 2 189 0 250 2 189 1 2] 
#[0 2 197 0 76] 
#[1 2 201 0 6 2 205 0 70 2 209 0 76 2 217 0 142 2 217 0 239] 
#[1 2 221 0 6 2 225 0 132 2 233 0 142 2 229 0 193 2 233 0 239] 
#[1 2 237 0 6 2 225 0 132 2 245 0 142 2 241 0 193 2 245 0 239] 
#[0 2 249 0 142 0 236] 
#[0 2 253 0 76] 
#[1 3 1 0 6 3 5 0 70 3 9 0 76 3 13 0 142 3 13 0 239] 
#[1 0 54 0 6 3 17 0 70 3 21 0 76 0 54 0 132 3 25 0 142 3 25 0 163 3 25 0 239] 
#[0 0 58 0 6 0 7 0 8 0 18 0 22 0 26 0 43 0 44 0 45 0 49 0 52 0 61 0 72 0 75 0 83 0 84 0 88 0 89 0 112 0 124 0 126 0 127 0 128 0 134 0 135] 
#[1 0 62 0 7 0 62 0 8 3 33 0 154] 
#[0 0 66 0 7 0 8] 
#[1 3 125 0 22 3 125 0 26 3 125 0 43 3 125 0 44 3 125 0 45 3 125 0 52 3 125 0 61 3 125 0 72 3 125 0 75 3 125 0 83 3 125 0 84 3 125 0 88 3 125 0 89 3 125 0 112 3 125 0 124 3 125 0 126 3 125 0 127 3 125 0 128 3 125 0 134 3 125 0 135 3 117 0 167 3 121 0 189 3 125 0 191] 
#[0 3 129 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 0 70 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 37 0 38 0 39 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 73 0 76 0 77 0 87 0 91 0 96 0 99 0 101 0 102 0 105 0 106 0 108 0 109 0 114 0 115 0 116 0 117 0 122 0 129 0 130 0 137 1 1 1 2] 
#[0 0 74 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 37 0 38 0 39 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 73 0 76 0 77 0 87 0 91 0 96 0 99 0 101 0 102 0 105 0 106 0 108 0 109 0 114 0 115 0 116 0 117 0 122 0 129 0 130 0 137 1 1 1 2] 
#[0 0 78 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 37 0 38 0 39 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 73 0 76 0 77 0 87 0 91 0 96 0 99 0 101 0 102 0 105 0 106 0 108 0 109 0 114 0 115 0 116 0 117 0 122 0 129 0 130 0 137 1 1 1 2] 
#[0 0 82 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 37 0 38 0 39 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 73 0 76 0 77 0 87 0 91 0 96 0 99 0 101 0 102 0 105 0 106 0 108 0 109 0 114 0 115 0 116 0 117 0 122 0 129 0 130 0 137 1 1 1 2] 
#[0 0 86 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 90 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 94 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 3 133 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 0 98 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 3 137 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 0 102 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 3 141 0 13 3 145 0 145 3 145 0 241] 
#[0 3 149 0 145 0 241] 
#[0 0 106 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 37 0 38 0 39 0 42 0 46 0 47 0 54 0 56 0 57 0 65 0 68 0 70 0 71 0 73 0 76 0 77 0 87 0 91 0 93 0 94 0 96 0 99 0 101 0 102 0 105 0 106 0 108 0 109 0 114 0 115 0 116 0 117 0 122 0 129 0 130 0 137 1 1 1 2] 
#[0 0 110 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 114 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 118 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 3 153 0 9 3 157 0 10] 
#[0 3 161 0 145 0 243] 
#[0 0 122 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 37 0 38 0 39 0 42 0 46 0 47 0 54 0 56 0 57 0 65 0 68 0 70 0 71 0 73 0 76 0 77 0 87 0 91 0 93 0 94 0 96 0 99 0 101 0 102 0 105 0 106 0 108 0 109 0 114 0 115 0 116 0 117 0 122 0 129 0 130 0 137 1 1 1 2] 
#[0 0 126 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 3 165 0 140] 
#[0 0 130 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 134 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 138 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 142 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 3 169 0 1 3 173 0 3 3 177 0 5] 
#[0 3 181 0 140] 
#[0 0 146 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 3 185 0 13 3 189 0 140] 
#[0 3 193 0 110] 
#[1 3 197 0 13 3 201 0 145 3 201 0 241] 
#[1 3 205 0 13 3 209 0 145 3 209 0 243] 
#[0 0 150 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 154 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 3 213 0 9 3 217 0 10] 
#[0 0 158 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 162 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 3 221 0 2 3 225 0 4] 
#[0 3 229 0 74 0 240] 
#[0 0 166 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 170 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 3 233 0 140] 
#[0 0 174 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 3 237 0 13 3 241 0 140] 
#[1 3 245 0 59 3 249 0 78 3 253 0 92] 
#[0 0 178 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 182 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 186 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 4 1 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 0 190 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 194 0 12 1 1] 
#[0 4 5 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 0 198 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 4 9 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 0 202 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 206 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 210 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 4 13 0 9 4 17 0 10 4 21 0 46] 
#[0 0 214 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 0 218 0 12 0 218 0 17 4 25 0 66 0 218 0 68 0 222 0 76 4 29 0 81 4 33 0 82 4 37 0 103 0 218 0 106 4 41 0 207 0 218 1 1 0 218 1 2] 
#[0 4 45 0 140] 
#[0 0 226 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 4 49 0 35 4 53 0 36 4 57 0 46 4 61 0 53 4 65 0 60 4 69 0 104] 
#[0 0 230 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 234 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 238 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 242 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 246 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 0 250 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 4 73 0 140] 
#[0 0 254 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 2 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 6 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 4 77 0 9 4 81 0 10 4 85 0 46] 
#[0 1 10 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 14 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 18 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 4 89 0 9 4 93 0 10 4 97 0 46] 
#[0 1 22 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 4 101 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 1 26 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 1 30 0 8 1 30 0 12 1 30 0 17 1 30 0 19 1 30 0 20 1 30 0 21 1 30 0 27 1 30 0 28 1 30 0 30 1 30 0 31 1 30 0 34 1 30 0 37 1 30 0 38 1 30 0 42 1 30 0 46 1 30 0 47 1 30 0 54 1 30 0 56 1 30 0 57 1 30 0 68 1 30 0 70 1 30 0 71 1 30 0 77 1 30 0 87 1 30 0 91 1 30 0 96 1 30 0 99 1 30 0 101 1 30 0 106 1 30 0 108 1 30 0 109 1 30 0 114 1 30 0 115 1 30 0 116 4 105 0 117 1 30 0 122 1 30 0 129 1 30 1 1 1 30 1 2] 
#[0 1 34 0 6 0 7 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 117 0 122 0 129 1 1 1 2] 
#[0 4 109 0 142 0 236] 
#[0 4 113 0 6] 
#[0 1 38 0 17 1 2] 
#[0 1 42 0 17 1 2] 
#[0 1 46 0 17 1 2] 
#[1 4 121 0 17 4 121 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 4 125 0 157 0 42 1 2] 
#[1 4 129 0 8 1 54 0 12 1 54 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 1 54 0 68 0 137 0 70 0 141 0 71 0 145 0 77 0 153 0 87 0 157 0 91 0 161 0 96 1 54 0 99 0 169 0 101 1 54 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 4 133 0 201 4 137 0 203 1 54 1 1 1 54 1 2] 
#[0 4 141 0 58] 
#[1 0 229 0 29 0 233 0 39 0 237 0 62 0 241 0 64 0 245 0 70 0 249 0 76 4 145 0 80 1 1 0 102 1 5 0 113 1 9 0 130 1 25 0 142 4 149 0 159 1 21 0 195 1 25 0 237] 
#[0 4 153 0 142 0 236] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 4 157 0 157 0 42 1 2] 
#[1 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 4 161 0 155 0 213 0 206 0 38 1 2] 
#[1 4 165 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 4 169 0 80 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 4 173 0 155 4 177 0 200 0 209 0 203 0 213 0 206 0 38 1 2] 
#[0 4 181 0 245 1 2] 
#[0 4 189 0 6] 
#[0 4 193 0 76] 
#[0 4 197 0 76] 
#[1 0 54 0 6 4 201 0 70 4 205 0 76 0 54 0 132 4 209 0 142 4 209 0 163 4 209 0 239] 
#[1 4 213 0 29 4 217 0 62 4 221 0 102 4 225 0 130] 
#[0 1 58 0 29 0 62 0 102 0 130] 
#[1 4 229 0 6 4 233 0 142 4 233 0 239] 
#[1 4 237 0 6 4 245 0 142 4 241 0 192 4 245 0 237] 
#[1 4 249 0 6 4 253 0 142 4 253 0 239] 
#[1 5 1 0 6 5 5 0 142 5 5 0 239] 
#[0 1 62 0 6 0 132] 
#[0 5 9 0 6] 
#[1 4 237 0 6 4 245 0 142 5 13 0 192 4 245 0 237] 
#[1 5 17 0 23 5 21 0 66] 
#[0 5 25 0 6] 
#[1 5 29 0 6 2 225 0 132 5 33 0 193] 
#[1 4 237 0 6 4 245 0 142 5 37 0 192 4 245 0 237] 
#[0 5 41 0 6] 
#[1 5 45 0 6 2 225 0 132 5 49 0 193] 
#[0 5 53 0 7] 
#[1 5 57 0 6 2 225 0 132 5 61 0 193] 
#[1 4 237 0 6 4 245 0 142 5 65 0 192 4 245 0 237] 
#[1 5 69 0 6 5 73 0 142 5 73 0 239] 
#[1 5 77 0 6 5 81 0 142 5 81 0 239] 
#[0 5 85 0 6] 
#[1 0 54 0 6 0 54 0 132 5 89 0 142 5 89 0 163 5 89 0 239] 
#[1 0 54 0 6 0 54 0 132 5 93 0 142 5 93 0 163 5 93 0 239] 
#[1 1 66 0 6 2 225 0 132 5 97 0 164 5 101 0 193] 
#[0 1 70 0 6 0 132] 
#[1 5 105 0 7 5 109 0 8 5 113 0 153] 
#[0 1 74 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 78 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 82 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 86 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 90 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 94 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 98 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 102 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 106 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 110 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 114 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 118 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 122 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 126 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 130 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 134 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 138 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 142 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 146 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 150 0 6 0 7 0 8 0 17 0 20 0 27 0 28 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137 0 139] 
#[0 1 154 0 7 0 8] 
#[1 1 158 0 7 1 158 0 8 5 117 0 17 1 158 0 20 1 158 0 29 0 7 0 31 1 158 0 33 1 158 0 34 1 158 0 39 5 125 0 46 1 158 0 57 5 129 0 65 5 133 0 73 1 158 0 76 5 137 0 93 5 141 0 94 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 5 153 0 169] 
#[1 5 157 0 6 1 162 0 7 1 162 0 8 1 162 0 17 1 162 0 20 5 161 0 27 5 165 0 28 1 162 0 29 1 162 0 31 1 162 0 33 1 162 0 34 1 162 0 39 1 162 0 46 1 162 0 57 1 162 0 65 1 162 0 73 1 162 0 76 1 162 0 93 1 162 0 94 1 162 0 102 1 162 0 105 1 162 0 109 1 162 0 117 1 162 0 130 1 162 0 137 5 169 0 139] 
#[0 1 166 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 170 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 174 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 5 173 0 145 0 241] 
#[0 1 178 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 182 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 186 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 190 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 194 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 198 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 202 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 206 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 210 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 214 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 5 177 0 140] 
#[0 1 218 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 5 181 0 13 5 185 0 145 5 185 0 241] 
#[0 5 189 0 145 0 241] 
#[0 1 222 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 5 193 0 145 0 243] 
#[0 1 226 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 230 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 234 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 238 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 242 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 246 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 1 250 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 5 197 0 140] 
#[0 1 254 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 2 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 6 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 10 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 14 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 18 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 22 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 26 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 30 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 34 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 5 201 0 6] 
#[1 5 205 0 66 2 38 0 76] 
#[1 5 209 0 6 5 213 0 32] 
#[1 5 217 0 6 5 221 0 32] 
#[0 5 225 0 76] 
#[0 2 42 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 46 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 50 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 54 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 58 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 62 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 66 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 70 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 74 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 78 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 82 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 86 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 90 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 94 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 98 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 5 229 0 51 5 233 0 90] 
#[1 2 102 0 7 2 102 0 8 5 237 0 205] 
#[0 5 241 0 142 0 236] 
#[0 2 106 1 2] 
#[0 5 245 0 244 1 2] 
#[1 5 253 0 17 5 253 0 158 1 50 1 2] 
#[1 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 137 0 70 0 141 0 71 0 145 0 77 0 153 0 87 0 157 0 91 0 161 0 96 0 169 0 101 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 6 1 0 203] 
#[0 2 110 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 114 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 6 5 0 142 0 236] 
#[0 6 9 0 142 0 236] 
#[1 0 62 0 7 0 62 0 8 6 13 0 154] 
#[0 2 118 0 12 1 1] 
#[1 6 17 0 17 6 17 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 6 21 0 157 0 42 1 2] 
#[1 0 229 0 29 0 233 0 39 0 237 0 62 0 241 0 64 0 245 0 70 0 249 0 76 6 25 0 80 1 1 0 102 1 5 0 113 1 9 0 130 1 25 0 142 6 29 0 159 1 21 0 195 1 25 0 237] 
#[0 6 33 0 142 0 236] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 6 37 0 157 0 42 1 2] 
#[1 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 6 41 0 155 0 213 0 206 0 38 1 2] 
#[0 6 45 0 7] 
#[0 2 122 0 6 0 7 0 8 0 34 0 42 0 56 0 70 0 87 0 91 0 117 0 122] 
#[0 6 49 0 245 1 2] 
#[1 6 53 0 6 6 57 0 142 6 57 0 239] 
#[1 6 61 0 6 2 225 0 132 6 65 0 193] 
#[1 0 54 0 6 0 54 0 132 6 69 0 142 6 69 0 163 6 69 0 239] 
#[1 0 54 0 6 0 54 0 132 6 73 0 142 6 73 0 163 6 73 0 239] 
#[1 1 66 0 6 2 225 0 132 6 77 0 164 5 101 0 193] 
#[0 6 81 0 6] 
#[0 6 85 0 76] 
#[0 6 89 0 76] 
#[1 0 54 0 6 6 93 0 70 6 97 0 76 0 54 0 132 6 101 0 142 6 101 0 163 6 101 0 239] 
#[0 6 105 0 142 0 237] 
#[0 6 109 0 6] 
#[0 6 113 0 245 1 2] 
#[1 2 126 0 7 2 126 0 8 6 117 0 161] 
#[1 6 121 0 6 2 130 0 7 2 130 0 8 6 125 0 18 6 129 0 49] 
#[1 4 237 0 6 4 245 0 142 6 133 0 192 4 245 0 237] 
#[0 6 137 0 6] 
#[1 4 237 0 6 4 245 0 142 6 141 0 192 4 245 0 237] 
#[0 6 145 0 6] 
#[1 4 237 0 6 4 245 0 142 6 149 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 6 153 0 161] 
#[0 2 134 0 6 0 7 0 8] 
#[0 2 138 0 6 0 7 0 8] 
#[1 4 237 0 6 4 245 0 142 6 157 0 192 4 245 0 237] 
#[1 4 237 0 6 4 245 0 142 6 161 0 192 4 245 0 237] 
#[0 6 165 0 6] 
#[1 2 126 0 7 2 126 0 8 6 169 0 161] 
#[1 4 237 0 6 4 245 0 142 6 173 0 192 4 245 0 237] 
#[1 4 237 0 6 4 245 0 142 6 177 0 192 4 245 0 237] 
#[0 6 181 0 6] 
#[0 2 142 0 12 1 1] 
#[1 4 237 0 6 4 245 0 142 6 185 0 192 4 245 0 237] 
#[0 6 189 0 6] 
#[1 2 126 0 7 2 126 0 8 6 193 0 161] 
#[1 4 237 0 6 4 245 0 142 6 197 0 192 4 245 0 237] 
#[0 6 201 0 6] 
#[1 4 237 0 6 4 245 0 142 6 205 0 192 4 245 0 237] 
#[0 6 209 0 6] 
#[1 4 237 0 6 4 245 0 142 6 213 0 192 4 245 0 237] 
#[1 1 66 0 6 2 225 0 132 6 217 0 164 5 101 0 193] 
#[1 1 66 0 6 2 225 0 132 6 221 0 164 5 101 0 193] 
#[0 6 225 0 6] 
#[0 2 146 0 6] 
#[1 2 150 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 6 229 0 155 6 233 0 200 0 209 0 203 6 237 0 206 2 150 1 1 0 38 1 2] 
#[1 0 229 0 29 0 233 0 39 0 237 0 62 0 241 0 64 0 245 0 70 0 249 0 76 1 1 0 102 1 5 0 113 1 9 0 130 1 25 0 142 6 241 0 159 1 21 0 195 1 25 0 237] 
#[0 2 154 0 7 0 8] 
#[0 6 245 0 6] 
#[0 6 249 0 145 0 243] 
#[1 6 253 0 6 7 1 0 41 7 1 0 94 7 1 0 140 7 1 0 141 7 1 0 238] 
#[0 7 5 0 16] 
#[0 2 158 0 7 0 8 0 20 0 29 0 31 0 33 0 34 0 39 0 57 0 76 0 102 0 105 0 109 0 117 0 130] 
#[0 7 9 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 7 13 0 46 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 7 17 0 169] 
#[0 2 162 0 7 0 8 0 20 0 29 0 31 0 33 0 34 0 39 0 57 0 76 0 102 0 105 0 109 0 117 0 130] 
#[0 2 166 0 7 0 8 0 20 0 29 0 31 0 33 0 34 0 39 0 57 0 76 0 102 0 105 0 109 0 117 0 130] 
#[1 2 170 0 7 2 170 0 8 7 25 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 7 25 0 170] 
#[0 7 29 0 141] 
#[0 7 33 0 110] 
#[1 7 41 0 13 2 174 0 145 7 41 0 190] 
#[1 2 178 0 7 2 178 0 8 2 178 0 17 2 178 0 20 7 45 0 27 7 49 0 28 2 178 0 29 2 178 0 31 2 178 0 33 2 178 0 34 2 178 0 39 2 178 0 46 2 178 0 57 2 178 0 65 2 178 0 73 2 178 0 76 2 178 0 93 2 178 0 94 2 178 0 102 2 178 0 105 2 178 0 109 2 178 0 117 2 178 0 130 2 178 0 137] 
#[0 2 182 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 186 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 7 53 0 145 0 241] 
#[0 2 190 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 194 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 198 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 202 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 7 57 0 245 1 2] 
#[0 7 61 0 6] 
#[0 7 65 0 245 1 2] 
#[0 7 69 0 6] 
#[0 7 73 0 245 1 2] 
#[0 7 77 0 6] 
#[1 2 206 0 6 7 81 0 15 7 85 0 208 7 89 0 209] 
#[0 2 210 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 2 214 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 7 93 0 7 7 97 0 8 7 101 0 204] 
#[1 2 102 0 7 2 102 0 8 7 105 0 205] 
#[0 2 218 0 12 1 1] 
#[0 2 222 0 12 1 1] 
#[0 7 109 0 244 1 2] 
#[0 2 226 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[1 7 113 0 6 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 7 117 0 80 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 7 121 0 155 7 125 0 200 0 209 0 203 0 213 0 206 0 38 1 2] 
#[0 7 129 0 7] 
#[1 7 133 0 7 5 109 0 8 5 113 0 153] 
#[0 7 137 0 244 1 2] 
#[1 7 141 0 17 7 141 0 158 1 50 1 2] 
#[0 7 145 0 142 0 236] 
#[1 0 62 0 7 0 62 0 8 7 149 0 154] 
#[0 2 230 0 12 1 1] 
#[1 7 153 0 17 7 153 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 7 157 0 157 0 42 1 2] 
#[1 2 234 0 7 2 234 0 8 7 161 0 55 7 165 0 93] 
#[0 7 169 0 7] 
#[0 7 173 0 142 0 237] 
#[0 7 177 0 6] 
#[1 4 237 0 6 4 245 0 142 7 181 0 192 4 245 0 237] 
#[0 7 185 0 6] 
#[1 1 66 0 6 2 225 0 132 7 189 0 164 5 101 0 193] 
#[1 1 66 0 6 2 225 0 132 7 193 0 164 5 101 0 193] 
#[0 7 197 0 6] 
#[0 7 201 0 245 1 2] 
#[1 7 205 0 6 7 209 0 142 7 209 0 239] 
#[1 7 213 0 6 2 225 0 132 7 217 0 193] 
#[1 0 54 0 6 0 54 0 132 7 221 0 142 7 221 0 163 7 221 0 239] 
#[1 0 54 0 6 0 54 0 132 7 225 0 142 7 225 0 163 7 225 0 239] 
#[1 1 66 0 6 2 225 0 132 7 229 0 164 5 101 0 193] 
#[1 2 238 0 7 2 238 0 8 7 233 0 166] 
#[0 7 237 0 142 0 237] 
#[0 7 241 0 7] 
#[1 7 245 0 7 7 249 0 8 7 253 0 160] 
#[0 8 5 0 141 0 242] 
#[0 2 242 0 7 0 8] 
#[0 2 246 0 7 0 8] 
#[1 2 126 0 7 2 126 0 8 8 9 0 161] 
#[1 4 237 0 6 4 245 0 142 8 13 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 8 17 0 161] 
#[1 4 237 0 6 4 245 0 142 8 21 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 8 25 0 161] 
#[1 8 29 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 8 33 0 161] 
#[1 2 126 0 7 2 126 0 8 8 37 0 161] 
#[1 4 237 0 6 4 245 0 142 8 41 0 192 4 245 0 237] 
#[1 8 45 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 8 49 0 161] 
#[1 2 126 0 7 2 126 0 8 8 53 0 161] 
#[1 4 237 0 6 4 245 0 142 8 57 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 8 61 0 161] 
#[1 4 237 0 6 4 245 0 142 8 65 0 192 4 245 0 237] 
#[1 8 69 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 8 73 0 161] 
#[1 4 237 0 6 4 245 0 142 8 77 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 8 81 0 161] 
#[1 4 237 0 6 4 245 0 142 8 85 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 8 89 0 161] 
#[0 8 93 0 6] 
#[0 8 97 0 6] 
#[1 4 237 0 6 4 245 0 142 8 101 0 192 4 245 0 237] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 8 105 0 157 0 42 1 2] 
#[1 2 250 0 12 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 8 109 0 155 8 113 0 206 2 250 1 1 0 38 1 2] 
#[1 2 254 0 12 0 50 0 17 0 50 0 68 0 50 0 106 2 254 1 1 0 50 1 2] 
#[0 3 2 0 7 0 8] 
#[0 8 117 0 245 1 2] 
#[1 8 121 0 17 8 125 0 65] 
#[0 8 129 0 245 1 2] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 8 133 0 169] 
#[0 8 137 0 17] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 8 141 0 46 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 8 145 0 169] 
#[1 8 149 0 6 8 153 0 41 8 153 0 94 8 153 0 140 8 153 0 141 8 153 0 238] 
#[1 2 170 0 7 2 170 0 8 8 157 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 8 157 0 170] 
#[0 3 6 0 7 0 8 0 29 0 31 0 33 0 34 0 39 0 57 0 76 0 102 0 105 0 109 0 117 0 130] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 8 169 0 172] 
#[1 8 173 0 7 8 177 0 8] 
#[1 8 181 0 13 2 174 0 145 8 181 0 190] 
#[0 3 14 0 140 0 145] 
#[0 8 185 0 145 0 241] 
#[0 8 189 0 110] 
#[1 8 193 0 13 2 174 0 145 8 193 0 190] 
#[0 3 18 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 8 197 0 7] 
#[0 8 201 0 245 1 2] 
#[0 8 205 0 7] 
#[1 8 209 0 142 8 209 0 237 8 213 0 249] 
#[0 8 217 0 7] 
#[1 8 209 0 142 8 209 0 237 8 221 0 249] 
#[0 8 225 0 13] 
#[0 3 22 0 6] 
#[0 8 229 0 6] 
#[0 3 26 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 8 233 0 142 0 236] 
#[0 3 30 0 7 0 8] 
#[1 8 237 0 7 7 97 0 8 7 101 0 204] 
#[0 3 34 0 12 1 1] 
#[1 0 229 0 29 0 233 0 39 0 237 0 62 0 241 0 64 0 245 0 70 0 249 0 76 8 241 0 80 1 1 0 102 1 5 0 113 1 9 0 130 1 25 0 142 8 245 0 159 1 21 0 195 1 25 0 237] 
#[0 8 249 0 142 0 236] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 8 253 0 157 0 42 1 2] 
#[1 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 9 1 0 155 0 213 0 206 0 38 1 2] 
#[0 3 38 0 12 1 1] 
#[1 3 42 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 9 5 0 155 9 9 0 200 0 209 0 203 9 13 0 206 3 42 1 1 0 38 1 2] 
#[0 3 46 0 12 1 1] 
#[0 9 17 0 244 1 2] 
#[0 9 21 0 7] 
#[1 9 25 0 7 5 109 0 8 5 113 0 153] 
#[0 9 29 0 244 1 2] 
#[1 9 33 0 17 9 33 0 158 1 50 1 2] 
#[0 3 50 0 7 0 8] 
#[0 9 37 0 55] 
#[1 3 54 0 7 3 54 0 8 9 41 0 55 9 45 0 93] 
#[1 2 238 0 7 2 238 0 8 9 49 0 166] 
#[0 9 53 0 142 0 237] 
#[1 2 126 0 7 2 126 0 8 9 57 0 161] 
#[1 4 237 0 6 4 245 0 142 9 61 0 192 4 245 0 237] 
#[0 9 65 0 6] 
#[0 9 69 0 6] 
#[1 4 237 0 6 4 245 0 142 9 73 0 192 4 245 0 237] 
#[0 9 77 0 7] 
#[0 9 81 0 142 0 237] 
#[0 9 85 0 6] 
#[1 4 237 0 6 4 245 0 142 9 89 0 192 4 245 0 237] 
#[0 9 93 0 6] 
#[1 1 66 0 6 2 225 0 132 9 97 0 164 5 101 0 193] 
#[1 1 66 0 6 2 225 0 132 9 101 0 164 5 101 0 193] 
#[0 9 105 0 6] 
#[1 9 109 0 7 9 113 0 8 9 117 0 165] 
#[1 2 238 0 7 2 238 0 8 9 121 0 166] 
#[1 3 58 0 7 3 58 0 8 9 125 0 18 9 129 0 49] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 161 0 162 9 165 0 193 9 161 0 194] 
#[1 4 237 0 6 4 245 0 142 9 173 0 192 4 245 0 237] 
#[0 3 66 0 7 0 8] 
#[0 3 70 0 7] 
#[0 9 177 0 7] 
#[1 9 181 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 9 185 0 161] 
#[1 9 189 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 9 193 0 161] 
#[1 9 197 0 7 7 249 0 8 7 253 0 160] 
#[1 3 74 0 7 3 74 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 9 201 0 194] 
#[1 9 205 0 7 7 249 0 8 7 253 0 160] 
#[1 9 209 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 9 213 0 161] 
#[1 3 78 0 7 3 78 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 9 217 0 194] 
#[1 9 221 0 7 7 249 0 8 7 253 0 160] 
#[1 9 225 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 9 229 0 161] 
#[1 9 233 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 9 237 0 161] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 241 0 162 9 165 0 193 9 241 0 194] 
#[1 9 245 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 9 249 0 161] 
#[1 9 253 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 10 1 0 161] 
#[1 10 5 0 7 7 249 0 8 7 253 0 160] 
#[1 4 237 0 6 4 245 0 142 10 9 0 192 4 245 0 237] 
#[1 4 237 0 6 4 245 0 142 10 13 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 10 17 0 161] 
#[1 10 21 0 17 10 21 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 10 25 0 157 0 42 1 2] 
#[1 3 82 0 12 0 50 0 17 0 50 0 68 0 50 0 106 3 82 1 1 0 50 1 2] 
#[0 10 29 0 7] 
#[0 10 33 0 6] 
#[0 10 37 0 16] 
#[0 10 41 0 7] 
#[1 2 170 0 7 2 170 0 8 10 45 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 10 45 0 170] 
#[0 10 49 0 6] 
#[1 10 53 0 6 10 57 0 41 10 57 0 94 10 57 0 140 10 57 0 141 10 57 0 238] 
#[1 2 170 0 7 2 170 0 8 10 61 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 10 61 0 170] 
#[0 10 65 0 245 1 2] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 10 69 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 10 73 0 172] 
#[1 3 86 0 7 3 86 0 8 3 86 0 29 3 86 0 31 3 86 0 33 3 86 0 34 3 86 0 39 3 86 0 57 0 11 0 76 3 86 0 102 3 86 0 105 3 86 0 109 3 86 0 117] 
#[0 3 90 0 7 0 8 0 29 0 31 0 33 0 34 0 39 0 57 0 76 0 102 0 105 0 109 0 117] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 10 93 0 174] 
#[1 3 98 0 7 3 98 0 8 3 98 0 17 3 98 0 20 10 97 0 27 10 101 0 28 3 98 0 29 3 98 0 31 3 98 0 33 3 98 0 34 3 98 0 39 3 98 0 46 3 98 0 57 3 98 0 65 3 98 0 73 3 98 0 76 3 98 0 93 3 98 0 94 3 98 0 102 3 98 0 105 3 98 0 109 3 98 0 117 3 98 0 130 3 98 0 137 10 105 0 139] 
#[0 10 109 0 141] 
#[0 10 113 0 145 0 241] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 10 125 0 178] 
#[1 10 129 0 13 2 174 0 145 10 129 0 190] 
#[0 10 133 0 145 0 241] 
#[0 3 106 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 10 137 0 7] 
#[1 10 141 0 100 3 110 0 119 10 145 0 210 10 149 0 211] 
#[0 10 153 0 8] 
#[0 10 157 0 7] 
#[0 3 114 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 10 161 0 7] 
#[1 10 165 0 10 10 169 0 11] 
#[1 8 209 0 142 8 209 0 237 10 173 0 249] 
#[0 3 118 0 7 0 8] 
#[0 3 122 0 8 0 12 0 17 0 19 0 20 0 21 0 27 0 28 0 30 0 31 0 34 0 37 0 38 0 42 0 46 0 47 0 54 0 56 0 57 0 68 0 70 0 71 0 77 0 87 0 91 0 96 0 99 0 101 0 106 0 108 0 109 0 114 0 115 0 116 0 122 0 129 1 1 1 2] 
#[0 10 177 0 142 0 236] 
#[1 0 62 0 7 0 62 0 8 10 181 0 154] 
#[0 3 126 0 12 1 1] 
#[1 10 185 0 17 10 185 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 10 189 0 157 0 42 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 10 193 0 157 0 42 1 2] 
#[1 3 130 0 12 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 10 197 0 155 10 201 0 206 3 130 1 1 0 38 1 2] 
#[1 3 134 0 12 0 50 0 17 0 50 0 68 0 50 0 106 3 134 1 1 0 50 1 2] 
#[0 3 138 0 12 1 1] 
#[0 3 142 0 12 1 1] 
#[1 3 146 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 10 205 0 155 10 209 0 200 0 209 0 203 10 213 0 206 3 146 1 1 0 38 1 2] 
#[0 3 150 0 12 1 1] 
#[0 10 217 0 244 1 2] 
#[0 3 154 0 7 0 8] 
#[0 3 158 0 7 0 8] 
#[0 10 221 0 55] 
#[1 10 225 0 7 9 113 0 8 9 117 0 165] 
#[1 2 238 0 7 2 238 0 8 10 229 0 166] 
#[1 10 233 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 10 237 0 161] 
#[1 4 237 0 6 4 245 0 142 10 241 0 192 4 245 0 237] 
#[1 4 237 0 6 4 245 0 142 10 245 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 10 249 0 161] 
#[1 3 162 0 7 3 162 0 8 10 253 0 55 11 1 0 93] 
#[1 2 238 0 7 2 238 0 8 11 5 0 166] 
#[0 11 9 0 142 0 237] 
#[1 2 126 0 7 2 126 0 8 11 13 0 161] 
#[1 4 237 0 6 4 245 0 142 11 17 0 192 4 245 0 237] 
#[0 11 21 0 6] 
#[0 11 25 0 6] 
#[1 4 237 0 6 4 245 0 142 11 29 0 192 4 245 0 237] 
#[1 11 33 0 105 11 37 0 196] 
#[0 11 41 0 142 0 237] 
#[0 3 166 0 7 0 8] 
#[1 11 45 0 7 9 113 0 8 9 117 0 165] 
#[0 3 170 0 7 0 8] 
#[0 3 174 0 7 0 8] 
#[0 11 49 0 140] 
#[1 11 53 0 13 11 57 0 140] 
#[0 3 178 0 7 0 8] 
#[1 11 61 0 13 11 65 0 41 11 65 0 94 11 65 0 140 11 65 0 141 11 65 0 238 11 65 1 0 11 65 1 2] 
#[1 11 69 0 13 11 73 0 140] 
#[0 3 182 0 7 0 8] 
#[0 11 77 0 97] 
#[0 3 186 0 7 0 8] 
#[0 3 190 0 7 0 8] 
#[0 3 194 0 7 0 8] 
#[0 3 198 0 7 0 8] 
#[1 3 202 0 7 3 202 0 8 11 81 0 18 11 85 0 49] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 11 89 0 162 9 165 0 193 11 89 0 194] 
#[1 11 93 0 7 7 249 0 8 7 253 0 160] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 11 97 0 162 9 165 0 193 11 97 0 194] 
#[1 11 101 0 7 7 249 0 8 7 253 0 160] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 11 105 0 162 9 165 0 193 11 105 0 194] 
#[0 3 206 0 7 0 8] 
#[1 3 210 0 7 3 210 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 11 109 0 194] 
#[1 3 214 0 7 3 214 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 11 113 0 194] 
#[1 11 117 0 7 7 249 0 8 7 253 0 160] 
#[0 3 218 0 7 0 8] 
#[1 3 222 0 7 3 222 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 11 121 0 194] 
#[1 3 226 0 7 3 226 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 11 125 0 194] 
#[1 11 129 0 7 7 249 0 8 7 253 0 160] 
#[1 3 230 0 7 3 230 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 11 133 0 194] 
#[1 11 137 0 7 7 249 0 8 7 253 0 160] 
#[0 3 234 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 11 141 0 162 9 165 0 193 11 141 0 194] 
#[1 11 145 0 7 7 249 0 8 7 253 0 160] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 11 149 0 162 9 165 0 193 11 149 0 194] 
#[1 11 153 0 7 7 249 0 8 7 253 0 160] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 11 157 0 162 9 165 0 193 11 157 0 194] 
#[1 2 126 0 7 2 126 0 8 11 161 0 161] 
#[1 2 126 0 7 2 126 0 8 11 165 0 161] 
#[1 11 169 0 7 7 249 0 8 7 253 0 160] 
#[0 11 173 0 244 1 2] 
#[1 11 177 0 17 11 177 0 158 1 50 1 2] 
#[1 11 181 0 118 11 185 0 136] 
#[0 11 189 0 245 1 2] 
#[0 11 193 0 17] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 11 197 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 11 201 0 172] 
#[0 11 205 0 245 1 2] 
#[0 11 209 0 245 1 2] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 11 213 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 11 217 0 172] 
#[0 11 221 0 7] 
#[1 2 170 0 7 2 170 0 8 11 225 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 11 225 0 170] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 11 229 0 174] 
#[0 3 238 0 7 0 8 0 29 0 31 0 33 0 34 0 39 0 57 0 76 0 102 0 105 0 109 0 117] 
#[0 3 242 0 7 0 8 0 29 0 31 0 33 0 34 0 39 0 57 0 105 0 109 0 117] 
#[0 11 233 0 76] 
#[0 3 246 0 7 0 8 0 29 0 31 0 33 0 34 0 39 0 57 0 105 0 109 0 117] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 11 245 0 175 11 245 0 176] 
#[0 11 249 0 110] 
#[1 11 253 0 13 2 174 0 145 11 253 0 190] 
#[1 3 254 0 7 3 254 0 8 3 254 0 17 3 254 0 20 12 1 0 27 12 5 0 28 3 254 0 29 3 254 0 31 3 254 0 33 3 254 0 34 3 254 0 39 3 254 0 46 3 254 0 57 3 254 0 65 3 254 0 73 3 254 0 76 3 254 0 93 3 254 0 94 3 254 0 102 3 254 0 105 3 254 0 109 3 254 0 117 3 254 0 130 3 254 0 137] 
#[0 12 9 0 7] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 12 13 0 178] 
#[0 12 17 0 145 0 243] 
#[0 4 2 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 4 6 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 12 21 0 145 0 241] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 12 25 0 178] 
#[0 4 10 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 12 33 0 141 0 253] 
#[0 4 14 0 119] 
#[0 12 37 0 119] 
#[0 12 41 0 142 0 237] 
#[1 10 141 0 100 3 110 0 119 10 145 0 210 12 45 0 211] 
#[0 4 18 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 4 22 0 6] 
#[0 4 26 0 6] 
#[0 12 49 0 7] 
#[0 12 53 0 7] 
#[1 12 57 0 7 5 109 0 8 5 113 0 153] 
#[0 12 61 0 244 1 2] 
#[1 12 65 0 17 12 65 0 158 1 50 1 2] 
#[1 12 69 0 17 12 69 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 12 73 0 157 0 42 1 2] 
#[1 4 30 0 12 0 50 0 17 0 50 0 68 0 50 0 106 4 30 1 1 0 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 12 77 0 157 0 42 1 2] 
#[1 4 34 0 12 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 12 81 0 155 12 85 0 206 4 34 1 1 0 38 1 2] 
#[1 4 38 0 12 0 50 0 17 0 50 0 68 0 50 0 106 4 38 1 1 0 50 1 2] 
#[0 4 42 0 12 1 1] 
#[0 4 46 0 7 0 8] 
#[1 11 33 0 105 12 89 0 196] 
#[1 12 93 0 7 9 113 0 8 9 117 0 165] 
#[1 4 50 0 7 4 50 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 12 97 0 194] 
#[1 12 101 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 12 105 0 161] 
#[1 2 126 0 7 2 126 0 8 12 109 0 161] 
#[1 12 113 0 7 7 249 0 8 7 253 0 160] 
#[0 4 54 0 7 0 8] 
#[0 12 117 0 55] 
#[1 12 121 0 7 9 113 0 8 9 117 0 165] 
#[1 2 238 0 7 2 238 0 8 12 125 0 166] 
#[1 12 129 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 12 133 0 161] 
#[1 4 237 0 6 4 245 0 142 12 137 0 192 4 245 0 237] 
#[1 4 237 0 6 4 245 0 142 12 141 0 192 4 245 0 237] 
#[1 2 126 0 7 2 126 0 8 12 145 0 161] 
#[0 12 149 0 142 0 236] 
#[0 4 58 0 7 0 8] 
#[0 4 62 0 7 0 8] 
#[1 11 33 0 105 12 153 0 196] 
#[0 4 66 0 7 0 8] 
#[0 12 157 0 140] 
#[0 4 70 0 7 0 8] 
#[0 12 161 0 41 0 94 0 140 0 141 0 238 1 0 1 2] 
#[0 4 74 0 7 0 8] 
#[0 12 165 0 140] 
#[0 4 78 0 7 0 8] 
#[0 12 173 0 145 0 251] 
#[0 4 82 0 7 0 8] 
#[0 4 86 0 7 0 8] 
#[0 4 90 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 12 177 0 162 9 165 0 193 12 177 0 194] 
#[0 4 94 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 12 181 0 162 9 165 0 193 12 181 0 194] 
#[0 4 98 0 7 0 8] 
#[0 4 102 0 7 0 8] 
#[0 4 106 0 7 0 8] 
#[1 4 110 0 7 4 110 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 12 185 0 194] 
#[0 4 114 0 7 0 8] 
#[0 4 118 0 7 0 8] 
#[1 4 122 0 7 4 122 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 12 189 0 194] 
#[0 4 126 0 7 0 8] 
#[1 4 130 0 7 4 130 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 12 193 0 194] 
#[0 4 134 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 12 197 0 162 9 165 0 193 12 197 0 194] 
#[0 4 138 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 12 201 0 162 9 165 0 193 12 201 0 194] 
#[0 4 142 0 7 0 8] 
#[1 12 205 0 7 7 249 0 8 7 253 0 160] 
#[1 12 209 0 7 7 249 0 8 7 253 0 160] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 12 213 0 162 9 165 0 193 12 213 0 194] 
#[0 4 146 0 12 1 1] 
#[0 12 217 0 244 1 2] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 12 221 0 93 12 225 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 12 229 0 169] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 12 233 0 93 12 237 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 12 241 0 169] 
#[0 12 245 0 7] 
#[0 12 249 0 6] 
#[1 2 170 0 7 2 170 0 8 12 253 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 12 253 0 170] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 13 1 0 174] 
#[0 13 5 0 7] 
#[0 13 9 0 7] 
#[1 2 170 0 7 2 170 0 8 13 13 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 13 13 0 170] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 13 17 0 174] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 13 21 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 13 25 0 172] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 13 29 0 175 13 29 0 176] 
#[0 4 150 0 7 0 8 0 29 0 31 0 33 0 34 0 39 0 57 0 105 0 109 0 117] 
#[0 13 33 0 140] 
#[0 4 154 0 7 0 8 0 29 0 31 0 33 0 39 0 57 0 105 0 109 0 117] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 13 37 0 178] 
#[1 13 41 0 13 2 174 0 145 13 41 0 190] 
#[0 13 45 0 145 0 241] 
#[0 13 49 0 110] 
#[1 13 53 0 13 2 174 0 145 13 53 0 190] 
#[1 4 158 0 7 4 158 0 8 4 158 0 17 4 158 0 20 13 57 0 27 13 61 0 28 4 158 0 29 4 158 0 31 4 158 0 33 4 158 0 34 4 158 0 39 4 158 0 46 4 158 0 57 4 158 0 65 4 158 0 73 4 158 0 76 4 158 0 93 4 158 0 94 4 158 0 102 4 158 0 105 4 158 0 109 4 158 0 117 4 158 0 130 4 158 0 137 13 65 0 139] 
#[0 4 162 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 4 166 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 13 69 0 178] 
#[0 4 170 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 4 174 0 6 0 119] 
#[0 4 178 0 119] 
#[0 13 73 0 24] 
#[0 4 182 0 7] 
#[0 13 77 0 119] 
#[0 4 186 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 4 190 0 12 1 1] 
#[1 4 194 0 12 0 38 0 17 0 73 0 19 0 77 0 20 0 81 0 21 0 85 0 27 0 89 0 28 0 93 0 30 0 97 0 31 0 101 0 34 0 105 0 37 0 109 0 38 0 113 0 42 0 117 0 46 0 121 0 47 0 125 0 54 0 129 0 56 0 133 0 57 0 38 0 68 0 137 0 70 0 141 0 71 0 145 0 77 0 153 0 87 0 157 0 91 0 161 0 96 0 165 0 99 0 169 0 101 0 38 0 106 0 173 0 108 0 177 0 109 0 181 0 114 0 185 0 115 0 189 0 116 0 193 0 122 0 197 0 129 13 81 0 155 13 85 0 200 0 209 0 203 13 89 0 206 4 194 1 1 0 38 1 2] 
#[0 4 198 0 12 1 1] 
#[0 13 93 0 244 1 2] 
#[0 13 97 0 244 1 2] 
#[1 13 101 0 17 13 101 0 158 1 50 1 2] 
#[1 13 105 0 17 13 105 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 13 109 0 157 0 42 1 2] 
#[1 4 202 0 12 0 50 0 17 0 50 0 68 0 50 0 106 4 202 1 1 0 50 1 2] 
#[0 4 206 0 7 0 8] 
#[1 11 33 0 105 13 113 0 196] 
#[0 4 210 0 7 0 8] 
#[1 4 214 0 7 4 214 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 13 117 0 194] 
#[1 13 121 0 7 7 249 0 8 7 253 0 160] 
#[1 13 125 0 7 7 249 0 8 7 253 0 160] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 13 129 0 162 9 165 0 193 13 129 0 194] 
#[0 4 218 0 7 0 8] 
#[1 11 33 0 105 13 133 0 196] 
#[1 13 137 0 7 9 113 0 8 9 117 0 165] 
#[1 4 222 0 7 4 222 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 13 141 0 194] 
#[1 13 145 0 7 7 249 0 8 7 253 0 160] 
#[1 2 126 0 7 2 126 0 8 13 149 0 161] 
#[1 2 126 0 7 2 126 0 8 13 153 0 161] 
#[1 13 157 0 7 7 249 0 8 7 253 0 160] 
#[0 13 161 0 6] 
#[0 4 226 0 7 0 8] 
#[0 4 230 0 7 0 8] 
#[0 4 234 0 7 0 8] 
#[0 4 238 0 7 0 8] 
#[0 4 242 0 7 0 8] 
#[0 4 246 0 7 0 8] 
#[0 4 250 0 7 0 8] 
#[0 4 254 0 7 0 8] 
#[0 5 2 0 7 0 8] 
#[0 5 6 0 7 0 8] 
#[0 5 10 0 7 0 8] 
#[0 5 14 0 7 0 8] 
#[0 5 18 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 13 165 0 162 9 165 0 193 13 165 0 194] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 13 169 0 162 9 165 0 193 13 169 0 194] 
#[0 5 22 0 7 0 8] 
#[0 5 26 0 12 1 1] 
#[0 13 173 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 13 177 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 13 181 0 172] 
#[0 13 185 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 13 189 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 13 193 0 172] 
#[1 13 197 0 118 13 201 0 136] 
#[0 13 205 0 245 1 2] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 13 209 0 172] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 13 213 0 175 13 213 0 176] 
#[1 13 217 0 118 13 221 0 136] 
#[1 1 158 0 7 1 158 0 8 1 158 0 20 1 158 0 29 1 158 0 31 1 158 0 33 1 158 0 34 1 158 0 39 1 158 0 57 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 109 1 158 0 117 1 158 0 130 5 145 0 137 5 149 0 168 13 225 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 13 229 0 172] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 13 233 0 175 13 233 0 176] 
#[1 2 170 0 7 2 170 0 8 13 237 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 13 237 0 170] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 13 241 0 174] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 13 245 0 178] 
#[0 5 30 0 7 0 8 0 29 0 31 0 33 0 39 0 57 0 105 0 109 0 117] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 14 1 0 180] 
#[0 14 5 0 145 0 241] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 14 9 0 178] 
#[1 14 13 0 13 2 174 0 145 14 13 0 190] 
#[0 14 17 0 145 0 241] 
#[0 14 21 0 110] 
#[1 14 25 0 13 2 174 0 145 14 25 0 190] 
#[1 5 38 0 7 5 38 0 8 5 38 0 17 5 38 0 20 14 29 0 27 14 33 0 28 5 38 0 29 5 38 0 31 5 38 0 33 5 38 0 34 5 38 0 39 5 38 0 46 5 38 0 57 5 38 0 65 5 38 0 73 5 38 0 76 5 38 0 93 5 38 0 94 5 38 0 102 5 38 0 105 5 38 0 109 5 38 0 117 5 38 0 130 5 38 0 137] 
#[0 5 42 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[1 0 222 0 66 14 37 0 81 14 41 0 207] 
#[0 14 45 0 24] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 14 49 0 157 0 42 1 2] 
#[1 5 46 0 12 0 38 0 17 0 38 0 68 0 165 0 99 0 38 0 106 14 53 0 155 14 57 0 206 5 46 1 1 0 38 1 2] 
#[1 5 50 0 12 0 50 0 17 0 50 0 68 0 50 0 106 5 50 1 1 0 50 1 2] 
#[0 5 54 0 12 1 1] 
#[0 5 58 0 12 1 1] 
#[0 14 61 0 244 1 2] 
#[0 14 65 0 244 1 2] 
#[1 14 69 0 17 14 69 0 158 1 50 1 2] 
#[0 5 62 0 7 0 8] 
#[0 5 66 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 14 73 0 162 9 165 0 193 14 73 0 194] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 14 77 0 162 9 165 0 193 14 77 0 194] 
#[0 5 70 0 7 0 8] 
#[0 5 74 0 7 0 8] 
#[1 11 33 0 105 14 81 0 196] 
#[0 5 78 0 7 0 8] 
#[1 5 82 0 7 5 82 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 9 165 0 193 14 85 0 194] 
#[1 14 89 0 7 7 249 0 8 7 253 0 160] 
#[1 14 93 0 7 7 249 0 8 7 253 0 160] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 14 97 0 162 9 165 0 193 14 97 0 194] 
#[1 4 237 0 6 4 245 0 142 14 101 0 192 4 245 0 237] 
#[0 5 86 0 7 0 8] 
#[0 5 90 0 7 0 8] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 14 105 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 14 109 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 14 113 0 174] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 14 117 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 14 121 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 14 125 0 174] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 14 129 0 93 14 133 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 14 137 0 169] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 14 141 0 93 14 145 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 14 149 0 169] 
#[0 14 153 0 7] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 14 157 0 174] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 14 161 0 178] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 14 165 0 93 14 169 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 14 173 0 169] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 14 177 0 93 14 181 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 14 185 0 169] 
#[1 2 170 0 7 2 170 0 8 14 189 0 20 2 170 0 29 2 170 0 31 2 170 0 33 2 170 0 34 2 170 0 39 2 170 0 57 2 170 0 76 2 170 0 102 2 170 0 105 2 170 0 109 2 170 0 117 2 170 0 130 14 189 0 170] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 14 193 0 174] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 14 197 0 178] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 14 201 0 172] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 14 205 0 175 14 205 0 176] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 14 209 0 180] 
#[1 14 213 0 46 14 217 0 53 14 221 0 60] 
#[0 5 94 0 7 0 8 0 29 0 39 0 57 0 105 0 109 0 117] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 14 233 0 182] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 14 237 0 178] 
#[0 5 102 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 14 241 0 145 0 241] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 14 245 0 178] 
#[1 14 249 0 13 2 174 0 145 14 249 0 190] 
#[0 14 253 0 145 0 241] 
#[0 15 1 0 110] 
#[1 15 5 0 13 2 174 0 145 15 5 0 190] 
#[1 2 38 0 66 15 9 0 76] 
#[0 15 13 0 66] 
#[1 0 222 0 66 15 17 0 81 15 21 0 207] 
#[1 15 25 0 17 15 25 0 158 1 50 1 2] 
#[1 0 42 0 17 2 121 0 68 2 125 0 106 2 129 0 156 15 29 0 157 0 42 1 2] 
#[1 5 106 0 12 0 50 0 17 0 50 0 68 0 50 0 106 5 106 1 1 0 50 1 2] 
#[0 5 110 0 12 1 1] 
#[0 5 114 0 12 1 1] 
#[0 15 33 0 244 1 2] 
#[0 5 118 0 7 0 8] 
#[0 5 122 0 7 0 8] 
#[0 5 126 0 7 0 8] 
#[0 5 130 0 7 0 8] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 15 37 0 162 9 165 0 193 15 37 0 194] 
#[1 3 62 0 7 3 62 0 8 9 133 0 34 9 137 0 57 9 141 0 73 9 145 0 77 9 149 0 109 2 225 0 132 9 153 0 137 9 157 0 138 15 41 0 162 9 165 0 193 15 41 0 194] 
#[0 5 134 0 7 0 8] 
#[1 2 126 0 7 2 126 0 8 15 45 0 161] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 15 49 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 15 53 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 15 57 0 175 15 57 0 176] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 15 61 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 15 65 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 15 69 0 175 15 69 0 176] 
#[0 15 73 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 15 77 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 15 81 0 172] 
#[0 15 85 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 15 89 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 15 93 0 172] 
#[1 15 97 0 118 15 101 0 136] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 15 105 0 175 15 105 0 176] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 15 109 0 180] 
#[0 15 113 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 15 117 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 15 121 0 172] 
#[0 15 125 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 15 129 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 15 133 0 172] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 31 3 10 0 33 3 10 0 34 3 10 0 39 3 10 0 57 3 10 0 76 3 10 0 102 3 10 0 105 3 10 0 109 3 10 0 117 8 161 0 130 8 165 0 171 15 137 0 172] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 15 141 0 175 15 141 0 176] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 15 145 0 180] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 15 149 0 174] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 15 153 0 178] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 15 157 0 182] 
#[0 5 138 0 7 0 8 0 29 0 39 0 57 0 105 0 109 0 117] 
#[0 5 142 0 7 0 8 0 29 0 39 0 57 0 105 0 109 0 117] 
#[0 5 146 0 7 0 8 0 29 0 39 0 57 0 105 0 109 0 117] 
#[1 15 161 0 13 15 165 0 140] 
#[0 5 150 0 7 0 8 0 29 0 39 0 105 0 109 0 117] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 15 177 0 184] 
#[0 5 158 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 15 181 0 178] 
#[0 5 162 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 15 185 0 145 0 241] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 15 189 0 178] 
#[1 15 193 0 13 2 174 0 145 15 193 0 190] 
#[0 15 197 0 145 0 241] 
#[1 2 206 0 6 7 81 0 15 7 85 0 208 15 201 0 209] 
#[0 15 205 0 6] 
#[1 2 38 0 66 15 209 0 76] 
#[0 15 213 0 66] 
#[0 15 217 0 244 1 2] 
#[1 15 221 0 17 15 221 0 158 1 50 1 2] 
#[0 5 166 0 12 1 1] 
#[0 5 170 0 7 0 8] 
#[0 5 174 0 7 0 8] 
#[1 15 225 0 7 7 249 0 8 7 253 0 160] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 15 229 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 15 233 0 175 15 233 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 15 237 0 187 15 241 0 196] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 15 245 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 15 249 0 175 15 249 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 15 253 0 187 15 241 0 196] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 1 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 5 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 16 9 0 174] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 13 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 17 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 16 21 0 174] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 16 25 0 93 16 29 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 33 0 169] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 16 37 0 93 16 41 0 94 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 45 0 169] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 16 49 0 178] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 16 53 0 182] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 57 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 61 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 16 65 0 174] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 69 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 73 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 16 77 0 174] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 31 3 94 0 33 3 94 0 34 3 94 0 39 3 94 0 57 10 81 0 76 10 85 0 102 3 94 0 105 3 94 0 109 3 94 0 117 10 89 0 173 16 81 0 174] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 16 85 0 178] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 16 89 0 182] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 16 93 0 175 16 93 0 176] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 16 97 0 180] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 16 101 0 184] 
#[0 16 105 0 140] 
#[0 5 182 0 7 0 8 0 29 0 39 0 105 0 109 0 117] 
#[1 16 109 0 13 16 113 0 140] 
#[0 5 186 0 7 0 8 0 29 0 39 0 105 0 117] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 16 125 0 186] 
#[0 5 194 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 16 129 0 178] 
#[0 5 198 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 16 133 0 145 0 241] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 16 137 0 178] 
#[0 16 141 0 6] 
#[0 16 145 0 245 1 2] 
#[1 2 206 0 6 7 81 0 15 7 85 0 208 16 149 0 209] 
#[0 16 153 0 6] 
#[0 5 202 0 12 1 1] 
#[0 16 157 0 244 1 2] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 16 161 0 85 16 165 0 95 16 169 0 197 16 173 0 198] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 16 177 0 175 16 177 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 16 181 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 16 189 0 188 16 193 0 195] 
#[0 5 214 0 7 0 8 0 29 0 39] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 16 197 0 175 16 197 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 16 201 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 16 205 0 188 16 193 0 195] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 209 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 16 213 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 16 217 0 175 16 217 0 176] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 221 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 16 225 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 16 229 0 175 16 229 0 176] 
#[0 16 233 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 237 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 241 0 172] 
#[0 16 245 0 94] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 16 249 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 16 253 0 172] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 17 1 0 180] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 17 5 0 184] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 17 9 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 13 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 17 17 0 175 17 17 0 176] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 17 21 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 25 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 17 29 0 175 17 29 0 176] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 3 250 0 31 3 250 0 33 11 237 0 34 3 250 0 39 3 250 0 57 3 250 0 105 3 250 0 109 3 250 0 117 17 33 0 175 17 33 0 176] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 17 37 0 180] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 17 41 0 184] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 17 45 0 178] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 17 49 0 182] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 17 53 0 186] 
#[0 5 218 0 7 0 8 0 29 0 39 0 105 0 109 0 117] 
#[0 17 57 0 140] 
#[0 5 222 0 7 0 8 0 29 0 39 0 105 0 117] 
#[1 17 61 0 51 17 65 0 90] 
#[0 5 226 0 7 0 8 0 29 0 39 0 105] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 69 0 187 15 241 0 196] 
#[0 5 230 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[1 3 102 0 7 3 102 0 8 3 102 0 17 3 102 0 20 3 102 0 29 0 15 0 31 3 102 0 33 3 102 0 34 3 102 0 39 3 102 0 46 3 102 0 57 3 102 0 65 3 102 0 73 3 102 0 76 3 102 0 93 3 102 0 94 3 102 0 102 3 102 0 105 3 102 0 109 3 102 0 117 3 102 0 130 3 102 0 137 10 121 0 177 17 73 0 178] 
#[0 5 234 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[1 8 209 0 142 8 209 0 237 17 77 0 249] 
#[0 17 81 0 7] 
#[0 17 85 0 6] 
#[0 17 89 0 245 1 2] 
#[0 5 238 0 12 1 1] 
#[1 17 93 0 63 17 97 0 98 17 101 0 111] 
#[1 17 105 0 48 17 109 0 131] 
#[0 5 242 0 7 0 8 0 29 0 39] 
#[0 5 246 0 7 0 8 0 29 0 39] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 113 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 17 117 0 188 16 193 0 195] 
#[1 2 173 0 29 17 121 0 250 17 121 1 2] 
#[0 5 250 0 7 0 8] 
#[0 5 254 0 7 0 8] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 125 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 17 129 0 188 16 193 0 195] 
#[0 6 2 0 7 0 8] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 133 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 17 137 0 175 17 137 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 141 0 187 15 241 0 196] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 145 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 17 149 0 175 17 149 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 153 0 187 15 241 0 196] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 17 157 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 17 161 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 165 0 174] 
#[1 1 158 0 7 1 158 0 8 1 158 0 29 1 158 0 34 1 158 0 39 5 133 0 73 1 158 0 76 1 158 0 102 1 158 0 105 1 158 0 130 5 145 0 137 5 149 0 168 17 169 0 169] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 17 173 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 177 0 174] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 17 181 0 182] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 17 185 0 186] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 189 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 17 193 0 175 17 193 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 197 0 187 15 241 0 196] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 17 201 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 17 205 0 175 17 205 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 209 0 187 15 241 0 196] 
#[1 3 102 0 7 3 102 0 8 3 102 0 29 10 117 0 31 3 102 0 33 3 102 0 39 3 102 0 57 3 102 0 105 3 102 0 109 3 102 0 117 10 121 0 177 17 213 0 178] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 17 217 0 182] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 17 221 0 186] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 17 225 0 180] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 17 229 0 184] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 17 233 0 187 15 241 0 196] 
#[0 6 6 0 7 0 8 0 29 0 39 0 105 0 117] 
#[0 6 10 0 7 0 8 0 29 0 39 0 105] 
#[0 6 14 0 7 0 8 0 29 0 39 0 105] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 17 237 0 188 16 193 0 195] 
#[0 6 18 0 7 0 8 0 17 0 20 0 29 0 31 0 33 0 34 0 39 0 46 0 57 0 65 0 73 0 76 0 93 0 94 0 102 0 105 0 109 0 117 0 130 0 137] 
#[0 17 241 0 7] 
#[1 6 22 0 6 17 245 0 120 17 249 0 212 17 253 0 213] 
#[1 8 209 0 142 8 209 0 237 18 1 0 249] 
#[0 18 5 0 7] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 18 9 0 95 16 169 0 197 18 13 0 198] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 18 17 0 95 16 169 0 197 18 21 0 198] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 18 25 0 95 16 169 0 197 18 29 0 198] 
#[1 18 33 0 25 18 37 0 92 18 41 0 107 18 45 0 110 18 49 0 199] 
#[1 18 33 0 25 18 37 0 92 18 41 0 107 18 45 0 110 18 53 0 199] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 57 0 188 16 193 0 195] 
#[0 6 26 0 7 0 8] 
#[0 4 213 0 29] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 61 0 188 16 193 0 195] 
#[0 6 30 0 7 0 8] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 65 0 175 18 65 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 69 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 73 0 188 16 193 0 195] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 77 0 175 18 77 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 81 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 85 0 188 16 193 0 195] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 18 89 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 18 93 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 97 0 175 18 97 0 176] 
#[1 3 10 0 7 3 10 0 8 3 10 0 29 3 10 0 34 3 10 0 39 3 10 0 76 3 10 0 102 3 10 0 105 8 161 0 130 8 165 0 171 18 101 0 172] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 18 105 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 109 0 175 18 109 0 176] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 18 113 0 184] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 117 0 187 15 241 0 196] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 121 0 175 18 121 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 125 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 129 0 188 16 193 0 195] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 133 0 175 18 133 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 137 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 141 0 188 16 193 0 195] 
#[1 5 34 0 7 5 34 0 8 5 34 0 29 13 249 0 33 5 34 0 39 5 34 0 57 5 34 0 105 5 34 0 109 5 34 0 117 13 253 0 179 18 145 0 180] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 18 149 0 184] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 153 0 187 15 241 0 196] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 18 157 0 182] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 18 161 0 186] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 165 0 188 16 193 0 195] 
#[0 6 34 0 7 0 8] 
#[1 6 22 0 6 17 245 0 120 17 249 0 212 18 169 0 213] 
#[0 18 173 0 141 0 253] 
#[0 6 38 0 6] 
#[0 18 177 0 6] 
#[0 18 181 0 7] 
#[1 6 22 0 6 17 245 0 120 17 249 0 212 18 185 0 213] 
#[1 18 189 0 48 17 109 0 131] 
#[0 6 42 0 7 0 8 0 29 0 39] 
#[1 18 193 0 48 17 109 0 131] 
#[0 6 46 0 7 0 8 0 29 0 39] 
#[1 18 197 0 48 17 109 0 131] 
#[0 6 50 0 7 0 8 0 29 0 39] 
#[0 6 54 0 7 0 8 0 29 0 39 0 95] 
#[0 18 201 0 14] 
#[0 6 58 0 7 0 8 0 29 0 39 0 95] 
#[1 18 205 0 46 18 209 0 94] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 18 213 0 95 16 169 0 197 18 217 0 198] 
#[0 6 62 0 7 0 8 0 29 0 39] 
#[0 6 66 0 7 0 8] 
#[0 6 70 0 7 0 8] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 221 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 225 0 188 16 193 0 195] 
#[0 6 74 0 7 0 8] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 229 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 18 233 0 188 16 193 0 195] 
#[0 6 78 0 7 0 8] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 18 237 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 241 0 175 18 241 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 18 245 0 187 15 241 0 196] 
#[1 3 94 0 7 3 94 0 8 3 94 0 29 3 94 0 34 3 94 0 39 10 81 0 76 10 85 0 102 3 94 0 105 10 89 0 173 18 249 0 174] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 18 253 0 175 18 253 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 1 0 187 15 241 0 196] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 19 5 0 186] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 9 0 188 16 193 0 195] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 13 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 17 0 188 16 193 0 195] 
#[0 6 82 0 7 0 8] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 21 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 25 0 188 16 193 0 195] 
#[0 6 86 0 7 0 8] 
#[1 5 98 0 7 5 98 0 8 5 98 0 29 5 98 0 39 14 225 0 57 5 98 0 105 5 98 0 109 5 98 0 117 14 229 0 181 19 29 0 182] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 19 33 0 186] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 37 0 188 16 193 0 195] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 19 41 0 184] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 45 0 187 15 241 0 196] 
#[0 6 90 0 7 0 8] 
#[0 19 49 0 6] 
#[0 6 94 0 6] 
#[1 19 53 0 99 19 57 0 216] 
#[1 6 22 0 6 17 245 0 120 17 249 0 212 19 61 0 213] 
#[0 19 65 0 6] 
#[1 18 33 0 25 18 37 0 92 18 41 0 107 18 45 0 110 19 69 0 199] 
#[1 18 33 0 25 18 37 0 92 18 41 0 107 18 45 0 110 19 73 0 199] 
#[1 18 33 0 25 18 37 0 92 18 41 0 107 18 45 0 110 19 77 0 199] 
#[0 6 98 0 7 0 8 0 29 0 39 0 95] 
#[0 6 102 0 7 0 8 0 29 0 39 0 95] 
#[0 6 106 0 7 0 8 0 29 0 39 0 95] 
#[0 17 109 0 131] 
#[0 6 110 0 7 0 8 0 29 0 39] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 81 0 188 16 193 0 195] 
#[0 6 114 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 85 0 188 16 193 0 195] 
#[0 6 118 0 7 0 8] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 19 89 0 175 19 89 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 93 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 97 0 188 16 193 0 195] 
#[1 3 250 0 7 3 250 0 8 3 250 0 29 11 237 0 34 3 250 0 39 3 250 0 105 19 101 0 175 19 101 0 176] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 105 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 109 0 188 16 193 0 195] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 113 0 187 15 241 0 196] 
#[0 6 122 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 117 0 188 16 193 0 195] 
#[0 6 126 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 121 0 188 16 193 0 195] 
#[0 6 130 0 7 0 8] 
#[1 5 154 0 7 5 154 0 8 5 154 0 29 5 154 0 39 5 154 0 105 15 169 0 109 5 154 0 117 15 173 0 183 19 125 0 184] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 129 0 187 15 241 0 196] 
#[0 6 134 0 7 0 8] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 19 133 0 186] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 137 0 188 16 193 0 195] 
#[1 19 53 0 99 19 141 0 216] 
#[0 19 145 0 254 1 2] 
#[1 6 138 0 7 6 138 0 8 19 153 0 215] 
#[0 19 157 0 6] 
#[1 19 53 0 99 19 161 0 216] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 18 213 0 95 16 169 0 197 19 165 0 198] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 18 213 0 95 16 169 0 197 19 169 0 198] 
#[1 5 206 0 7 5 206 0 8 5 206 0 29 5 206 0 39 18 213 0 95 16 169 0 197 19 173 0 198] 
#[0 6 142 0 7 0 8] 
#[0 6 146 0 7 0 8] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 177 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 181 0 188 16 193 0 195] 
#[0 6 150 0 7 0 8] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 185 0 187 15 241 0 196] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 189 0 188 16 193 0 195] 
#[0 6 154 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 193 0 188 16 193 0 195] 
#[0 6 158 0 7 0 8] 
#[0 6 162 0 7 0 8] 
#[1 5 190 0 7 5 190 0 8 5 190 0 29 5 190 0 39 5 190 0 105 16 117 0 117 16 121 0 185 19 197 0 186] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 201 0 188 16 193 0 195] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 19 205 0 187 15 241 0 196] 
#[0 6 166 0 7 0 8] 
#[1 6 138 0 7 6 138 0 8 19 209 0 215] 
#[1 6 170 0 6 6 170 0 7 6 170 0 8 6 170 0 34 6 170 0 42 19 213 0 56 6 170 0 70 6 170 0 87 6 170 0 91 19 217 0 117 6 170 0 122 19 221 0 133 19 225 0 217 19 229 0 218] 
#[0 6 174 0 6 0 7 0 8 0 34 0 42 0 56 0 70 0 87 0 91 0 117 0 122 0 133] 
#[1 19 233 0 7 19 237 0 8 19 241 0 214] 
#[1 19 53 0 99 19 245 0 216] 
#[1 6 138 0 7 6 138 0 8 19 249 0 215] 
#[0 6 178 0 7 0 8 0 29 0 39] 
#[0 6 182 0 7 0 8 0 29 0 39] 
#[0 6 186 0 7 0 8 0 29 0 39] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 19 253 0 188 16 193 0 195] 
#[0 6 190 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 20 1 0 188 16 193 0 195] 
#[0 6 194 0 7 0 8] 
#[0 6 198 0 7 0 8] 
#[1 5 178 0 7 5 178 0 8 5 178 0 29 5 178 0 39 11 33 0 105 20 5 0 187 15 241 0 196] 
#[0 6 202 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 20 9 0 188 16 193 0 195] 
#[1 20 13 0 7 19 237 0 8 19 241 0 214] 
#[1 20 17 0 13 20 21 0 74 20 21 0 240] 
#[0 20 25 0 56] 
#[1 20 29 0 69 20 33 0 79] 
#[0 6 206 0 6 0 7 0 8 0 34 0 42 0 70 0 87 0 91 0 122] 
#[1 6 210 0 6 6 210 0 7 6 210 0 8 20 37 0 34 6 210 0 42 6 210 0 70 6 210 0 87 6 210 0 91 6 210 0 122 20 41 0 219 20 45 0 220] 
#[0 6 214 0 12 0 17 0 68 0 106 1 1 1 2] 
#[1 19 53 0 99 20 49 0 216] 
#[0 6 218 0 7 0 8] 
#[1 6 138 0 7 6 138 0 8 20 53 0 215] 
#[1 20 57 0 7 19 237 0 8 19 241 0 214] 
#[0 6 222 0 7 0 8] 
#[0 6 226 0 7 0 8] 
#[1 5 210 0 7 5 210 0 8 0 229 0 29 16 185 0 39 20 61 0 188 16 193 0 195] 
#[0 6 230 0 7 0 8] 
#[0 6 234 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 20 65 0 74 0 240] 
#[0 6 238 0 6 0 7 0 8 0 34 0 42 0 70 0 87 0 91 0 122] 
#[1 20 69 0 13 20 73 0 74 20 73 0 240] 
#[0 20 77 0 6] 
#[0 20 81 0 125] 
#[1 20 85 0 13 20 89 0 140] 
#[0 6 242 0 6 0 7 0 8 0 42 0 70 0 87 0 91 0 122] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 20 101 0 222] 
#[0 6 250 0 7 0 8] 
#[1 20 105 0 7 19 237 0 8 19 241 0 214] 
#[0 6 254 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 7 2 0 7 0 8] 
#[0 7 6 0 6 0 7 0 8 0 34 0 42 0 70 0 87 0 91 0 122] 
#[0 20 109 0 74 0 240] 
#[0 7 10 0 6 0 7 0 8 0 34 0 42 0 70 0 87 0 91 0 122] 
#[1 7 14 0 7 20 113 0 245 20 117 0 246 20 113 1 2] 
#[1 20 121 0 6 7 14 0 7 20 125 0 86 20 113 0 245 20 129 0 246 20 113 1 2] 
#[0 20 133 0 140] 
#[0 7 18 0 6 0 7 0 8 0 42 0 70 0 87 0 91 0 122] 
#[0 20 137 0 50] 
#[0 7 22 0 6 0 7 0 8 0 70 0 87 0 91 0 122] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 20 149 0 224] 
#[0 7 30 0 12 0 17 0 68 0 106 1 1 1 2] 
#[0 7 34 0 6 0 7 0 8 0 34 0 42 0 70 0 87 0 91 0 122] 
#[1 7 38 0 7 7 38 0 8 20 153 0 248] 
#[0 20 157 0 7] 
#[0 20 161 0 245 1 2] 
#[1 6 170 0 6 6 170 0 7 6 170 0 8 6 170 0 34 6 170 0 42 19 213 0 56 6 170 0 70 6 170 0 87 6 170 0 91 19 217 0 117 6 170 0 122 19 225 0 217 20 165 0 218] 
#[0 20 169 0 7] 
#[0 7 42 0 6 0 7 0 8 0 42 0 70 0 87 0 91 0 122] 
#[1 20 173 0 13 20 177 0 140] 
#[0 20 181 0 50] 
#[0 7 46 0 6 0 7 0 8 0 87 0 91 0 122] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 20 193 0 226] 
#[1 7 54 0 7 20 197 0 8 20 201 0 247] 
#[1 6 170 0 6 6 170 0 7 6 170 0 8 6 170 0 34 6 170 0 42 19 213 0 56 6 170 0 70 6 170 0 87 6 170 0 91 19 217 0 117 6 170 0 122 19 225 0 217 20 205 0 218] 
#[1 6 170 0 6 6 170 0 7 6 170 0 8 6 170 0 34 6 170 0 42 19 213 0 56 6 170 0 70 6 170 0 87 6 170 0 91 19 217 0 117 6 170 0 122 19 225 0 217 20 209 0 218] 
#[1 6 210 0 6 6 210 0 7 6 210 0 8 20 37 0 34 6 210 0 42 6 210 0 70 6 210 0 87 6 210 0 91 6 210 0 122 20 41 0 219 20 213 0 220] 
#[1 6 170 0 6 6 170 0 7 6 170 0 8 6 170 0 34 6 170 0 42 19 213 0 56 6 170 0 70 6 170 0 87 6 170 0 91 19 217 0 117 6 170 0 122 19 225 0 217 20 217 0 218] 
#[0 20 221 0 140] 
#[0 7 58 0 6 0 7 0 8 0 70 0 87 0 91 0 122] 
#[1 20 225 0 13 20 229 0 140] 
#[1 20 233 0 13 20 237 0 141] 
#[0 7 62 0 6 0 7 0 8 0 91 0 122] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 20 249 0 228] 
#[0 20 253 0 245 1 2] 
#[0 7 70 0 7 0 8] 
#[1 6 210 0 6 6 210 0 7 6 210 0 8 20 37 0 34 6 210 0 42 6 210 0 70 6 210 0 87 6 210 0 91 6 210 0 122 20 41 0 219 21 1 0 220] 
#[1 6 210 0 6 6 210 0 7 6 210 0 8 20 37 0 34 6 210 0 42 6 210 0 70 6 210 0 87 6 210 0 91 6 210 0 122 20 41 0 219 21 5 0 220] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 21 9 0 222] 
#[1 6 210 0 6 6 210 0 7 6 210 0 8 20 37 0 34 6 210 0 42 6 210 0 70 6 210 0 87 6 210 0 91 6 210 0 122 20 41 0 219 21 13 0 220] 
#[0 7 74 0 6 0 7 0 8 0 70 0 87 0 91 0 122] 
#[0 21 17 0 140] 
#[0 7 78 0 6 0 7 0 8 0 87 0 91 0 122] 
#[0 21 21 0 141] 
#[0 7 82 0 6 0 7 0 8 0 91 0 122] 
#[1 21 25 0 13 21 29 0 141] 
#[0 7 86 0 6 0 7 0 8 0 122] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 21 41 0 230] 
#[0 7 94 0 7 0 8] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 21 45 0 222] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 21 49 0 222] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 21 53 0 224] 
#[1 6 246 0 6 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 21 57 0 222] 
#[0 7 98 0 6 0 7 0 8 0 87 0 91 0 122] 
#[0 7 102 0 6 0 7 0 8 0 91 0 122] 
#[0 21 61 0 141] 
#[0 7 106 0 6 0 7 0 8 0 122] 
#[1 21 65 0 13 21 69 0 252 21 69 1 2] 
#[0 7 110 0 6 0 7 0 8] 
#[1 21 73 0 6 7 114 0 7 7 114 0 8 21 77 0 231 21 81 0 232] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 21 85 0 224] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 21 89 0 224] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 21 93 0 226] 
#[1 7 26 0 6 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 21 97 0 224] 
#[0 7 118 0 6 0 7 0 8 0 122] 
#[0 21 101 0 252 1 2] 
#[0 7 122 0 6 0 7 0 8] 
#[1 21 105 0 119 21 109 0 235] 
#[0 7 126 0 7 0 8] 
#[0 7 130 0 7 0 8] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 21 113 0 226] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 21 117 0 226] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 21 121 0 228] 
#[1 7 50 0 6 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 21 125 0 226] 
#[0 7 134 0 6 0 7 0 8] 
#[0 21 129 0 255 1 2] 
#[1 7 138 0 7 7 138 0 8 21 137 0 234] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 21 141 0 228] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 21 145 0 228] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 21 149 0 230] 
#[1 7 66 0 6 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 21 153 0 228] 
#[1 6 246 0 7 6 246 0 8 21 157 0 34 20 93 0 42 21 161 0 56 6 246 0 70 6 246 0 87 6 246 0 91 21 165 0 117 6 246 0 122 20 97 0 221 21 169 0 222] 
#[0 7 142 0 7 0 8 0 34 0 42 0 56 0 70 0 87 0 91 0 117 0 122] 
#[1 21 173 0 7 21 177 0 8 21 181 0 233] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 21 185 0 230] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 21 189 0 230] 
#[1 21 73 0 6 7 114 0 7 7 114 0 8 21 77 0 231 21 193 0 232] 
#[1 7 90 0 6 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 21 197 0 230] 
#[1 21 201 0 13 2 174 0 140 21 201 0 190] 
#[1 21 205 0 13 21 209 0 74 21 209 0 240] 
#[0 21 213 0 56] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 21 217 0 224] 
#[0 7 146 0 7 0 8] 
#[1 21 105 0 119 21 221 0 235] 
#[0 7 150 0 7 0 8] 
#[1 21 73 0 6 7 114 0 7 7 114 0 8 21 77 0 231 21 225 0 232] 
#[1 21 73 0 6 7 114 0 7 7 114 0 8 21 77 0 231 21 229 0 232] 
#[0 7 154 0 7 0 8] 
#[1 21 73 0 6 7 114 0 7 7 114 0 8 21 77 0 231 21 233 0 232] 
#[0 21 237 0 140] 
#[0 21 241 0 74 0 240] 
#[1 6 246 0 7 6 246 0 8 21 245 0 34 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 21 249 0 222] 
#[1 21 253 0 13 22 1 0 74 22 1 0 240] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 5 0 226] 
#[0 7 158 0 7 0 8] 
#[0 7 162 0 7 0 8] 
#[0 7 166 0 7 0 8] 
#[0 7 170 0 7 0 8] 
#[1 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 9 0 222] 
#[1 6 246 0 7 6 246 0 8 22 13 0 34 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 17 0 222] 
#[1 22 21 0 13 2 174 0 140 22 21 0 190] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 25 0 224] 
#[0 22 29 0 74 0 240] 
#[1 6 246 0 7 6 246 0 8 22 33 0 34 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 37 0 222] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 41 0 228] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 45 0 224] 
#[1 22 49 0 13 2 174 0 140 22 49 0 190] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 53 0 224] 
#[0 22 57 0 140] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 61 0 226] 
#[1 6 246 0 7 6 246 0 8 22 65 0 34 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 69 0 222] 
#[1 22 73 0 13 2 174 0 140 22 73 0 190] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 77 0 224] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 81 0 230] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 85 0 226] 
#[0 22 89 0 140] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 93 0 226] 
#[1 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 97 0 222] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 101 0 228] 
#[1 22 105 0 13 2 174 0 140 22 105 0 190] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 109 0 224] 
#[0 22 113 0 140] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 117 0 226] 
#[0 7 174 0 7 0 8] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 121 0 228] 
#[1 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 125 0 222] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 129 0 228] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 133 0 224] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 137 0 230] 
#[0 22 141 0 140] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 145 0 226] 
#[1 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 149 0 222] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 153 0 228] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 157 0 230] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 161 0 224] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 165 0 230] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 169 0 226] 
#[0 7 178 0 7 0 8] 
#[1 6 246 0 7 6 246 0 8 20 93 0 42 6 246 0 70 6 246 0 87 6 246 0 91 6 246 0 122 20 97 0 221 22 173 0 222] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 177 0 228] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 181 0 224] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 185 0 230] 
#[0 7 182 0 7 0 8] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 189 0 226] 
#[0 7 186 0 7 0 8] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 193 0 228] 
#[1 7 26 0 7 7 26 0 8 20 141 0 70 7 26 0 87 7 26 0 91 7 26 0 122 20 145 0 223 22 197 0 224] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 201 0 230] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 205 0 226] 
#[0 7 190 0 7 0 8] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 209 0 228] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 213 0 230] 
#[1 7 50 0 7 7 50 0 8 20 185 0 87 7 50 0 91 7 50 0 122 20 189 0 225 22 217 0 226] 
#[0 7 194 0 7 0 8] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 221 0 228] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 225 0 230] 
#[0 7 198 0 7 0 8] 
#[1 7 66 0 7 7 66 0 8 20 241 0 91 7 66 0 122 20 245 0 227 22 229 0 228] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 233 0 230] 
#[0 7 202 0 7 0 8] 
#[1 7 90 0 7 7 90 0 8 21 33 0 122 21 37 0 229 22 237 0 230] 
#[0 7 206 0 7 0 8] 
#[0 7 210 0 7 0 8]
	).
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable10: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 3) to: result tableNames.
	result likeToken: (nodes at: 4).
	result addToken: (nodes at: 5) to: result tableNames.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable34: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result tableNames.
	result addToken: (nodes at: 4) to: result leftParens.
	result likeToken: (nodes at: 5).
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
	result likeToken: (nodes at: 7).
	result addToken: (nodes at: 8) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
	result addToken: (nodes at: 7) to: result leftParens.
	result likeToken: (nodes at: 8).
	result addToken: (nodes at: 9) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
	result likeToken: (nodes at: 5).
	result addToken: (nodes at: 6) to: result tableNames.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable38: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result temporaryToken: (nodes at: 2).
	result tableToken: (nodes at: 3).
	result addToken: (nodes at: 4) to: result tableNames.
	result addToken: (nodes at: 5) to: result leftParens.
	result likeToken: (nodes at: 6).
	result addToken: (nodes at: 7) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
	result likeToken: (nodes at: 8).
	result addToken: (nodes at: 9) to: result tableNames.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable3: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 7) to: result tableNames.
	result addToken: (nodes at: 8) to: result leftParens.
	result likeToken: (nodes at: 9).
	result addToken: (nodes at: 10) to: result tableNames.
	result addToken: (nodes at: 11) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForCreateTable4: nodes [
	| result |
	result := MysqlCreateTableNode new.
	result createToken: (nodes at: 1).
	result tableToken: (nodes at: 2).
	result addToken: (nodes at: 3) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 6) to: result tableNames.
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
	result addToken: (nodes at: 4) to: result tableNames.
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
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 23).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 27).
	result at: 53 put: (nodes at: 6).
	result at: 2 put: ((nodes at: 7) at: 1).
	result at: 3 put: ((nodes at: 7) at: 2).
	result at: 5 put: ((nodes at: 8) at: 1).
	self add: ((nodes at: 8) at: 2) to: (result at: 6).
	self add: ((nodes at: 9) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 9) at: 2).
	result at: 8 put: (nodes at: 10).
	result at: 21 put: ((nodes at: 11) at: 1).
	result at: 22 put: ((nodes at: 11) at: 2).
	self addAll: ((nodes at: 11) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 11) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 11) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 11) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 11) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 11) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 11) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 11) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 11) at: 11).
	self addAll: ((nodes at: 11) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 11) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 11) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 11) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 11) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 11) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 11) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 11) at: 19).
	result at: 40 put: ((nodes at: 11) at: 20).
	result at: 41 put: ((nodes at: 11) at: 21).
	result at: 42 put: ((nodes at: 11) at: 22).
	result at: 43 put: ((nodes at: 11) at: 23).
	result at: 44 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 12) at: 3).
	self add: ((nodes at: 12) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 12) at: 5).
	self add: ((nodes at: 12) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 12) at: 7).
	result at: 49 put: ((nodes at: 12) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition11: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 23).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 27).
	result at: 53 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 47).
	self add: (nodes at: 8) to: (result at: 35).
	result at: 2 put: ((nodes at: 9) at: 1).
	result at: 3 put: ((nodes at: 9) at: 2).
	result at: 5 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 6).
	self add: ((nodes at: 11) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 11) at: 2).
	result at: 8 put: (nodes at: 12).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 13) at: 11).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 13) at: 19).
	result at: 40 put: ((nodes at: 13) at: 20).
	result at: 41 put: ((nodes at: 13) at: 21).
	result at: 42 put: ((nodes at: 13) at: 22).
	result at: 43 put: ((nodes at: 13) at: 23).
	result at: 44 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 14) at: 7).
	result at: 49 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition12: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 23).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 27).
	result at: 53 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 35).
	result at: 2 put: ((nodes at: 8) at: 1).
	result at: 3 put: ((nodes at: 8) at: 2).
	result at: 5 put: ((nodes at: 9) at: 1).
	self add: ((nodes at: 9) at: 2) to: (result at: 6).
	self add: ((nodes at: 10) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 10) at: 2).
	result at: 8 put: (nodes at: 11).
	result at: 21 put: ((nodes at: 12) at: 1).
	result at: 22 put: ((nodes at: 12) at: 2).
	self addAll: ((nodes at: 12) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 12) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 12) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 12) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 12) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 12) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 12) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 12) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 12) at: 11).
	self addAll: ((nodes at: 12) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 12) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 12) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 12) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 12) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 12) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 12) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 12) at: 19).
	result at: 40 put: ((nodes at: 12) at: 20).
	result at: 41 put: ((nodes at: 12) at: 21).
	result at: 42 put: ((nodes at: 12) at: 22).
	result at: 43 put: ((nodes at: 12) at: 23).
	result at: 44 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 13) at: 3).
	self add: ((nodes at: 13) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 13) at: 5).
	self add: ((nodes at: 13) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 13) at: 7).
	result at: 49 put: ((nodes at: 13) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition13: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 23).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 27).
	result at: 54 put: (nodes at: 6).
	result at: 2 put: ((nodes at: 7) at: 1).
	result at: 3 put: ((nodes at: 7) at: 2).
	result at: 5 put: ((nodes at: 8) at: 1).
	self add: ((nodes at: 8) at: 2) to: (result at: 6).
	self add: ((nodes at: 9) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 9) at: 2).
	result at: 8 put: (nodes at: 10).
	result at: 21 put: ((nodes at: 11) at: 1).
	result at: 22 put: ((nodes at: 11) at: 2).
	self addAll: ((nodes at: 11) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 11) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 11) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 11) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 11) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 11) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 11) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 11) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 11) at: 11).
	self addAll: ((nodes at: 11) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 11) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 11) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 11) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 11) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 11) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 11) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 11) at: 19).
	result at: 40 put: ((nodes at: 11) at: 20).
	result at: 41 put: ((nodes at: 11) at: 21).
	result at: 42 put: ((nodes at: 11) at: 22).
	result at: 43 put: ((nodes at: 11) at: 23).
	result at: 44 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 12) at: 3).
	self add: ((nodes at: 12) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 12) at: 5).
	self add: ((nodes at: 12) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 12) at: 7).
	result at: 49 put: ((nodes at: 12) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition14: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 23).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 27).
	result at: 54 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 47).
	self add: (nodes at: 8) to: (result at: 35).
	result at: 2 put: ((nodes at: 9) at: 1).
	result at: 3 put: ((nodes at: 9) at: 2).
	result at: 5 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 6).
	self add: ((nodes at: 11) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 11) at: 2).
	result at: 8 put: (nodes at: 12).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 13) at: 11).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 13) at: 19).
	result at: 40 put: ((nodes at: 13) at: 20).
	result at: 41 put: ((nodes at: 13) at: 21).
	result at: 42 put: ((nodes at: 13) at: 22).
	result at: 43 put: ((nodes at: 13) at: 23).
	result at: 44 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 14) at: 7).
	result at: 49 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition15: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 51 put: (nodes at: 2).
	self add: (nodes at: 3) to: (result at: 23).
	result at: 52 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 27).
	result at: 54 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 35).
	result at: 2 put: ((nodes at: 8) at: 1).
	result at: 3 put: ((nodes at: 8) at: 2).
	result at: 5 put: ((nodes at: 9) at: 1).
	self add: ((nodes at: 9) at: 2) to: (result at: 6).
	self add: ((nodes at: 10) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 10) at: 2).
	result at: 8 put: (nodes at: 11).
	result at: 21 put: ((nodes at: 12) at: 1).
	result at: 22 put: ((nodes at: 12) at: 2).
	self addAll: ((nodes at: 12) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 12) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 12) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 12) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 12) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 12) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 12) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 12) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 12) at: 11).
	self addAll: ((nodes at: 12) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 12) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 12) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 12) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 12) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 12) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 12) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 12) at: 19).
	result at: 40 put: ((nodes at: 12) at: 20).
	result at: 41 put: ((nodes at: 12) at: 21).
	result at: 42 put: ((nodes at: 12) at: 22).
	result at: 43 put: ((nodes at: 12) at: 23).
	result at: 44 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 13) at: 3).
	self add: ((nodes at: 13) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 13) at: 5).
	self add: ((nodes at: 13) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 13) at: 7).
	result at: 49 put: ((nodes at: 13) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition16: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 53 put: (nodes at: 8).
	result at: 2 put: ((nodes at: 9) at: 1).
	result at: 3 put: ((nodes at: 9) at: 2).
	result at: 5 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 6).
	self add: ((nodes at: 11) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 11) at: 2).
	result at: 8 put: (nodes at: 12).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 13) at: 11).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 13) at: 19).
	result at: 40 put: ((nodes at: 13) at: 20).
	result at: 41 put: ((nodes at: 13) at: 21).
	result at: 42 put: ((nodes at: 13) at: 22).
	result at: 43 put: ((nodes at: 13) at: 23).
	result at: 44 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 14) at: 7).
	result at: 49 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition17: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 47).
	self add: (nodes at: 10) to: (result at: 35).
	result at: 2 put: ((nodes at: 11) at: 1).
	result at: 3 put: ((nodes at: 11) at: 2).
	result at: 5 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 6).
	self add: ((nodes at: 13) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 13) at: 2).
	result at: 8 put: (nodes at: 14).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 15) at: 11).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 15) at: 19).
	result at: 40 put: ((nodes at: 15) at: 20).
	result at: 41 put: ((nodes at: 15) at: 21).
	result at: 42 put: ((nodes at: 15) at: 22).
	result at: 43 put: ((nodes at: 15) at: 23).
	result at: 44 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 16) at: 7).
	result at: 49 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition18: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 35).
	result at: 2 put: ((nodes at: 10) at: 1).
	result at: 3 put: ((nodes at: 10) at: 2).
	result at: 5 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 6).
	self add: ((nodes at: 12) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 12) at: 2).
	result at: 8 put: (nodes at: 13).
	result at: 21 put: ((nodes at: 14) at: 1).
	result at: 22 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 14) at: 11).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 14) at: 19).
	result at: 40 put: ((nodes at: 14) at: 20).
	result at: 41 put: ((nodes at: 14) at: 21).
	result at: 42 put: ((nodes at: 14) at: 22).
	result at: 43 put: ((nodes at: 14) at: 23).
	result at: 44 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 15) at: 7).
	result at: 49 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition19: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 54 put: (nodes at: 8).
	result at: 2 put: ((nodes at: 9) at: 1).
	result at: 3 put: ((nodes at: 9) at: 2).
	result at: 5 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 6).
	self add: ((nodes at: 11) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 11) at: 2).
	result at: 8 put: (nodes at: 12).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 13) at: 11).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 13) at: 19).
	result at: 40 put: ((nodes at: 13) at: 20).
	result at: 41 put: ((nodes at: 13) at: 21).
	result at: 42 put: ((nodes at: 13) at: 22).
	result at: 43 put: ((nodes at: 13) at: 23).
	result at: 44 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 14) at: 7).
	result at: 49 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition1: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: ((nodes at: 2) at: 1).
	result at: 3 put: ((nodes at: 2) at: 2).
	result at: 4 put: (nodes at: 3).
	result at: 5 put: ((nodes at: 4) at: 1).
	self add: ((nodes at: 4) at: 2) to: (result at: 6).
	self add: ((nodes at: 5) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 5) at: 2).
	result at: 8 put: (nodes at: 6).
	result at: 9 put: ((nodes at: 7) at: 1).
	result at: 10 put: ((nodes at: 7) at: 2).
	result at: 11 put: ((nodes at: 8) at: 1).
	result at: 12 put: ((nodes at: 8) at: 2).
	result at: 13 put: ((nodes at: 9) at: 1).
	result at: 14 put: ((nodes at: 9) at: 2).
	self add: ((nodes at: 9) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 10) at: 1).
	result at: 17 put: ((nodes at: 10) at: 2).
	self add: ((nodes at: 10) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 11) at: 1).
	result at: 19 put: ((nodes at: 11) at: 2).
	result at: 20 put: ((nodes at: 11) at: 3).
	result at: 21 put: ((nodes at: 12) at: 1).
	result at: 22 put: ((nodes at: 12) at: 2).
	self addAll: ((nodes at: 12) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 12) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 12) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 12) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 12) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 12) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 12) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 12) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 12) at: 11).
	self addAll: ((nodes at: 12) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 12) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 12) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 12) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 12) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 12) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 12) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 12) at: 19).
	result at: 40 put: ((nodes at: 12) at: 20).
	result at: 41 put: ((nodes at: 12) at: 21).
	result at: 42 put: ((nodes at: 12) at: 22).
	result at: 43 put: ((nodes at: 12) at: 23).
	result at: 44 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 13) at: 3).
	self add: ((nodes at: 13) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 13) at: 5).
	self add: ((nodes at: 13) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 13) at: 7).
	result at: 49 put: ((nodes at: 13) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition20: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 47).
	self add: (nodes at: 10) to: (result at: 35).
	result at: 2 put: ((nodes at: 11) at: 1).
	result at: 3 put: ((nodes at: 11) at: 2).
	result at: 5 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 6).
	self add: ((nodes at: 13) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 13) at: 2).
	result at: 8 put: (nodes at: 14).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 15) at: 11).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 15) at: 19).
	result at: 40 put: ((nodes at: 15) at: 20).
	result at: 41 put: ((nodes at: 15) at: 21).
	result at: 42 put: ((nodes at: 15) at: 22).
	result at: 43 put: ((nodes at: 15) at: 23).
	result at: 44 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 16) at: 7).
	result at: 49 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition21: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 55 put: (nodes at: 2).
	result at: 56 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 35).
	result at: 2 put: ((nodes at: 10) at: 1).
	result at: 3 put: ((nodes at: 10) at: 2).
	result at: 5 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 6).
	self add: ((nodes at: 12) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 12) at: 2).
	result at: 8 put: (nodes at: 13).
	result at: 21 put: ((nodes at: 14) at: 1).
	result at: 22 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 14) at: 11).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 14) at: 19).
	result at: 40 put: ((nodes at: 14) at: 20).
	result at: 41 put: ((nodes at: 14) at: 21).
	result at: 42 put: ((nodes at: 14) at: 22).
	result at: 43 put: ((nodes at: 14) at: 23).
	result at: 44 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 15) at: 7).
	result at: 49 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition22: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 53 put: (nodes at: 8).
	result at: 2 put: ((nodes at: 9) at: 1).
	result at: 3 put: ((nodes at: 9) at: 2).
	result at: 5 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 6).
	self add: ((nodes at: 11) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 11) at: 2).
	result at: 8 put: (nodes at: 12).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 13) at: 11).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 13) at: 19).
	result at: 40 put: ((nodes at: 13) at: 20).
	result at: 41 put: ((nodes at: 13) at: 21).
	result at: 42 put: ((nodes at: 13) at: 22).
	result at: 43 put: ((nodes at: 13) at: 23).
	result at: 44 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 14) at: 7).
	result at: 49 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition23: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 47).
	self add: (nodes at: 10) to: (result at: 35).
	result at: 2 put: ((nodes at: 11) at: 1).
	result at: 3 put: ((nodes at: 11) at: 2).
	result at: 5 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 6).
	self add: ((nodes at: 13) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 13) at: 2).
	result at: 8 put: (nodes at: 14).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 15) at: 11).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 15) at: 19).
	result at: 40 put: ((nodes at: 15) at: 20).
	result at: 41 put: ((nodes at: 15) at: 21).
	result at: 42 put: ((nodes at: 15) at: 22).
	result at: 43 put: ((nodes at: 15) at: 23).
	result at: 44 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 16) at: 7).
	result at: 49 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition24: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 53 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 35).
	result at: 2 put: ((nodes at: 10) at: 1).
	result at: 3 put: ((nodes at: 10) at: 2).
	result at: 5 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 6).
	self add: ((nodes at: 12) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 12) at: 2).
	result at: 8 put: (nodes at: 13).
	result at: 21 put: ((nodes at: 14) at: 1).
	result at: 22 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 14) at: 11).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 14) at: 19).
	result at: 40 put: ((nodes at: 14) at: 20).
	result at: 41 put: ((nodes at: 14) at: 21).
	result at: 42 put: ((nodes at: 14) at: 22).
	result at: 43 put: ((nodes at: 14) at: 23).
	result at: 44 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 15) at: 7).
	result at: 49 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition25: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 54 put: (nodes at: 8).
	result at: 2 put: ((nodes at: 9) at: 1).
	result at: 3 put: ((nodes at: 9) at: 2).
	result at: 5 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 6).
	self add: ((nodes at: 11) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 11) at: 2).
	result at: 8 put: (nodes at: 12).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 13) at: 11).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 13) at: 19).
	result at: 40 put: ((nodes at: 13) at: 20).
	result at: 41 put: ((nodes at: 13) at: 21).
	result at: 42 put: ((nodes at: 13) at: 22).
	result at: 43 put: ((nodes at: 13) at: 23).
	result at: 44 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 14) at: 7).
	result at: 49 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition26: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 47).
	self add: (nodes at: 10) to: (result at: 35).
	result at: 2 put: ((nodes at: 11) at: 1).
	result at: 3 put: ((nodes at: 11) at: 2).
	result at: 5 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 6).
	self add: ((nodes at: 13) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 13) at: 2).
	result at: 8 put: (nodes at: 14).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 15) at: 11).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 15) at: 19).
	result at: 40 put: ((nodes at: 15) at: 20).
	result at: 41 put: ((nodes at: 15) at: 21).
	result at: 42 put: ((nodes at: 15) at: 22).
	result at: 43 put: ((nodes at: 15) at: 23).
	result at: 44 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 16) at: 7).
	result at: 49 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition27: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 51 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 52 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 54 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 35).
	result at: 2 put: ((nodes at: 10) at: 1).
	result at: 3 put: ((nodes at: 10) at: 2).
	result at: 5 put: ((nodes at: 11) at: 1).
	self add: ((nodes at: 11) at: 2) to: (result at: 6).
	self add: ((nodes at: 12) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 12) at: 2).
	result at: 8 put: (nodes at: 13).
	result at: 21 put: ((nodes at: 14) at: 1).
	result at: 22 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 14) at: 11).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 14) at: 19).
	result at: 40 put: ((nodes at: 14) at: 20).
	result at: 41 put: ((nodes at: 14) at: 21).
	result at: 42 put: ((nodes at: 14) at: 22).
	result at: 43 put: ((nodes at: 14) at: 23).
	result at: 44 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 15) at: 7).
	result at: 49 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition28: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 23).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 27).
	result at: 53 put: (nodes at: 10).
	result at: 2 put: ((nodes at: 11) at: 1).
	result at: 3 put: ((nodes at: 11) at: 2).
	result at: 5 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 6).
	self add: ((nodes at: 13) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 13) at: 2).
	result at: 8 put: (nodes at: 14).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 15) at: 11).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 15) at: 19).
	result at: 40 put: ((nodes at: 15) at: 20).
	result at: 41 put: ((nodes at: 15) at: 21).
	result at: 42 put: ((nodes at: 15) at: 22).
	result at: 43 put: ((nodes at: 15) at: 23).
	result at: 44 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 16) at: 7).
	result at: 49 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition29: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 23).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 27).
	result at: 53 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 47).
	self add: (nodes at: 12) to: (result at: 35).
	result at: 2 put: ((nodes at: 13) at: 1).
	result at: 3 put: ((nodes at: 13) at: 2).
	result at: 5 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 6).
	self add: ((nodes at: 15) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 15) at: 2).
	result at: 8 put: (nodes at: 16).
	result at: 21 put: ((nodes at: 17) at: 1).
	result at: 22 put: ((nodes at: 17) at: 2).
	self addAll: ((nodes at: 17) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 17) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 17) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 17) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 17) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 17) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 17) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 17) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 17) at: 11).
	self addAll: ((nodes at: 17) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 17) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 17) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 17) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 17) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 17) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 17) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 17) at: 19).
	result at: 40 put: ((nodes at: 17) at: 20).
	result at: 41 put: ((nodes at: 17) at: 21).
	result at: 42 put: ((nodes at: 17) at: 22).
	result at: 43 put: ((nodes at: 17) at: 23).
	result at: 44 put: ((nodes at: 18) at: 1).
	self add: ((nodes at: 18) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 18) at: 3).
	self add: ((nodes at: 18) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 18) at: 5).
	self add: ((nodes at: 18) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 18) at: 7).
	result at: 49 put: ((nodes at: 18) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition2: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 38).
	result at: 50 put: (nodes at: 3).
	result at: 2 put: ((nodes at: 4) at: 1).
	result at: 3 put: ((nodes at: 4) at: 2).
	result at: 4 put: (nodes at: 5).
	result at: 5 put: ((nodes at: 6) at: 1).
	self add: ((nodes at: 6) at: 2) to: (result at: 6).
	self add: ((nodes at: 7) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 7) at: 2).
	result at: 8 put: (nodes at: 8).
	result at: 9 put: ((nodes at: 9) at: 1).
	result at: 10 put: ((nodes at: 9) at: 2).
	result at: 11 put: ((nodes at: 10) at: 1).
	result at: 12 put: ((nodes at: 10) at: 2).
	result at: 13 put: ((nodes at: 11) at: 1).
	result at: 14 put: ((nodes at: 11) at: 2).
	self add: ((nodes at: 11) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 12) at: 1).
	result at: 17 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 13) at: 1).
	result at: 19 put: ((nodes at: 13) at: 2).
	result at: 20 put: ((nodes at: 13) at: 3).
	result at: 21 put: ((nodes at: 14) at: 1).
	result at: 22 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 14) at: 11).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 14) at: 19).
	result at: 40 put: ((nodes at: 14) at: 20).
	result at: 41 put: ((nodes at: 14) at: 21).
	result at: 42 put: ((nodes at: 14) at: 22).
	result at: 43 put: ((nodes at: 14) at: 23).
	result at: 44 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 15) at: 7).
	result at: 49 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition30: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 23).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 27).
	result at: 53 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 35).
	result at: 2 put: ((nodes at: 12) at: 1).
	result at: 3 put: ((nodes at: 12) at: 2).
	result at: 5 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 6).
	self add: ((nodes at: 14) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 14) at: 2).
	result at: 8 put: (nodes at: 15).
	result at: 21 put: ((nodes at: 16) at: 1).
	result at: 22 put: ((nodes at: 16) at: 2).
	self addAll: ((nodes at: 16) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 16) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 16) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 16) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 16) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 16) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 16) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 16) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 16) at: 11).
	self addAll: ((nodes at: 16) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 16) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 16) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 16) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 16) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 16) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 16) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 16) at: 19).
	result at: 40 put: ((nodes at: 16) at: 20).
	result at: 41 put: ((nodes at: 16) at: 21).
	result at: 42 put: ((nodes at: 16) at: 22).
	result at: 43 put: ((nodes at: 16) at: 23).
	result at: 44 put: ((nodes at: 17) at: 1).
	self add: ((nodes at: 17) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 17) at: 3).
	self add: ((nodes at: 17) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 17) at: 5).
	self add: ((nodes at: 17) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 17) at: 7).
	result at: 49 put: ((nodes at: 17) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition31: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 23).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 27).
	result at: 54 put: (nodes at: 10).
	result at: 2 put: ((nodes at: 11) at: 1).
	result at: 3 put: ((nodes at: 11) at: 2).
	result at: 5 put: ((nodes at: 12) at: 1).
	self add: ((nodes at: 12) at: 2) to: (result at: 6).
	self add: ((nodes at: 13) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 13) at: 2).
	result at: 8 put: (nodes at: 14).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 15) at: 11).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 15) at: 19).
	result at: 40 put: ((nodes at: 15) at: 20).
	result at: 41 put: ((nodes at: 15) at: 21).
	result at: 42 put: ((nodes at: 15) at: 22).
	result at: 43 put: ((nodes at: 15) at: 23).
	result at: 44 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 16) at: 7).
	result at: 49 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition32: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 23).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 27).
	result at: 54 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 47).
	self add: (nodes at: 12) to: (result at: 35).
	result at: 2 put: ((nodes at: 13) at: 1).
	result at: 3 put: ((nodes at: 13) at: 2).
	result at: 5 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 6).
	self add: ((nodes at: 15) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 15) at: 2).
	result at: 8 put: (nodes at: 16).
	result at: 21 put: ((nodes at: 17) at: 1).
	result at: 22 put: ((nodes at: 17) at: 2).
	self addAll: ((nodes at: 17) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 17) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 17) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 17) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 17) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 17) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 17) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 17) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 17) at: 11).
	self addAll: ((nodes at: 17) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 17) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 17) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 17) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 17) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 17) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 17) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 17) at: 19).
	result at: 40 put: ((nodes at: 17) at: 20).
	result at: 41 put: ((nodes at: 17) at: 21).
	result at: 42 put: ((nodes at: 17) at: 22).
	result at: 43 put: ((nodes at: 17) at: 23).
	result at: 44 put: ((nodes at: 18) at: 1).
	self add: ((nodes at: 18) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 18) at: 3).
	self add: ((nodes at: 18) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 18) at: 5).
	self add: ((nodes at: 18) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 18) at: 7).
	result at: 49 put: ((nodes at: 18) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition33: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 9 put: (nodes at: 2).
	result at: 10 put: (nodes at: 3).
	result at: 55 put: (nodes at: 4).
	result at: 56 put: (nodes at: 5).
	result at: 51 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 23).
	result at: 52 put: (nodes at: 8).
	self add: (nodes at: 9) to: (result at: 27).
	result at: 54 put: (nodes at: 10).
	self add: (nodes at: 11) to: (result at: 35).
	result at: 2 put: ((nodes at: 12) at: 1).
	result at: 3 put: ((nodes at: 12) at: 2).
	result at: 5 put: ((nodes at: 13) at: 1).
	self add: ((nodes at: 13) at: 2) to: (result at: 6).
	self add: ((nodes at: 14) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 14) at: 2).
	result at: 8 put: (nodes at: 15).
	result at: 21 put: ((nodes at: 16) at: 1).
	result at: 22 put: ((nodes at: 16) at: 2).
	self addAll: ((nodes at: 16) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 16) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 16) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 16) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 16) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 16) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 16) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 16) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 16) at: 11).
	self addAll: ((nodes at: 16) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 16) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 16) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 16) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 16) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 16) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 16) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 16) at: 19).
	result at: 40 put: ((nodes at: 16) at: 20).
	result at: 41 put: ((nodes at: 16) at: 21).
	result at: 42 put: ((nodes at: 16) at: 22).
	result at: 43 put: ((nodes at: 16) at: 23).
	result at: 44 put: ((nodes at: 17) at: 1).
	self add: ((nodes at: 17) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 17) at: 3).
	self add: ((nodes at: 17) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 17) at: 5).
	self add: ((nodes at: 17) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 17) at: 7).
	result at: 49 put: ((nodes at: 17) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition3: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 38).
	self add: (nodes at: 3) to: (result at: 23).
	result at: 50 put: (nodes at: 4).
	self add: (nodes at: 5) to: (result at: 27).
	result at: 2 put: ((nodes at: 6) at: 1).
	result at: 3 put: ((nodes at: 6) at: 2).
	result at: 4 put: (nodes at: 7).
	result at: 5 put: ((nodes at: 8) at: 1).
	self add: ((nodes at: 8) at: 2) to: (result at: 6).
	self add: ((nodes at: 9) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 9) at: 2).
	result at: 8 put: (nodes at: 10).
	result at: 9 put: ((nodes at: 11) at: 1).
	result at: 10 put: ((nodes at: 11) at: 2).
	result at: 11 put: ((nodes at: 12) at: 1).
	result at: 12 put: ((nodes at: 12) at: 2).
	result at: 13 put: ((nodes at: 13) at: 1).
	result at: 14 put: ((nodes at: 13) at: 2).
	self add: ((nodes at: 13) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 14) at: 1).
	result at: 17 put: ((nodes at: 14) at: 2).
	self add: ((nodes at: 14) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 15) at: 1).
	result at: 19 put: ((nodes at: 15) at: 2).
	result at: 20 put: ((nodes at: 15) at: 3).
	result at: 21 put: ((nodes at: 16) at: 1).
	result at: 22 put: ((nodes at: 16) at: 2).
	self addAll: ((nodes at: 16) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 16) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 16) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 16) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 16) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 16) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 16) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 16) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 16) at: 11).
	self addAll: ((nodes at: 16) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 16) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 16) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 16) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 16) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 16) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 16) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 16) at: 19).
	result at: 40 put: ((nodes at: 16) at: 20).
	result at: 41 put: ((nodes at: 16) at: 21).
	result at: 42 put: ((nodes at: 16) at: 22).
	result at: 43 put: ((nodes at: 16) at: 23).
	result at: 44 put: ((nodes at: 17) at: 1).
	self add: ((nodes at: 17) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 17) at: 3).
	self add: ((nodes at: 17) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 17) at: 5).
	self add: ((nodes at: 17) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 17) at: 7).
	result at: 49 put: ((nodes at: 17) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition4: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 47).
	self add: (nodes at: 3) to: (result at: 35).
	result at: 2 put: ((nodes at: 4) at: 1).
	result at: 3 put: ((nodes at: 4) at: 2).
	result at: 4 put: (nodes at: 5).
	result at: 5 put: ((nodes at: 6) at: 1).
	self add: ((nodes at: 6) at: 2) to: (result at: 6).
	self add: ((nodes at: 7) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 7) at: 2).
	result at: 8 put: (nodes at: 8).
	result at: 9 put: ((nodes at: 9) at: 1).
	result at: 10 put: ((nodes at: 9) at: 2).
	result at: 11 put: ((nodes at: 10) at: 1).
	result at: 12 put: ((nodes at: 10) at: 2).
	result at: 13 put: ((nodes at: 11) at: 1).
	result at: 14 put: ((nodes at: 11) at: 2).
	self add: ((nodes at: 11) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 12) at: 1).
	result at: 17 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 13) at: 1).
	result at: 19 put: ((nodes at: 13) at: 2).
	result at: 20 put: ((nodes at: 13) at: 3).
	result at: 21 put: ((nodes at: 14) at: 1).
	result at: 22 put: ((nodes at: 14) at: 2).
	self addAll: ((nodes at: 14) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 14) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 14) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 14) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 14) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 14) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 14) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 14) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 14) at: 11).
	self addAll: ((nodes at: 14) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 14) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 14) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 14) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 14) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 14) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 14) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 14) at: 19).
	result at: 40 put: ((nodes at: 14) at: 20).
	result at: 41 put: ((nodes at: 14) at: 21).
	result at: 42 put: ((nodes at: 14) at: 22).
	result at: 43 put: ((nodes at: 14) at: 23).
	result at: 44 put: ((nodes at: 15) at: 1).
	self add: ((nodes at: 15) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 15) at: 3).
	self add: ((nodes at: 15) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 15) at: 5).
	self add: ((nodes at: 15) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 15) at: 7).
	result at: 49 put: ((nodes at: 15) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition5: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 47).
	self add: (nodes at: 3) to: (result at: 35).
	self add: (nodes at: 4) to: (result at: 38).
	result at: 50 put: (nodes at: 5).
	result at: 2 put: ((nodes at: 6) at: 1).
	result at: 3 put: ((nodes at: 6) at: 2).
	result at: 4 put: (nodes at: 7).
	result at: 5 put: ((nodes at: 8) at: 1).
	self add: ((nodes at: 8) at: 2) to: (result at: 6).
	self add: ((nodes at: 9) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 9) at: 2).
	result at: 8 put: (nodes at: 10).
	result at: 9 put: ((nodes at: 11) at: 1).
	result at: 10 put: ((nodes at: 11) at: 2).
	result at: 11 put: ((nodes at: 12) at: 1).
	result at: 12 put: ((nodes at: 12) at: 2).
	result at: 13 put: ((nodes at: 13) at: 1).
	result at: 14 put: ((nodes at: 13) at: 2).
	self add: ((nodes at: 13) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 14) at: 1).
	result at: 17 put: ((nodes at: 14) at: 2).
	self add: ((nodes at: 14) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 15) at: 1).
	result at: 19 put: ((nodes at: 15) at: 2).
	result at: 20 put: ((nodes at: 15) at: 3).
	result at: 21 put: ((nodes at: 16) at: 1).
	result at: 22 put: ((nodes at: 16) at: 2).
	self addAll: ((nodes at: 16) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 16) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 16) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 16) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 16) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 16) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 16) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 16) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 16) at: 11).
	self addAll: ((nodes at: 16) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 16) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 16) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 16) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 16) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 16) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 16) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 16) at: 19).
	result at: 40 put: ((nodes at: 16) at: 20).
	result at: 41 put: ((nodes at: 16) at: 21).
	result at: 42 put: ((nodes at: 16) at: 22).
	result at: 43 put: ((nodes at: 16) at: 23).
	result at: 44 put: ((nodes at: 17) at: 1).
	self add: ((nodes at: 17) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 17) at: 3).
	self add: ((nodes at: 17) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 17) at: 5).
	self add: ((nodes at: 17) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 17) at: 7).
	result at: 49 put: ((nodes at: 17) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition6: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 47).
	self add: (nodes at: 3) to: (result at: 35).
	self add: (nodes at: 4) to: (result at: 38).
	self add: (nodes at: 5) to: (result at: 23).
	result at: 50 put: (nodes at: 6).
	self add: (nodes at: 7) to: (result at: 27).
	result at: 2 put: ((nodes at: 8) at: 1).
	result at: 3 put: ((nodes at: 8) at: 2).
	result at: 4 put: (nodes at: 9).
	result at: 5 put: ((nodes at: 10) at: 1).
	self add: ((nodes at: 10) at: 2) to: (result at: 6).
	self add: ((nodes at: 11) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 11) at: 2).
	result at: 8 put: (nodes at: 12).
	result at: 9 put: ((nodes at: 13) at: 1).
	result at: 10 put: ((nodes at: 13) at: 2).
	result at: 11 put: ((nodes at: 14) at: 1).
	result at: 12 put: ((nodes at: 14) at: 2).
	result at: 13 put: ((nodes at: 15) at: 1).
	result at: 14 put: ((nodes at: 15) at: 2).
	self add: ((nodes at: 15) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 16) at: 1).
	result at: 17 put: ((nodes at: 16) at: 2).
	self add: ((nodes at: 16) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 17) at: 1).
	result at: 19 put: ((nodes at: 17) at: 2).
	result at: 20 put: ((nodes at: 17) at: 3).
	result at: 21 put: ((nodes at: 18) at: 1).
	result at: 22 put: ((nodes at: 18) at: 2).
	self addAll: ((nodes at: 18) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 18) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 18) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 18) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 18) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 18) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 18) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 18) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 18) at: 11).
	self addAll: ((nodes at: 18) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 18) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 18) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 18) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 18) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 18) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 18) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 18) at: 19).
	result at: 40 put: ((nodes at: 18) at: 20).
	result at: 41 put: ((nodes at: 18) at: 21).
	result at: 42 put: ((nodes at: 18) at: 22).
	result at: 43 put: ((nodes at: 18) at: 23).
	result at: 44 put: ((nodes at: 19) at: 1).
	self add: ((nodes at: 19) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 19) at: 3).
	self add: ((nodes at: 19) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 19) at: 5).
	self add: ((nodes at: 19) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 19) at: 7).
	result at: 49 put: ((nodes at: 19) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition7: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 35).
	result at: 2 put: ((nodes at: 3) at: 1).
	result at: 3 put: ((nodes at: 3) at: 2).
	result at: 4 put: (nodes at: 4).
	result at: 5 put: ((nodes at: 5) at: 1).
	self add: ((nodes at: 5) at: 2) to: (result at: 6).
	self add: ((nodes at: 6) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 6) at: 2).
	result at: 8 put: (nodes at: 7).
	result at: 9 put: ((nodes at: 8) at: 1).
	result at: 10 put: ((nodes at: 8) at: 2).
	result at: 11 put: ((nodes at: 9) at: 1).
	result at: 12 put: ((nodes at: 9) at: 2).
	result at: 13 put: ((nodes at: 10) at: 1).
	result at: 14 put: ((nodes at: 10) at: 2).
	self add: ((nodes at: 10) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 11) at: 1).
	result at: 17 put: ((nodes at: 11) at: 2).
	self add: ((nodes at: 11) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 12) at: 1).
	result at: 19 put: ((nodes at: 12) at: 2).
	result at: 20 put: ((nodes at: 12) at: 3).
	result at: 21 put: ((nodes at: 13) at: 1).
	result at: 22 put: ((nodes at: 13) at: 2).
	self addAll: ((nodes at: 13) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 13) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 13) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 13) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 13) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 13) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 13) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 13) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 13) at: 11).
	self addAll: ((nodes at: 13) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 13) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 13) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 13) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 13) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 13) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 13) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 13) at: 19).
	result at: 40 put: ((nodes at: 13) at: 20).
	result at: 41 put: ((nodes at: 13) at: 21).
	result at: 42 put: ((nodes at: 13) at: 22).
	result at: 43 put: ((nodes at: 13) at: 23).
	result at: 44 put: ((nodes at: 14) at: 1).
	self add: ((nodes at: 14) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 14) at: 3).
	self add: ((nodes at: 14) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 14) at: 5).
	self add: ((nodes at: 14) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 14) at: 7).
	result at: 49 put: ((nodes at: 14) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition8: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 35).
	self add: (nodes at: 3) to: (result at: 38).
	result at: 50 put: (nodes at: 4).
	result at: 2 put: ((nodes at: 5) at: 1).
	result at: 3 put: ((nodes at: 5) at: 2).
	result at: 4 put: (nodes at: 6).
	result at: 5 put: ((nodes at: 7) at: 1).
	self add: ((nodes at: 7) at: 2) to: (result at: 6).
	self add: ((nodes at: 8) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 8) at: 2).
	result at: 8 put: (nodes at: 9).
	result at: 9 put: ((nodes at: 10) at: 1).
	result at: 10 put: ((nodes at: 10) at: 2).
	result at: 11 put: ((nodes at: 11) at: 1).
	result at: 12 put: ((nodes at: 11) at: 2).
	result at: 13 put: ((nodes at: 12) at: 1).
	result at: 14 put: ((nodes at: 12) at: 2).
	self add: ((nodes at: 12) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 13) at: 1).
	result at: 17 put: ((nodes at: 13) at: 2).
	self add: ((nodes at: 13) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 14) at: 1).
	result at: 19 put: ((nodes at: 14) at: 2).
	result at: 20 put: ((nodes at: 14) at: 3).
	result at: 21 put: ((nodes at: 15) at: 1).
	result at: 22 put: ((nodes at: 15) at: 2).
	self addAll: ((nodes at: 15) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 15) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 15) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 15) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 15) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 15) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 15) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 15) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 15) at: 11).
	self addAll: ((nodes at: 15) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 15) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 15) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 15) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 15) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 15) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 15) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 15) at: 19).
	result at: 40 put: ((nodes at: 15) at: 20).
	result at: 41 put: ((nodes at: 15) at: 21).
	result at: 42 put: ((nodes at: 15) at: 22).
	result at: 43 put: ((nodes at: 15) at: 23).
	result at: 44 put: ((nodes at: 16) at: 1).
	self add: ((nodes at: 16) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 16) at: 3).
	self add: ((nodes at: 16) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 16) at: 5).
	self add: ((nodes at: 16) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 16) at: 7).
	result at: 49 put: ((nodes at: 16) at: 8).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionForcolumn_definition9: nodes [
	| result |
	result := Array new: 56.
	result at: 6 put: (OrderedCollection new: 2).
	result at: 15 put: (OrderedCollection new: 2).
	result at: 23 put: (OrderedCollection new: 2).
	result at: 24 put: (OrderedCollection new: 2).
	result at: 25 put: (OrderedCollection new: 2).
	result at: 26 put: (OrderedCollection new: 2).
	result at: 27 put: (OrderedCollection new: 2).
	result at: 28 put: (OrderedCollection new: 2).
	result at: 29 put: (OrderedCollection new: 2).
	result at: 30 put: (OrderedCollection new: 2).
	result at: 32 put: (OrderedCollection new: 2).
	result at: 33 put: (OrderedCollection new: 2).
	result at: 34 put: (OrderedCollection new: 2).
	result at: 35 put: (OrderedCollection new: 2).
	result at: 36 put: (OrderedCollection new: 2).
	result at: 37 put: (OrderedCollection new: 2).
	result at: 38 put: (OrderedCollection new: 2).
	result at: 47 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 35).
	self add: (nodes at: 3) to: (result at: 38).
	self add: (nodes at: 4) to: (result at: 23).
	result at: 50 put: (nodes at: 5).
	self add: (nodes at: 6) to: (result at: 27).
	result at: 2 put: ((nodes at: 7) at: 1).
	result at: 3 put: ((nodes at: 7) at: 2).
	result at: 4 put: (nodes at: 8).
	result at: 5 put: ((nodes at: 9) at: 1).
	self add: ((nodes at: 9) at: 2) to: (result at: 6).
	self add: ((nodes at: 10) at: 1) to: (result at: 6).
	result at: 7 put: ((nodes at: 10) at: 2).
	result at: 8 put: (nodes at: 11).
	result at: 9 put: ((nodes at: 12) at: 1).
	result at: 10 put: ((nodes at: 12) at: 2).
	result at: 11 put: ((nodes at: 13) at: 1).
	result at: 12 put: ((nodes at: 13) at: 2).
	result at: 13 put: ((nodes at: 14) at: 1).
	result at: 14 put: ((nodes at: 14) at: 2).
	self add: ((nodes at: 14) at: 3) to: (result at: 15).
	result at: 16 put: ((nodes at: 15) at: 1).
	result at: 17 put: ((nodes at: 15) at: 2).
	self add: ((nodes at: 15) at: 3) to: (result at: 15).
	result at: 18 put: ((nodes at: 16) at: 1).
	result at: 19 put: ((nodes at: 16) at: 2).
	result at: 20 put: ((nodes at: 16) at: 3).
	result at: 21 put: ((nodes at: 17) at: 1).
	result at: 22 put: ((nodes at: 17) at: 2).
	self addAll: ((nodes at: 17) at: 3) to: (result at: 23).
	self addAll: ((nodes at: 17) at: 4) to: (result at: 24).
	self addAll: ((nodes at: 17) at: 5) to: (result at: 25).
	self addAll: ((nodes at: 17) at: 6) to: (result at: 26).
	self addAll: ((nodes at: 17) at: 7) to: (result at: 27).
	self addAll: ((nodes at: 17) at: 8) to: (result at: 28).
	self addAll: ((nodes at: 17) at: 9) to: (result at: 29).
	self addAll: ((nodes at: 17) at: 10) to: (result at: 30).
	result at: 31 put: ((nodes at: 17) at: 11).
	self addAll: ((nodes at: 17) at: 12) to: (result at: 32).
	self addAll: ((nodes at: 17) at: 13) to: (result at: 33).
	self addAll: ((nodes at: 17) at: 14) to: (result at: 34).
	self addAll: ((nodes at: 17) at: 15) to: (result at: 35).
	self addAll: ((nodes at: 17) at: 16) to: (result at: 36).
	self addAll: ((nodes at: 17) at: 17) to: (result at: 37).
	self addAll: ((nodes at: 17) at: 18) to: (result at: 38).
	result at: 39 put: ((nodes at: 17) at: 19).
	result at: 40 put: ((nodes at: 17) at: 20).
	result at: 41 put: ((nodes at: 17) at: 21).
	result at: 42 put: ((nodes at: 17) at: 22).
	result at: 43 put: ((nodes at: 17) at: 23).
	result at: 44 put: ((nodes at: 18) at: 1).
	self add: ((nodes at: 18) at: 2) to: (result at: 23).
	result at: 45 put: ((nodes at: 18) at: 3).
	self add: ((nodes at: 18) at: 4) to: (result at: 27).
	result at: 46 put: ((nodes at: 18) at: 5).
	self add: ((nodes at: 18) at: 6) to: (result at: 47).
	result at: 48 put: ((nodes at: 18) at: 7).
	result at: 49 put: ((nodes at: 18) at: 8).
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
	result addToken: ((nodes at: 3) at: 1) to: result columnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 3) at: 1) to: result columnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 3) at: 1) to: result columnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: (nodes at: 1) to: result columnNames.
	result dataType: ((nodes at: 2) at: 1).
	result visibleToken: ((nodes at: 2) at: 2).
	result invisibleToken: ((nodes at: 2) at: 3).
	result autoIncrementToken: ((nodes at: 2) at: 4).
	result uniqueToken: ((nodes at: 2) at: 5).
	result addTokens: ((nodes at: 2) at: 6) to: result keyTokens.
	result primaryToken: ((nodes at: 2) at: 7).
	result commentToken: ((nodes at: 2) at: 8).
	result collateToken: ((nodes at: 2) at: 9).
	result collationName: ((nodes at: 2) at: 10).
	result columnFormatToken: ((nodes at: 2) at: 11).
	result columnFormat: ((nodes at: 2) at: 12).
	result engineAttributeToken: ((nodes at: 2) at: 13).
	result engineAttribute: ((nodes at: 2) at: 14).
	result addTokens: ((nodes at: 2) at: 15) to: result equalses.
	result secondaryToken: ((nodes at: 2) at: 16).
	result secondaryEngineAttribute: ((nodes at: 2) at: 17).
	result storageToken: ((nodes at: 2) at: 18).
	result diskToken: ((nodes at: 2) at: 19).
	result memoryToken: ((nodes at: 2) at: 20).
	result referencesToken: ((nodes at: 2) at: 21).
	result tableName: ((nodes at: 2) at: 22).
	result addTokens: ((nodes at: 2) at: 23) to: result leftParens.
	result addTokens: ((nodes at: 2) at: 24) to: result columnNames.
	result addTokens: ((nodes at: 2) at: 25) to: result directions.
	result addTokens: ((nodes at: 2) at: 26) to: result lengths.
	result addTokens: ((nodes at: 2) at: 27) to: result rightParens.
	result addNodes: ((nodes at: 2) at: 28) to: result exprs.
	result addTokens: ((nodes at: 2) at: 29) to: result commas.
	result addTokens: ((nodes at: 2) at: 30) to: result onTokens.
	result updateToken: ((nodes at: 2) at: 31).
	result addTokens: ((nodes at: 2) at: 32) to: result restrictTokens.
	result addTokens: ((nodes at: 2) at: 33) to: result cascadeTokens.
	result addTokens: ((nodes at: 2) at: 34) to: result setTokens.
	result addTokens: ((nodes at: 2) at: 35) to: result nullTokens.
	result addTokens: ((nodes at: 2) at: 36) to: result noTokens.
	result addTokens: ((nodes at: 2) at: 37) to: result actionTokens.
	result addTokens: ((nodes at: 2) at: 38) to: result defaultTokens.
	result _deleteToken: ((nodes at: 2) at: 39).
	result matchToken: ((nodes at: 2) at: 40).
	result fullToken: ((nodes at: 2) at: 41).
	result partialToken: ((nodes at: 2) at: 42).
	result simpleToken: ((nodes at: 2) at: 43).
	result checkToken: ((nodes at: 2) at: 44).
	result check: ((nodes at: 2) at: 45).
	result enforcedToken: ((nodes at: 2) at: 46).
	result addTokens: ((nodes at: 2) at: 47) to: result notTokens.
	result constraintToken: ((nodes at: 2) at: 48).
	result constraintName: ((nodes at: 2) at: 49).
	result value: ((nodes at: 2) at: 50).
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 3) at: 1) to: result columnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 3) at: 1) to: result columnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 6) at: 1) to: result columnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 6) at: 1) to: result columnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 6) at: 1) to: result columnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 6) at: 1) to: result columnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 3) at: 1) to: result columnNames.
	result addToken: ((nodes at: 3) at: 2) to: result directions.
	result addToken: ((nodes at: 3) at: 3) to: result leftParens.
	result addToken: ((nodes at: 3) at: 4) to: result lengths.
	result addToken: ((nodes at: 3) at: 5) to: result rightParens.
	result addNode: ((nodes at: 3) at: 6) to: result exprs.
	result addTokens: ((nodes at: 4) at: 1) to: result commas.
	result addTokens: ((nodes at: 4) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 7) at: 1) to: result columnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 7) at: 1) to: result columnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 6) at: 1) to: result columnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 6) at: 1) to: result columnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 6) at: 1) to: result columnNames.
	result addToken: ((nodes at: 6) at: 2) to: result directions.
	result addToken: ((nodes at: 6) at: 3) to: result leftParens.
	result addToken: ((nodes at: 6) at: 4) to: result lengths.
	result addToken: ((nodes at: 6) at: 5) to: result rightParens.
	result addNode: ((nodes at: 6) at: 6) to: result exprs.
	result addTokens: ((nodes at: 7) at: 1) to: result commas.
	result addTokens: ((nodes at: 7) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 7) at: 1) to: result columnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 7) at: 1) to: result columnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 7) at: 1) to: result columnNames.
	result addToken: ((nodes at: 7) at: 2) to: result directions.
	result addToken: ((nodes at: 7) at: 3) to: result leftParens.
	result addToken: ((nodes at: 7) at: 4) to: result lengths.
	result addToken: ((nodes at: 7) at: 5) to: result rightParens.
	result addNode: ((nodes at: 7) at: 6) to: result exprs.
	result addTokens: ((nodes at: 8) at: 1) to: result commas.
	result addTokens: ((nodes at: 8) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 8) at: 1) to: result columnNames.
	result addToken: ((nodes at: 8) at: 2) to: result directions.
	result addToken: ((nodes at: 8) at: 3) to: result leftParens.
	result addToken: ((nodes at: 8) at: 4) to: result lengths.
	result addToken: ((nodes at: 8) at: 5) to: result rightParens.
	result addNode: ((nodes at: 8) at: 6) to: result exprs.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addTokens: ((nodes at: 9) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 8) at: 1) to: result columnNames.
	result addToken: ((nodes at: 8) at: 2) to: result directions.
	result addToken: ((nodes at: 8) at: 3) to: result leftParens.
	result addToken: ((nodes at: 8) at: 4) to: result lengths.
	result addToken: ((nodes at: 8) at: 5) to: result rightParens.
	result addNode: ((nodes at: 8) at: 6) to: result exprs.
	result addTokens: ((nodes at: 9) at: 1) to: result commas.
	result addTokens: ((nodes at: 9) at: 2) to: result columnNames.
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
	result addTokens: ((nodes at: 7) at: 4) to: result columnNames.
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
	result addTokens: ((nodes at: 8) at: 4) to: result columnNames.
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
	result addTokens: ((nodes at: 8) at: 4) to: result columnNames.
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
	result addTokens: ((nodes at: 9) at: 4) to: result columnNames.
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
	result addTokens: ((nodes at: 9) at: 4) to: result columnNames.
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
	result addTokens: ((nodes at: 10) at: 4) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 4) at: 1) to: result columnNames.
	result addToken: ((nodes at: 4) at: 2) to: result directions.
	result addToken: ((nodes at: 4) at: 3) to: result leftParens.
	result addToken: ((nodes at: 4) at: 4) to: result lengths.
	result addToken: ((nodes at: 4) at: 5) to: result rightParens.
	result addNode: ((nodes at: 4) at: 6) to: result exprs.
	result addTokens: ((nodes at: 5) at: 1) to: result commas.
	result addTokens: ((nodes at: 5) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result addToken: ((nodes at: 5) at: 1) to: result columnNames.
	result addToken: ((nodes at: 5) at: 2) to: result directions.
	result addToken: ((nodes at: 5) at: 3) to: result leftParens.
	result addToken: ((nodes at: 5) at: 4) to: result lengths.
	result addToken: ((nodes at: 5) at: 5) to: result rightParens.
	result addNode: ((nodes at: 5) at: 6) to: result exprs.
	result addTokens: ((nodes at: 6) at: 1) to: result commas.
	result addTokens: ((nodes at: 6) at: 2) to: result columnNames.
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
	result rightParen: (nodes at: 4).
	result unsignedToken: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type11: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result rightParen: (nodes at: 4).
	result unsignedToken: (nodes at: 5).
	result characterToken: (nodes at: 6).
	result setToken: (nodes at: 7).
	result equals: (nodes at: 8).
	result charsetName: (nodes at: 9).
	result collateToken: ((nodes at: 10) at: 1).
	result collationName: ((nodes at: 10) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type12: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result rightParen: (nodes at: 4).
	result unsignedToken: (nodes at: 5).
	result charsetToken: (nodes at: 6).
	result equals: (nodes at: 7).
	result charsetName: (nodes at: 8).
	result collateToken: ((nodes at: 9) at: 1).
	result collationName: ((nodes at: 9) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type13: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result comma: (nodes at: 4).
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type14: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result comma: (nodes at: 4).
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result characterToken: (nodes at: 7).
	result setToken: (nodes at: 8).
	result equals: (nodes at: 9).
	result charsetName: (nodes at: 10).
	result collateToken: ((nodes at: 11) at: 1).
	result collationName: ((nodes at: 11) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type15: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result comma: (nodes at: 4).
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result charsetToken: (nodes at: 7).
	result equals: (nodes at: 8).
	result charsetName: (nodes at: 9).
	result collateToken: ((nodes at: 10) at: 1).
	result collationName: ((nodes at: 10) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type16: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result comma: (nodes at: 4).
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result unsignedToken: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type17: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result comma: (nodes at: 4).
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result unsignedToken: (nodes at: 7).
	result characterToken: (nodes at: 8).
	result setToken: (nodes at: 9).
	result equals: (nodes at: 10).
	result charsetName: (nodes at: 11).
	result collateToken: ((nodes at: 12) at: 1).
	result collationName: ((nodes at: 12) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type18: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result comma: (nodes at: 4).
	result precision: (nodes at: 5).
	result rightParen: (nodes at: 6).
	result unsignedToken: (nodes at: 7).
	result charsetToken: (nodes at: 8).
	result equals: (nodes at: 9).
	result charsetName: (nodes at: 10).
	result collateToken: ((nodes at: 11) at: 1).
	result collationName: ((nodes at: 11) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type1: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type2: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result characterToken: (nodes at: 2).
	result setToken: (nodes at: 3).
	result equals: (nodes at: 4).
	result charsetName: (nodes at: 5).
	result collateToken: ((nodes at: 6) at: 1).
	result collationName: ((nodes at: 6) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type3: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result charsetToken: (nodes at: 2).
	result equals: (nodes at: 3).
	result charsetName: (nodes at: 4).
	result collateToken: ((nodes at: 5) at: 1).
	result collationName: ((nodes at: 5) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type4: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result unsignedToken: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type5: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result unsignedToken: (nodes at: 2).
	result characterToken: (nodes at: 3).
	result setToken: (nodes at: 4).
	result equals: (nodes at: 5).
	result charsetName: (nodes at: 6).
	result collateToken: ((nodes at: 7) at: 1).
	result collationName: ((nodes at: 7) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type6: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result unsignedToken: (nodes at: 2).
	result charsetToken: (nodes at: 3).
	result equals: (nodes at: 4).
	result charsetName: (nodes at: 5).
	result collateToken: ((nodes at: 6) at: 1).
	result collationName: ((nodes at: 6) at: 2).
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
	result characterToken: (nodes at: 5).
	result setToken: (nodes at: 6).
	result equals: (nodes at: 7).
	result charsetName: (nodes at: 8).
	result collateToken: ((nodes at: 9) at: 1).
	result collationName: ((nodes at: 9) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
MysqlParser >> reduceActionFordata_type9: nodes [
	| result |
	result := MysqlDataTypeNode new.
	result typeName: (nodes at: 1).
	result leftParen: (nodes at: 2).
	result length: (nodes at: 3).
	result rightParen: (nodes at: 4).
	result charsetToken: (nodes at: 5).
	result equals: (nodes at: 6).
	result charsetName: (nodes at: 7).
	result collateToken: ((nodes at: 8) at: 1).
	result collationName: ((nodes at: 8) at: 2).
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
