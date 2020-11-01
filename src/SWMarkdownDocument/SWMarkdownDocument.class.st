"
# SWMarkdownDocument

I represent a Markdown format text document as an object. My methods
are designed so I can describe a document as a Domain Specific Language.

## Usage

A markdown document is described inside the `#begin` and `#end` messages.
After the `#end` message is received the entire document is answered and
can be stored in a variable.

```
| document |
document := MarkdownDocument begin
	level: 1 heading: 'A Level 1 Heading';
	text: 'This is a paragraph of free text';
	end.
	
document asString

""
# A Level 1 Heading

This is a paragraph of free text

""	
```

## Instance Variables

- stream: A stream that the document text is collected in.
"
Class {
	#name : #SWMarkdownDocument,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #SWMarkdownDocument
}

{ #category : #'instance creation' }
SWMarkdownDocument class >> begin [

	^ self new
]

{ #category : #converting }
SWMarkdownDocument >> asString [

	^ stream contents
]

{ #category : #'domain language' }
SWMarkdownDocument >> end [

	^ self yourself
]

{ #category : #initialization }
SWMarkdownDocument >> initialize [

	stream := WriteStream with: ''
]

{ #category : #'domain language' }
SWMarkdownDocument >> level: anInteger heading: aString [

	| hashes text |
	self signalErrorIfOutOfRange: anInteger.

	hashes := '#' repeat: anInteger.
	text := '{1} {2}' format: { hashes. aString }.
	
	stream
		<< text;
		cr;
		cr
]

{ #category : #'domain language' }
SWMarkdownDocument >> orderedList: aCollection [ 
	
	aCollection doWithIndex: [ :item :index | | line |
		line := '{1}. {2}' format: { index. item. }.
		stream
			<< line;
			cr
		 ].
	
	stream cr
]

{ #category : #'domain language' }
SWMarkdownDocument >> paragraph: aString [ 
	
	stream 
		<< aString;
		cr;
		cr
]

{ #category : #'error signalling' }
SWMarkdownDocument >> signalErrorIfOutOfRange: anInteger [

	| inRange |
	inRange := (1 to: 6) rangeIncludes: anInteger.

	inRange ifFalse: [ Error signal: 'Headings must have a level in the range of 1-6.' ]
]

{ #category : #'domain language' }
SWMarkdownDocument >> unorderedList: aCollection [ 
	
	aCollection do: [ :item | 
		stream 
			<< '- ';
			<< item;
			cr
			].
		
		stream cr
]
