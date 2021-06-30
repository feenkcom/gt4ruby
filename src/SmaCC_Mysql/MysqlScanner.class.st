Class {
	#name : #MysqlScanner,
	#superclass : #SmaCCScanner,
	#category : #'SmaCC_Mysql'
}

{ #category : #'generated-initialization' }
MysqlScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(140 '''LZ4''' 1) #(140 '''N''' 2) #(140 '''NONE''' 3) #(140 '''Y''' 4) #(140 '''ZLIB''' 5) #(145 'ACTION' 14) #(145 'ALGORITHM' 15) #(145 'ALWAYS' 16) #(145 'AS' 17) #(145 'ASC' 18) #(145 'AUTOEXTEND_SIZE' 19) #(145 'AUTO_INCREMENT' 20) #(145 'AVG_ROW_LENGTH' 21) #(145 'BIGINT' 22) #(145 'BTREE' 23) #(145 'BY' 24) #(145 'CASCADE' 25) #(145 'CHAR' 26) #(145 'CHARACTER' 27) #(145 'CHARSET' 28) #(145 'CHECK' 29) #(145 'CHECKSUM' 30) #(145 'COLLATE' 31) #(145 'COLUMNS' 32) #(145 'COLUMN_FORMAT' 33) #(145 'COMMENT' 34) #(145 'COMPACT' 35) #(145 'COMPRESSED' 36) #(145 'COMPRESSION' 37) #(145 'CONNECTION' 38) #(145 'CONSTRAINT' 39) #(145 'CREATE' 40) #(145 'CURRENT_TIMESTAMP' 41) #(145 'DATA' 42) #(145 'DATE' 43) #(145 'DATETIME' 44) #(145 'DECIMAL' 45) #(145 'DEFAULT' 46) #(145 'DELAY_KEY_WRITE' 47) #(145 'DELETE' 48) #(145 'DESC' 49) #(145 'DIRECTORY' 50) #(145 'DISK' 51) #(145 'DOUBLE' 52) #(145 'DYNAMIC' 53) #(145 'ENCRYPTION' 54) #(145 'ENFORCED' 55) #(145 'ENGINE' 56) #(145 'ENGINE_ATTRIBUTE' 57) #(145 'EXISTS' 58) #(145 'FIRST' 59) #(145 'FIXED' 60) #(145 'FLOAT' 61) #(145 'FOREIGN' 62) #(145 'FULL' 63) #(145 'FULLTEXT' 64) #(145 'GENERATED' 65) #(145 'HASH' 66) #(145 'IF' 67) #(145 'IGNORE' 68) #(145 'IN' 69) #(145 'INDEX' 70) #(145 'INNODB' 74) #(145 'INSERT_METHOD' 71) #(145 'INT' 72) #(145 'INVISIBLE' 73) #(145 'JSON' 75) #(145 'KEY' 76) #(145 'KEY_BLOCK_SIZE' 77) #(145 'LAST' 78) #(145 'LESS' 79) #(145 'LIKE' 80) #(145 'LINEAR' 81) #(145 'LIST' 82) #(145 'LONGBLOB' 83) #(145 'LONGTEXT' 84) #(145 'MATCH' 85) #(145 'MAXVALUE' 86) #(145 'MAX_ROWS' 87) #(145 'MEDIUMBLOB' 88) #(145 'MEDIUMTEXT' 89) #(145 'MEMORY' 90) #(145 'MIN_ROWS' 91) #(145 'NO' 92) #(145 'NOT' 93) #(145 'NULL' 94) #(145 'ON' 95) #(145 'PACK_KEYS' 96) #(145 'PARSER' 97) #(145 'PARTIAL' 98) #(145 'PARTITION' 99) #(145 'PARTITIONS' 100) #(145 'PASSWORD' 101) #(145 'PRIMARY' 102) #(145 'RANGE' 103) #(145 'REDUNDANT' 104) #(145 'REFERENCES' 105) #(145 'REPLACE' 106) #(145 'RESTRICT' 107) #(145 'ROW_FORMAT' 108) #(145 'SECONDARY_ENGINE_ATTRIBUTE' 109) #(145 'SET' 110) #(145 'SIMPLE' 111) #(145 'SMALLINT' 112) #(145 'SPATIAL' 113) #(145 'STATS_AUTO_RECALC' 114) #(145 'STATS_PERSISTENT' 115) #(145 'STATS_SAMPLE_PAGES' 116) #(145 'STORAGE' 117) #(145 'STORED' 118) #(145 'SUBPARTITION' 119) #(145 'SUBPARTITIONS' 120) #(145 'TABLE' 121) #(145 'TABLESPACE' 122) #(145 'TEMPORARY' 123) #(145 'TEXT' 124) #(145 'THAN' 125) #(145 'TIMESTAMP' 126) #(145 'TINYINT' 127) #(145 'TINYTEXT' 128) #(145 'UNION' 129) #(145 'UNIQUE' 130) #(145 'UNSIGNED' 139) #(145 'UPDATE' 131) #(145 'USING' 132) #(145 'VALUES' 133) #(145 'VARBINARY' 134) #(145 'VARCHAR' 135) #(145 'VIRTUAL' 136) #(145 'VISIBLE' 137) #(145 'WITH' 138))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
MysqlScanner >> emptySymbolTokenId [
	^ 257
]

{ #category : #generated }
MysqlScanner >> errorTokenId [
	^ 258
]

{ #category : #generated }
MysqlScanner >> keywordFor: aString [
	^ aString asUppercase
]

{ #category : #generated }
MysqlScanner >> scan1 [
	[ self step.
	currentCharacter == $'
		ifTrue: [ self recordMatch: #(140).
			self step.
			currentCharacter == $'
				ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
MysqlScanner >> scan2 [
	[ self step.
	currentCharacter == $*
		ifTrue: [ [ self step.
			currentCharacter == $* ] whileTrue.
			currentCharacter == $/
				ifTrue: [ ^ self recordAndReportMatch: #(143) ].
			^ self scan2 ].
	true ] whileTrue
]

{ #category : #generated }
MysqlScanner >> scanForToken [
	self step.
	currentCharacter == $'
		ifTrue: [ ^ self scan1 ].
	currentCharacter == $(
		ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $)
		ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $,
		ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	^ self scanForTokenX10
]

{ #category : #generated }
MysqlScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $-
		ifTrue: [ [ self recordMatch: #(143).
			self step.
			currentCharacter <= Character tab
				or: [ (currentCharacter between: Character pageUp and: Character newPage)
						or: [ currentCharacter >= (Character value: 14) ] ] ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX10 [
	currentCharacter == $-
		ifTrue:
			[ ^ self scanForTokenX1 ].
	currentCharacter == $/
		ifTrue:
			[ ^ self scanForTokenX9 ].
	currentCharacter == $0
		ifTrue:
			[ ^ self scanForTokenX7 ].
	currentCharacter == $1
		ifTrue:
			[ ^ self scanForTokenX6 ].
	currentCharacter == $2
		ifTrue:
			[ ^ self scanForTokenX5 ].
	currentCharacter == $;
		ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter == $=
		ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $`
		ifTrue:
			[ ^ self scanForTokenX2 ].
	currentCharacter isDigit
		ifTrue:
			[ ^ self scanForTokenX8 ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue:
			[ ^ self scanForTokenX3 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue:
			[ self scanForTokenX4 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX2 [
	self step.
	currentCharacter ~~ $`
		ifTrue: [ [ self step.
			currentCharacter == $`
				ifTrue: [ ^ self recordAndReportMatch: #(142) ].
			true ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX3 [
	[ self recordMatch: #(144).
	self step.
	currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX4 [
	[ self recordMatch: #(145).
	self step.
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ]
		whileTrue
]

{ #category : #generated }
MysqlScanner >> scanForTokenX5 [
	self recordMatch: #(11 141).
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(141).
			self step.
			currentCharacter isDigit ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX6 [
	self recordMatch: #(10 141).
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(141).
			self step.
			currentCharacter isDigit ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX7 [
	self recordMatch: #(9 141).
	self step.
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(141).
			self step.
			currentCharacter isDigit ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX8 [
	[ self recordMatch: #(141).
	self step.
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX9 [
	self step.
	currentCharacter == $*
		ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace)
]

{ #category : #generated }
MysqlScanner >> tokenClass [
	^SmaCCCaseInsensitiveToken
]
