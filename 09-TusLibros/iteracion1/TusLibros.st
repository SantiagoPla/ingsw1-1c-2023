!classDefinition: #TusLibrosTest category: 'TusLibros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'tests' stamp: 'FP 6/7/2023 00:23:07'!
test01NewCartStartsEmpty

	self assert: Cart new books isEmpty! !

!TusLibrosTest methodsFor: 'tests' stamp: 'FP 6/7/2023 00:48:20'!
test02BooksCanBeAddedOneAtATimeToCart

	|cart catalog|
	
	catalog := Set with: '1'.
	cart := Cart withCatalog: catalog.
	cart add: '1'.
	
	self assert: (Bag with: '1') equals: cart books! !

!TusLibrosTest methodsFor: 'tests' stamp: 'FP 6/7/2023 00:48:20'!
test03BooksCanBeAddedWithMultipleOccurrences

	|cart catalog|
	
	catalog := Set with: '1'.
	cart := Cart withCatalog: catalog.
	cart add: '1' withAmount: 3.
	
	self assert: (Bag new add: '1' withOccurrences: 3; yourself) equals: cart books! !

!TusLibrosTest methodsFor: 'tests' stamp: 'FP 6/7/2023 00:48:20'!
test04CannotAddNonPositiveAmountOfBooks

	|cart catalog|
	
	catalog := Set with: '1'.
	cart := Cart withCatalog: catalog.
	
	self 
		should: [cart add: '1' withAmount: 0.] 
		raise:  Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Cart nonPositiveBookUnitsErrorMessage ]
	
	! !

!TusLibrosTest methodsFor: 'tests' stamp: 'FP 6/7/2023 00:52:35'!
test05CannotAddBooksNotInCatalog

	|cart catalog|
	
	catalog := Set with: '1' with: '2' with: '3'.
	
	cart := Cart withCatalog: catalog.
	
	self 
		should: [cart add: '4'] 
		raise:  Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Cart bookNotInCatalogErrorMessage ]
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'adding books' stamp: 'FP 6/7/2023 00:51:44'!
add: aBookISBN 
	
	self add:  aBookISBN withAmount: 1! !

!Cart methodsFor: 'adding books' stamp: 'FP 6/7/2023 00:51:26'!
add: aBookISBN withAmount: anAmount
	
	self assertBookIsInCatalog: aBookISBN.
	self assertAmountOfBooksIsPositive: anAmount.
	
	books add: aBookISBN withOccurrences: anAmount ! !


!Cart methodsFor: 'assertions' stamp: 'FP 6/7/2023 00:38:59'!
assertAmountOfBooksIsPositive: anAmount

	^ anAmount < 1 ifTrue: [self signalNonPositiveBookUnits]! !

!Cart methodsFor: 'assertions' stamp: 'FP 6/7/2023 00:49:12'!
assertBookIsInCatalog: aBookISBN

	^ (catalog includes: aBookISBN) ifFalse: [self signalBookNotInCatalog]! !


!Cart methodsFor: 'accessing' stamp: 'FP 6/7/2023 00:23:07'!
books
	
	^books ! !


!Cart methodsFor: 'signals' stamp: 'FP 6/7/2023 00:50:14'!
signalBookNotInCatalog

	^ self error: self class bookNotInCatalogErrorMessage! !

!Cart methodsFor: 'signals' stamp: 'FP 6/7/2023 00:37:33'!
signalNonPositiveBookUnits

	^ self error: self class nonPositiveBookUnitsErrorMessage! !


!Cart methodsFor: 'initialization' stamp: 'FP 6/7/2023 00:22:46'!
initialize

	books := Bag new! !

!Cart methodsFor: 'initialization' stamp: 'FP 6/7/2023 00:46:12'!
initializeWithStock: aCatalog 

	catalog := aCatalog.
	books := Bag new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'FP 6/7/2023 00:50:04'!
bookNotInCatalogErrorMessage

	^ 'No se puede agregar un libro que no pertenece al catalogo.'! !

!Cart class methodsFor: 'error messages' stamp: 'FP 6/7/2023 00:37:48'!
nonPositiveBookUnitsErrorMessage 

	^'La cantidad de unidades del libro a agregar debe ser mayor a cero.'! !


!Cart class methodsFor: 'instance creation' stamp: 'FP 6/7/2023 00:48:20'!
withCatalog: aCatalog

	^self new initializeWithStock: aCatalog ! !
