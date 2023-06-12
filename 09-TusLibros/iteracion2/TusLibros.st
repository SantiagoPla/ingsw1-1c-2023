!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'FP 6/10/2023 23:33:25'!
defaultCatalog

	|pricedCatalog|
	
	pricedCatalog := Dictionary new.
	pricedCatalog at: self itemSellByTheStore put: 0.
	
	^pricedCatalog ! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'cart instances' stamp: 'FP 6/11/2023 23:59:02'!
cartWithManyItems

	|cartWithManyItems|
	
	cartWithManyItems := Cart acceptingItemsOf: self pricedCatalog.
	cartWithManyItems add: 'Book A'.
	cartWithManyItems add: 2 of: 'Book B'.
	
	^cartWithManyItems 
	! !

!CashierTest methodsFor: 'cart instances' stamp: 'FP 6/11/2023 23:58:30'!
cartWithOneItem
	
	| cartWithOneItem |
	
	cartWithOneItem := Cart acceptingItemsOf: self pricedCatalog.
	cartWithOneItem add: 'Book A'.
	
	^cartWithOneItem ! !

!CashierTest methodsFor: 'cart instances' stamp: 'FP 6/11/2023 23:53:00'!
emptyCart

	^ Cart acceptingItemsOf: OrderedCollection new! !


!CashierTest methodsFor: 'credit card instances' stamp: 'FP 6/12/2023 00:03:39'!
creditCardWithoutFunds

	^ CreditCard withNumber: 999 validUntil: (November of: 2023)! !

!CashierTest methodsFor: 'credit card instances' stamp: 'FP 6/12/2023 00:03:15'!
expiredCreditCard

	^ CreditCard withNumber: 1234 validUntil: (April of: 2023)! !

!CashierTest methodsFor: 'credit card instances' stamp: 'FP 6/12/2023 00:03:52'!
stolenCreditCard

	^ CreditCard withNumber: 888 validUntil: (November of: 2023)! !

!CashierTest methodsFor: 'credit card instances' stamp: 'FP 6/11/2023 23:52:28'!
validCreditCard

	^ CreditCard withNumber: 1234 validUntil: (November of: 2023)! !


!CashierTest methodsFor: 'test' stamp: 'FP 6/11/2023 23:54:07'!
test01CannotCheckoutEmptyCart

	|salesBook |
	
	salesBook := OrderedCollection new.
	
	self 
		should:  [Cashier 
				withCart: self emptyCart 
				chargingFrom: self validCreditCard 
				onDate: (June of: 2023) 
				registeringOn: salesBook
				withMerchantProcessor: MerchantProcessor new]
		raise:  Error - MessageNotUnderstood
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'No se puede hacer checkout de un carrito vacio'.
			self assert: salesBook isEmpty]! !

!CashierTest methodsFor: 'test' stamp: 'FP 6/11/2023 23:58:41'!
test02CheckoutOfCartWithOneItemReturnsTicketWithItemsPrice

	|salesBook |
	
	salesBook := OrderedCollection new.
	
	self assert: 25 equals: (Cashier 
						withCart: self cartWithOneItem 
						chargingFrom: self validCreditCard 
						onDate: (June of: 2023) 
						registeringOn: salesBook
						withMerchantProcessor: MerchantProcessor new) checkout.
	self assert: salesBook equals: (OrderedCollection with: 25).! !

!CashierTest methodsFor: 'test' stamp: 'FP 6/12/2023 00:05:06'!
test03CheckoutOfCartWithManyItemsReturnsTicketWithSumOfPrices

	|salesBook |
	
	salesBook := OrderedCollection new.
	
	self assert: 45 equals: (Cashier 
						withCart: self cartWithManyItems 
						chargingFrom: self validCreditCard 
						onDate: (June of: 2023) 
						registeringOn: salesBook
						withMerchantProcessor: MerchantProcessor new) checkout.
	self assert: salesBook equals: (OrderedCollection with: 45).! !

!CashierTest methodsFor: 'test' stamp: 'FP 6/12/2023 00:04:23'!
test04CannotCheckoutChargingExpiredCard

	|salesBook |
	
	salesBook := OrderedCollection new.
	
	self 
		should: [(Cashier 
				withCart: self cartWithOneItem 
				chargingFrom: self expiredCreditCard 
				onDate: (June of: 2023) 
				registeringOn: salesBook 
				withMerchantProcessor: MerchantProcessor new) checkout] 
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'Tarjeta vencida.'.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'test' stamp: 'FP 6/12/2023 00:05:33'!
test05CannotCheckoutChargingCardWithoutFunds

	|salesBook |
	
	salesBook := OrderedCollection new.
	
	self 
		should: [(Cashier 
				withCart: self cartWithOneItem 
				chargingFrom: self creditCardWithoutFunds 
				onDate: (June of: 2023) 
				registeringOn: salesBook
				withMerchantProcessor: MerchantProcessor new) checkout] 
		raise:  Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'Tarjeta sin saldo.'.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'test' stamp: 'FP 6/12/2023 00:06:02'!
test06CannotCheckoutChargingStolenCard

	|salesBook |
	
	salesBook := OrderedCollection new.
	
	self 
		should: [(Cashier 
				withCart: self cartWithOneItem 
				chargingFrom: self stolenCreditCard 
				onDate: (June of: 2023) 
				registeringOn: salesBook
				withMerchantProcessor: MerchantProcessor new) checkout] 
		raise:  Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: 'Tarjeta robada.'.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'catalog instances' stamp: 'FP 6/11/2023 23:56:45'!
pricedCatalog
	
	|pricedCatalog|
	
	pricedCatalog := Dictionary new.
	pricedCatalog at: 'Book A' put: 25.
	pricedCatalog at: 'Book B' put: 10.

	^pricedCatalog ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'FP 6/10/2023 23:25:55'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'FP 6/10/2023 23:29:23'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'FP 6/10/2023 23:30:30'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'FP 6/10/2023 23:30:14'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'accessing' stamp: 'FP 6/10/2023 23:35:35'!
items

	^items copy! !

!Cart methodsFor: 'accessing' stamp: 'FP 6/10/2023 23:35:47'!
pricedCatalog

	^catalog copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart card salesBook chargingDate date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'FP 6/11/2023 23:22:31'!
initializeWithCart: aCart chargingFrom: aCard onDate: aDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor 

	cart := aCart.
	card := aCard.
	date := aDate.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'checkout' stamp: 'FP 6/12/2023 00:09:28'!
checkout
	
	|total| 
	
	total := self sumItemsPrices.
	
	merchantProcessor debit: total from: card.
	salesBook add: total.
	
	^total! !

!Cashier methodsFor: 'checkout' stamp: 'FP 6/12/2023 00:09:28'!
sumItemsPrices

	^ cart items 
		inject: 0
		into: [:subtotal :anItem | subtotal + cart pricedCatalog at: anItem]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'FP 6/11/2023 23:42:00'!
withCart: aCart chargingFrom: aCardToCharge onDate: aChargingDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor 
	
	self assertCartIsNotEmpty: aCart. 
	self assertCard: aCardToCharge isNotExpiredOnDate: aChargingDate.

	^self new initializeWithCart: aCart chargingFrom: aCardToCharge onDate: aChargingDate registeringOn: aSalesBook withMerchantProcessor: aMerchantProcessor ! !


!Cashier class methodsFor: 'error messages' stamp: 'FP 6/11/2023 00:14:10'!
emptyCartErrorMessage

	^ 'No se puede hacer checkout de un carrito vacio'! !

!Cashier class methodsFor: 'error messages' stamp: 'FP 6/11/2023 00:13:59'!
expiredCardErrorMessage

	^ 'Tarjeta vencida.'! !


!Cashier class methodsFor: 'assertions' stamp: 'FP 6/11/2023 00:13:59'!
assertCard: aCardToCharge isNotExpiredOnDate: aChargingDate 
	
	(aCardToCharge expirationDate < aChargingDate ) ifTrue: [self error: self expiredCardErrorMessage].! !

!Cashier class methodsFor: 'assertions' stamp: 'FP 6/11/2023 00:14:10'!
assertCartIsNotEmpty: aCart

	^ aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage]! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'FP 6/11/2023 23:32:45'!
initializeWithNumber: aNumber validUntil: anExpirationDate 

	number := aNumber.
	expirationDate := anExpirationDate.! !


!CreditCard methodsFor: 'accessing' stamp: 'FP 6/11/2023 00:06:00'!
expirationDate

	^expirationDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'FP 6/11/2023 23:32:53'!
number 

	^number ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'FP 6/11/2023 23:37:48'!
withNumber: aNumber validUntil: anExpirationDate 

	^self new initializeWithNumber: aNumber validUntil: anExpirationDate ! !


!classDefinition: #MerchantProcessor category: 'TusLibros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'debit' stamp: 'FP 6/11/2023 23:46:42'!
debit: total from: aCreditCard 
	
	(aCreditCard number = 999) ifTrue: [self error: 'Tarjeta sin saldo.'].
	(aCreditCard number = 888) ifTrue: [self error: 'Tarjeta robada.']! !
