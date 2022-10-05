Extension { #name : #MooseAbstractGroup }

{ #category : #'*GToolkit4Ruby' }
MooseAbstractGroup >> allRailsApplicationRecords [
	<navigation: 'All Rails application records'>
	^ (self allRubyClasses entityNamed: #'ApplicationRecord') withSubclassHierarchy
]

{ #category : #'*GToolkit4Ruby' }
MooseAbstractGroup >> allRailsRoutes [
	<navigation: 'All Ruby routes'>
	^ self allWithType: GtRubyRoute
]

{ #category : #'*GToolkit4Ruby' }
MooseAbstractGroup >> allRailsUrlPaths [
	<navigation: 'All Rails url paths'>
	^ self allWithType: GtUrlPath
]

{ #category : #'*GToolkit4Ruby' }
MooseAbstractGroup >> allRubyClasses [
	<navigation: 'All Ruby classes'>
	^ self allWithType: GtRubyClass
]

{ #category : #'*GToolkit4Ruby' }
MooseAbstractGroup >> allRubyModules [
	<navigation: 'All Ruby modules'>
	^ self allWithType: GtRubyModule
]

{ #category : #'*GToolkit4Ruby' }
MooseAbstractGroup >> allTables [
	<navigation: 'All database tables'>
	^ self allWithType: GtTable
]
