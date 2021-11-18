Class {
	#name : #MysqlScanner,
	#superclass : #SmaCCScanner,
	#category : #'SmaCC_Mysql'
}

{ #category : #'generated-initialization' }
MysqlScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(146 '''LZ4''' 1) #(146 '''N''' 2) #(146 '''NONE''' 3) #(146 '''Y''' 4) #(146 '''ZLIB''' 5) #(152 'ACTION' 14) #(152 'ALGORITHM' 15) #(152 'ALWAYS' 16) #(152 'AS' 17) #(152 'ASC' 18) #(152 'AUTOEXTEND_SIZE' 19) #(152 'AUTO_INCREMENT' 20) #(152 'AVG_ROW_LENGTH' 21) #(152 'BIGINT' 22) #(152 'BLOB' 23) #(152 'BTREE' 24) #(152 'BY' 25) #(152 'CASCADE' 26) #(152 'CHAR' 27) #(152 'CHARACTER' 28) #(152 'CHARSET' 29) #(152 'CHECK' 30) #(152 'CHECKSUM' 31) #(152 'COLLATE' 32) #(152 'COLUMNS' 33) #(152 'COLUMN_FORMAT' 34) #(152 'COMMENT' 35) #(152 'COMPACT' 36) #(152 'COMPRESSED' 37) #(152 'COMPRESSION' 38) #(152 'CONNECTION' 39) #(152 'CONSTRAINT' 40) #(152 'CREATE' 41) #(152 'CURRENT_TIMESTAMP' 42) #(152 'DATA' 43) #(152 'DATE' 44) #(152 'DATETIME' 45) #(152 'DECIMAL' 46) #(152 'DEFAULT' 47) #(152 'DELAY_KEY_WRITE' 48) #(152 'DELETE' 49) #(152 'DESC' 50) #(152 'DIRECTORY' 51) #(152 'DISK' 52) #(152 'DOUBLE' 53) #(152 'DROP' 54) #(152 'DYNAMIC' 55) #(152 'ENCRYPTION' 56) #(152 'ENFORCED' 57) #(152 'ENGINE' 58) #(152 'ENGINE_ATTRIBUTE' 59) #(152 'ENUM' 60) #(152 'EXISTS' 61) #(152 'FIRST' 62) #(152 'FIXED' 63) #(152 'FLOAT' 64) #(152 'FOREIGN' 65) #(152 'FULL' 66) #(152 'FULLTEXT' 67) #(152 'GENERATED' 68) #(152 'HASH' 69) #(152 'IF' 70) #(152 'IGNORE' 71) #(152 'IN' 72) #(152 'INDEX' 73) #(152 'INNODB' 77) #(152 'INSERT_METHOD' 74) #(152 'INT' 75) #(152 'INVISIBLE' 76) #(152 'JSON' 78) #(152 'KEY' 79) #(152 'KEY_BLOCK_SIZE' 80) #(152 'LAST' 81) #(152 'LESS' 82) #(152 'LIKE' 83) #(152 'LINEAR' 84) #(152 'LIST' 85) #(152 'LONGBLOB' 86) #(152 'LONGTEXT' 87) #(152 'MATCH' 88) #(152 'MAXVALUE' 89) #(152 'MAX_ROWS' 90) #(152 'MEDIUMBLOB' 91) #(152 'MEDIUMTEXT' 92) #(152 'MEMORY' 93) #(152 'MIN_ROWS' 94) #(152 'MYISAM' 95) #(152 'NO' 96) #(152 'NOT' 97) #(152 'NULL' 98) #(152 'ON' 99) #(152 'PACK_KEYS' 100) #(152 'PARSER' 101) #(152 'PARTIAL' 102) #(152 'PARTITION' 103) #(152 'PARTITIONS' 104) #(152 'PASSWORD' 105) #(152 'PRIMARY' 106) #(152 'RANGE' 107) #(152 'REDUNDANT' 108) #(152 'REFERENCES' 109) #(152 'REPLACE' 110) #(152 'RESTRICT' 111) #(152 'ROW_FORMAT' 112) #(152 'SECONDARY_ENGINE_ATTRIBUTE' 113) #(152 'SET' 114) #(152 'SIMPLE' 115) #(152 'SMALLINT' 116) #(152 'SPATIAL' 117) #(152 'STATS_AUTO_RECALC' 118) #(152 'STATS_PERSISTENT' 119) #(152 'STATS_SAMPLE_PAGES' 120) #(152 'STORAGE' 121) #(152 'STORED' 122) #(152 'SUBPARTITION' 123) #(152 'SUBPARTITIONS' 124) #(152 'TABLE' 125) #(152 'TABLESPACE' 126) #(152 'TEMPORARY' 127) #(152 'TEXT' 128) #(152 'THAN' 129) #(152 'TIME' 130) #(152 'TIMESTAMP' 131) #(152 'TINYINT' 132) #(152 'TINYTEXT' 133) #(152 'UNION' 134) #(152 'UNIQUE' 135) #(152 'UNSIGNED' 144) #(152 'UPDATE' 136) #(152 'USING' 137) #(152 'VALUES' 138) #(152 'VARBINARY' 139) #(152 'VARCHAR' 140) #(152 'VIRTUAL' 141) #(152 'VISIBLE' 142) #(152 'WITH' 143) #(152 'ZEROFILL' 145))
		do: [ :each | (keywordMap at: each first ifAbsentPut: [ Dictionary new ]) at: (each at: 2) put: each last ].
	^ keywordMap
]

{ #category : #generated }
MysqlScanner >> emptySymbolTokenId [
	^ 270
]

{ #category : #generated }
MysqlScanner >> errorTokenId [
	^ 271
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
			[ self recordMatch: #(146).
			self step.
			currentCharacter == $' ifTrue: [ ^ self scan1 ].
			^ self reportLastMatch ].
	true ] whileTrue
]

{ #category : #generated }
MysqlScanner >> scan2 [
	[ self recordMatch: #(148).
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
			[ [ self recordMatch: #(148).
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
			currentCharacter == $/ ifTrue: [ ^ self recordAndReportMatch: #(150) ].
			^ self scan4 ].
	true ] whileTrue
]

{ #category : #generated }
MysqlScanner >> scan5 [
	[ self recordMatch: #(147 148).
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
			[ [ self recordMatch: #(150).
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
			currentCharacter == $` ifTrue: [ ^ self recordAndReportMatch: #(149) ].
			true ] whileTrue ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX3 [
	self recordMatch: #(11 147 148).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX4 [
	self recordMatch: #(10 147 148).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX5 [
	self recordMatch: #(9 147 148).
	self step.
	currentCharacter == $. ifTrue: [ ^ self scan3 ].
	currentCharacter isDigit ifTrue: [ ^ self scan5 ].
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX6 [
	[ self recordMatch: #(151).
	self step.
	currentCharacter isSeparator or: [ currentCharacter == Character pageUp ] ] whileTrue.
	^ self reportLastMatch
]

{ #category : #generated }
MysqlScanner >> scanForTokenX7 [
	[ self recordMatch: #(152).
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
	^ #(nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil nil #comment #whitespace)
]

{ #category : #generated }
MysqlScanner >> tokenClass [
	^SmaCCCaseInsensitiveToken
]
