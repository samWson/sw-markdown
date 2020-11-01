"
# SWMarkdownDocumentTest
"
Class {
	#name : #SWMarkdownDocumentTest,
	#superclass : #TestCase,
	#category : #'SWMarkdownDocument-Tests'
}

{ #category : #'tests - fixture' }
SWMarkdownDocumentTest >> expectedString [

	^ '
# A Level 1 Heading

This is the top paragraph. This is a block
of text. Below me is an unordered list:

- first item
- second item
- third item

## A Level 2 Heading

This is the next paragraph.

Below me is an ordered list:

1. first point
2. second point
3. third point 
' trim
]

{ #category : #tests }
SWMarkdownDocumentTest >> testAsString [

	| document |
	document := SWMarkdownDocument begin
		level: 1 heading: 'A Level 1 Heading';
		paragraph: 'This is the top paragraph. This is a block
of text. Below me is an unordered list:';
		unorderedList: { 
			'first item'.
			'second item'.
			'third item'.
		 };	
		level: 2 heading: 'A Level 2 Heading';
		paragraph: 'This is the next paragraph.

Below me is an ordered list:';
		orderedList: { 
			'first point'.
			'second point'.
			'third point'.
		 };
		end.
		
	self assert: document asString trim equals: self expectedString
]

{ #category : #tests }
SWMarkdownDocumentTest >> testLevelHeadingRaisesErrorWhenAboveMaximum [

	| exceptionalEvent |
	exceptionalEvent := [ SWMarkdownDocument begin level: 7 heading: 'A Level 7 Heading'; end ].
	
	self 
		should: exceptionalEvent
		raise: Error 
		description: 'Heading above maximum level of 6.'
]

{ #category : #tests }
SWMarkdownDocumentTest >> testLevelHeadingRaisesErrorWhenBelowMinimum [

	| exceptionalEvent |
	exceptionalEvent := [ SWMarkdownDocument begin level: 0 heading: 'A Level 0 Heading'; end ].
	
	self 
		should: exceptionalEvent 
		raise: Error 
		description: 'Heading below minimum level of 1.'
]
