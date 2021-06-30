Extension { #name : #MooseAbstractGroup }

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
