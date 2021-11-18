Class {
	#name : #MysqlScanner,
	#superclass : #SmaCCScanner,
	#category : #'SmaCC_Mysql'
}

{ #category : #'generated-initialization' }
MysqlScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(143 '''LZ4''' 1) #(143 '''N''' 2) #(143 '''NONE''' 3) #(143 '''Y''' 4) #(143 '''ZLIB''' 5) #(149 'ACTION' 14) #(149 'ALGORITHM' 15) #(149 'ALWAYS' 16) #(149 'AS' 17) #(149 'ASC' 18) #(149 'AUTOEXTEND_SIZE' 19) #(149 'AUTO_INCREMENT' 20) #(149 'AVG_ROW_LENGTH' 21) #(149 'BIGINT' 22) #(149 'BLOB' 23) #(149 'BTREE' 24) #(149 'BY' 25) #(149 'CASCADE' 26) #(149 'CHAR' 27) #(149 'CHARACTER' 28) #(149 'CHARSET' 29) #(149 'CHECK' 30) #(149 'CHECKSUM' 31) #(149 'COLLATE' 32) #(149 'COLUMNS' 33) #(149 'COLUMN_FORMAT' 34) #(149 'COMMENT' 35) #(149 'COMPACT' 36) #(149 'COMPRESSED' 37) #(149 'COMPRESSION' 38) #(149 'CONNECTION' 39) #(149 'CONSTRAINT' 40) #(149 'CREATE' 41) #(149 'CURRENT_TIMESTAMP' 42) #(149 'DATA' 43) #(149 'DATE' 44) #(149 'DATETIME' 45) #(149 'DECIMAL' 46) #(149 'DEFAULT' 47) #(149 'DELAY_KEY_WRITE' 48) #(149 'DELETE' 49) #(149 'DESC' 50) #(149 'DIRECTORY' 51) #(149 'DISK' 52) #(149 'DOUBLE' 53) #(149 'DYNAMIC' 54) #(149 'ENCRYPTION' 55) #(149 'ENFORCED' 56) #(149 'ENGINE' 57) #(149 'ENGINE_ATTRIBUTE' 58) #(149 'ENUM' 59) #(149 'EXISTS' 60) #(149 'FIRST' 61) #(149 'FIXED' 62) #(149 'FLOAT' 63) #(149 'FOREIGN' 64) #(149 'FULL' 65) #(149 'FULLTEXT' 66) #(149 'GENERATED' 67) #(149 'HASH' 68) #(149 'IF' 69) #(149 'IGNORE' 70) #(149 'IN' 71) #(149 'INDEX' 72) #(149 'INNODB' 76) #(149 'INSERT_METHOD' 73) #(149 'INT' 74) #(149 'INVISIBLE' 75) #(149 'JSON' 77) #(149 'KEY' 78) #(149 'KEY_BLOCK_SIZE' 79) #(149 'LAST' 80) #(149 'LESS' 81) #(149 'LIKE' 82) #(149 'LINEAR' 83) #(149 'LIST' 84) #(149 'LONGBLOB' 85) #(149 'LONGTEXT' 86) #(149 'MATCH' 87) #(149 'MAXVALUE' 88) #(149 'MAX_ROWS' 89) #(149 'MEDIUMBLOB' 90) #(149 'MEDIUMTEXT' 91) #(149 'MEMORY' 92) #(149 'MIN_ROWS' 93) #(149 'NO' 94) #(149 'NOT' 95) #(149 'NULL' 96) #(149 'ON' 97) #(149 'PACK_KEYS' 98) #(149 'PARSER' 99) #(149 'PARTIAL' 100) #(149 'PARTITION' 101) #(149 'PARTITIONS' 102) #(149 'PASSWORD' 103) #(149 'PRIMARY' 104) #(149 'RANGE' 105) #(149 'REDUNDANT' 106) #(149 'REFERENCES' 107) #(149 'REPLACE' 108) #(149 'RESTRICT' 109) #(149 'ROW_FORMAT' 110) #(149 'SECONDARY_ENGINE_ATTRIBUTE' 111) #(149 'SET' 112) #(149 'SIMPLE' 113) #(149 'SMALLINT' 114) #(149 'SPATIAL' 115) #(149 'STATS_AUTO_RECALC' 116) #(149 'STATS_PERSISTENT' 117) #(149 'STATS_SAMPLE_PAGES' 118) #(149 'STORAGE' 119) #(149 'STORED' 120) #(149 'SUBPARTITION' 121) #(149 'SUBPARTITIONS' 122) #(149 'TABLE' 123) #(149 'TABLESPACE' 124) #(149 'TEMPORARY' 125) #(149 'TEXT' 126) #(149 'THAN' 127) #(149 'TIMESTAMP' 128) #(149 'TINYINT' 129) #(149 'TINYTEXT' 130) #(149 'UNION' 131) #(149 'UNIQUE' 132) #(149 'UNSIGNED' 141) #(149 'UPDATE' 133) #(149 'USING' 134) #(149 'VALUES' 135) #(149 'VARBINARY' 136) #(149 'VARCHAR' 137) #(149 'VIRTUAL' 138) #(149 'VISIBLE' 139) #(149 'WITH' 140) #(149 'ZEROFILL' 142))
		do: [ :each | (keywordMap at: each first ifAbsentPut: [ Dictionary new ]) at: (each at: 2) put: each last ].
	^ keywordMap
]

{ #category : #generated }
MysqlScanner >> emptySymbolTokenId [
	^ 266
]

{ #category : #generated }
MysqlScanner >> errorTokenId [
	^ 267
]

{ #category : #generated }
MysqlScanner >> keywordFor: aString [
	^ aString asUppercase
]

{ #category : #generated }
MysqlScanner >> scan1 [
	[ self step.
	currentCharacter == $'
		ifTrue:
			[ self recordMatch: #(143).
			self step.
			currentCharacter == $' ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
MysqlScanner >> scan2 [
	[ self recordMatch: #(145).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scan3 [
	self step.
	currentCharacter isDigit
		ifTrue:
			[ [ self recordMatch: #(145).
			self step.
			currentCharacter isDigit ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scan4 [
	[ self step.
	currentCharacter == $*
		ifTrue:
			[ [ self step.
			currentCharacter == $* ] whileTrue.
			currentCharacter == $/ ifTrue: [ ^ self recordAndReportMatch: #(147) ].
			^ self scan4 ].
	true ] whileTrue
]

{ #category : #generated }
MysqlScanner >> scan5 [
	[ self recordMatch: #(144 145).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForToken [
	self step.
	currentCharacter == $' ifTrue: [ ^ self scan1 ].
	currentCharacter == $( ifTrue: [ ^ self recordAndReportMatch: #(6) ].
	currentCharacter == $) ifTrue: [ ^ self recordAndReportMatch: #(7) ].
	currentCharacter == $+ ifTrue: [ ^ self scanForTokenX9 ].
	currentCharacter == $, ifTrue: [ ^ self recordAndReportMatch: #(8) ].
	^ self scanForTokenX10
]

{ #category : #generated }
MysqlScanner >> scanForTokenX1 [
	self step.
	currentCharacter == $-
		ifTrue:
			[ [ self recordMatch: #(147).
			self step.
			currentCharacter <= Character tab
				or:
					[ (currentCharacter between: Character pageUp and: Character newPage) or: [ currentCharacter >= (Character value: 14) ] ] ]
				whileTrue.
			^ self reportLastMatch ].
	currentCharacter isDigit ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX10 [
	currentCharacter == $- ifTrue: [ ^ self scanForTokenX1 ].
	currentCharacter == $/ ifTrue: [ ^ self scanForTokenX8 ].
	currentCharacter == $0 ifTrue: [ ^ self scanForTokenX5 ].
	currentCharacter == $1 ifTrue: [ ^ self scanForTokenX4 ].
	currentCharacter == $2 ifTrue: [ ^ self scanForTokenX3 ].
	currentCharacter == $; ifTrue: [ ^ self recordAndReportMatch: #(12) ].
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(13) ].
	currentCharacter == $` ifTrue: [ ^ self scanForTokenX2 ].
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	(currentCharacter isSeparator or: [ currentCharacter == Character pageUp ]) ifTrue: [ ^ self scanForTokenX6 ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ]) ifTrue: [ self scanForTokenX7 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX2 [
	self step.
	currentCharacter ~~ $`
		ifTrue:
			[ [ self step.
			currentCharacter == $` ifTrue: [ ^ self recordAndReportMatch: #(146) ].
			true ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX3 [
	self recordMatch: #(11 144 145).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX4 [
	self recordMatch: #(10 144 145).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX5 [
	self recordMatch: #(9 144 145).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX6 [
	[ self recordMatch: #(148).
	self step.
	currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX7 [
	[ self recordMatch: #(149).
	self step.
	currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue
]

{ #category : #generated }
MysqlScanner >> scanForTokenX8 [
	self step.
	currentCharacter == $* ifTrue: [ ^ self scan4 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX9 [
	self step.
	currentCharacter isDigit ifTrue: [ ^ self scan2 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> tokenActions [
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace)
]

{ #category : #generated }
MysqlScanner >> tokenClass [
	^SmaCCCaseInsensitiveToken
]
