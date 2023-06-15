!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'ARM 6/11/2023 13:50:03'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'ARM 6/11/2023 14:10:01'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: self creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = self creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'ARM 6/11/2023 14:09:42'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !

!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'tests' stamp: 'ARM 6/11/2023 14:00:14'!
test01CanCreateCartWithValidUserAndPassword

	| interface cartID |
	
	interface := self createDefaultInterface.

	cartID := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	self assert: (interface listCartIdentifiedAs: cartID) isEmpty! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/21/2013 23:03'!
test02CanNotCreateCartWithInvalidUser

	| interface |

	interface := self createDefaultInterface.

	self
		should: [ interface createCartFor: self invalidUser authenticatedWith: self validUserPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidUserAndOrPasswordErrorDescription ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/21/2013 23:06'!
test03CanNotCreateCartWithInvalidPassword

	| interface |

	interface := self createDefaultInterface.

	self
		should: [ interface createCartFor: self validUser authenticatedWith: self invalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidUserAndOrPasswordErrorDescription ]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/21/2013 23:15'!
test04CanAddItemsToACreatedCart

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		shouldnt: [interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/21/2013 23:24'!
test05CanNotAddItemToNotCreatedCart

	| interface |

	interface := self createDefaultInterface.

	self
		should: [interface add: self validBook quantity: 1 toCartIdentifiedAs: self invalidCartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidCartIdErrorDescription ]
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/21/2013 23:41'!
test06CanNotAddItemNotSellByTheStore

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [interface add: self invalidBook quantity: 1 toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidItemErrorMessage ]
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 00:05'!
test07ListCartOfAnEmptyCartReturnsAnEmptyBag

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self assert: (interface listCartIdentifiedAs: cartId) isEmpty 
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 00:08'!
test08CanNotListCartOfInvalidCartId

	| interface |

	interface := self createDefaultInterface.

	self 
		should: [interface listCartIdentifiedAs: self invalidCartId] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = interface invalidCartIdErrorDescription ]
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 00:15'!
test09ListCartReturnsTheRightNumberOfItems

	| interface cartId cartContent |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId.
	interface add: self anotherValidBook quantity: 2 toCartIdentifiedAs: cartId.
	cartContent := interface listCartIdentifiedAs: cartId.
	
	self assert: (cartContent occurrencesOf: self validBook) = 1. 
	self assert: (cartContent occurrencesOf: self anotherValidBook) = 2
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 11:08'!
test10CanCheckoutACart

	| interface cartId  |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId.
	self
		shouldnt: [interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 11:10'!
test11CanNotCheckoutANotCreatedCart

	| interface |

	interface := self createDefaultInterface.

	self
		should: [interface 
			checkOutCartIdentifiedAs: self invalidCartId  
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface invalidCartIdErrorDescription ]
		
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/22/2013 11:13'!
test12CanNotCheckoutAnEmptyCart

	| interface cartId |

	interface := self createDefaultInterface.

	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	self
		should: [interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = interface cartCanNotBeEmptyErrorMessage ]
		
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'sp 6/15/2023 15:55:21'!
test13CanNotAddItemsAfter30MinutesOfCreatingCart

	| interface cartId timer |

	timer := self defaultTimer.
	interface := self createDefaultInterfaceWithTimer: timer.
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	timer pass: 30 minutes.
	
	self
		should: [interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Cart timer expired.']
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'sp 6/15/2023 15:55:25'!
test14CanAddItemsBefore30MinutesOfLastAddition

	| interface cartId timer |

	timer := self defaultTimer.
	interface := self createDefaultInterfaceWithTimer: timer.
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	timer pass: 5 minutes.
	interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId .
	timer pass: 25 minutes.
	
	self
		shouldnt: [interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'sp 6/15/2023 15:55:28'!
test15CanNotListCartAfter30MinutesOfCreatingCart

	| interface cartId timer |

	timer := self defaultTimer.
	interface := self createDefaultInterfaceWithTimer: timer.	
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	timer pass: 30 minutes.
	
	self
		should: [interface listCartIdentifiedAs: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Cart timer expired.']
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'sp 6/15/2023 15:55:32'!
test16CanListCartBefore30MinutesOfLastListing

	| interface cartId timer |

	timer := self defaultTimer.
	interface := self createDefaultInterfaceWithTimer: timer.
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	timer pass: 5 minutes.
	interface listCartIdentifiedAs: cartId .
	timer pass: 25 minutes.
	
	self
		shouldnt: [interface listCartIdentifiedAs: cartId]
		raise: Error - MessageNotUnderstood
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'sp 6/15/2023 15:55:36'!
test17CanNotCheckoutCartAfter30MinutesOfCreatingCart

	| interface cartId timer |

	timer := self defaultTimer.
	interface := self createDefaultInterfaceWithTimer: timer.
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	timer pass: 30 minutes.
	
	self
		should: [interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = 'Cart timer expired.']
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'sp 6/15/2023 15:57:41'!
test18CanCheckoutCartBefore30MinutesOfLastOperation

	| interface cartId timer |

	timer := self defaultTimer.
	interface := self createDefaultInterfaceWithTimer: timer.
	cartId := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	interface add: self validBook quantity: 1 toCartIdentifiedAs: cartId .
	timer pass: 5 minutes.
	interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear.
	timer pass: 25 minutes.
	
	self
		shouldnt: [interface 
			checkOutCartIdentifiedAs: cartId 
			withCreditCardNumbered: '1111222233334444' 
			ownedBy: 'Juan Perez' 
			expiringOn: testObjectsFactory notExpiredMonthOfYear]
		raise: Error - MessageNotUnderstood
		! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'sp 6/15/2023 15:55:52'!
test19CanOperateWithACartAfter30MinutesOfOperatingWithAnotherCart

	| interface cart1Id cart2Id timer |

	timer := self defaultTimer.
	interface := self createDefaultInterfaceWithTimer: timer.
	cart1Id := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	timer pass: 30 minutes.
	cart2Id := interface createCartFor: self validUser authenticatedWith: self validUserPassword.
	
	self
		shouldnt: [interface add: self validBook quantity: 1 toCartIdentifiedAs: cart2Id]
		raise: Error - MessageNotUnderstood
	
		! !


!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/22/2013 00:15'!
anotherValidBook
	
	^testObjectsFactory anotherItemSellByTheStore ! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 23:49'!
invalidBook

	^testObjectsFactory itemNotSellByTheStore ! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 23:25'!
invalidCartId
	
	"Devuelvo nil porque seguro que siempre sera un id invalido, no importa que sea el id - Hernan"
	^nil! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 23:06'!
invalidPassword
	
	^'invalidPassword'! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 22:30'!
invalidUser

	^'invalidUser'! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 23:50'!
validBook
	
	^testObjectsFactory itemSellByTheStore ! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 22:27'!
validUser
	
	^'validUser'! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 22:28'!
validUserPassword
	
	^'validUserPassword'! !

!RestInterfaceTest methodsFor: 'object factory' stamp: 'HernanWilkinson 6/21/2013 22:43'!
validUsersAndPasswords
	
	^Dictionary new
		at: self validUser put: self validUserPassword;
		yourself! !


!RestInterfaceTest methodsFor: 'authenticator protocol' stamp: 'ARM 6/11/2023 13:57:02'!
is: aUser authenticatingWith: aPassword 
	| storedPassword |
	
	storedPassword := self validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !


!RestInterfaceTest methodsFor: 'interface creation' stamp: 'sp 6/15/2023 15:54:05'!
createDefaultInterface
	
	^RestInterface
		authenticatingWith: self
		acceptingItemsOf: testObjectsFactory defaultCatalog
		merchantProcessor: self
		withTimer: (self defaultTimer).! !

!RestInterfaceTest methodsFor: 'interface creation' stamp: 'sp 6/15/2023 15:54:36'!
createDefaultInterfaceWithTimer: timer

	^ RestInterface
		authenticatingWith: self
		acceptingItemsOf: testObjectsFactory defaultCatalog
		merchantProcessor: self
		withTimer: timer! !


!RestInterfaceTest methodsFor: 'timer creation' stamp: 'sp 6/15/2023 15:54:05'!
defaultTimer

	^ InterfaceTimer startAt: 0 minutes! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/21/2013 23:43'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 00:20'!
content
	
	^Bag new
		addAll: items;
		yourself ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ARM 6/11/2023 13:49:52'!
createSale

	^ total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InterfaceTimer category: 'TusLibros'!
Object subclass: #InterfaceTimer
	instanceVariableNames: 'duration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InterfaceTimer methodsFor: 'initialization' stamp: 'sp 6/15/2023 14:32:23'!
initializeStartAt: aDuration 

	duration := aDuration.! !


!InterfaceTimer methodsFor: 'as yet unclassified' stamp: 'sp 6/15/2023 14:57:32'!
currentTime
	
	^duration ! !

!InterfaceTimer methodsFor: 'as yet unclassified' stamp: 'sp 6/15/2023 14:52:52'!
pass: aDurationOfTime 
	
	
	duration := duration + aDurationOfTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InterfaceTimer class' category: 'TusLibros'!
InterfaceTimer class
	instanceVariableNames: ''!

!InterfaceTimer class methodsFor: 'instance creation' stamp: 'sp 6/15/2023 14:32:10'!
startAt: aDuration 
	
	^self new initializeStartAt: aDuration ! !


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'authenticationSystem carts catalog lastId merchantProcessor salesBook interfaceTimer timeOfLastOperation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'authenticator' stamp: 'ARM 6/11/2023 13:54:36'!
is: aUser authenticatingWith: aPassword 
	
	^authenticationSystem is: aUser authenticatingWith: aPassword 
! !


!RestInterface methodsFor: 'auxiliary' stamp: 'HernanWilkinson 6/22/2013 11:17'!
today
	
	^DateAndTime now! !

!RestInterface methodsFor: 'auxiliary' stamp: 'sp 6/15/2023 15:47:51'!
updateTimeOfLastOperationOfCart: aCartId

	^ timeOfLastOperation at: aCartId put: interfaceTimer currentTime! !


!RestInterface methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage
	
	^Cashier cartCanNotBeEmptyErrorMessage ! !

!RestInterface methodsFor: 'error messages' stamp: 'sp 6/15/2023 15:48:43'!
cartTimerExpiredErrorMessage

	^ 'Cart timer expired.'! !

!RestInterface methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription
	
	^'Invalid cart id'! !

!RestInterface methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage
	
	^Cart invalidItemErrorMessage ! !

!RestInterface methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription
	
	^'Invalid user and/or password'! !

!RestInterface methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId
	
	self error: self invalidCartIdErrorDescription ! !

!RestInterface methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword
	
	self error: self invalidUserAndOrPasswordErrorDescription! !


!RestInterface methodsFor: 'interface operations' stamp: 'sp 6/15/2023 15:50:11'!
add: aBook quantity: anAmount toCartIdentifiedAs: aCartId

	| cart |
	
	cart := carts at: aCartId ifAbsent: [ self signalInvalidCartId ].
	self assertTimeLessThan30MinutesPassedSinceLastOperationOfCart: aCartId.
	
	cart add: anAmount of: aBook.
	
	self updateTimeOfLastOperationOfCart: aCartId.! !

!RestInterface methodsFor: 'interface operations' stamp: 'sp 6/15/2023 15:50:20'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	| cart |
	
	cart := carts at: aCartId ifAbsent: [self signalInvalidCartId ].
	self assertTimeLessThan30MinutesPassedSinceLastOperationOfCart: aCartId.
	
	Cashier 
		toCheckout: cart 
		charging: (CreditCard expiringOn: anExpirationMonthOfYear) 
		throught: merchantProcessor 
		on: self today 
		registeringOn: salesBook.
		
	self updateTimeOfLastOperationOfCart: aCartId.! !

!RestInterface methodsFor: 'interface operations' stamp: 'sp 6/15/2023 15:43:54'!
createCartFor: aUser authenticatedWith: aPassword

	| cartId |
	
	(self is: aUser authenticatingWith: aPassword) ifFalse: [ self signalInvalidUserAndOrPassword ].
	
	
	cartId := self generateCartId.
	carts at: cartId put: (Cart acceptingItemsOf: catalog).
	timeOfLastOperation at: cartId put: interfaceTimer currentTime.
	
	^cartId ! !

!RestInterface methodsFor: 'interface operations' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId
	
	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una 
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"
	
	lastId := lastId + 1.
	^lastId! !

!RestInterface methodsFor: 'interface operations' stamp: 'sp 6/15/2023 15:49:56'!
listCartIdentifiedAs: aCartId

	| cart |
	
	cart := carts at: aCartId ifAbsent: [ self signalInvalidCartId ].
	self assertTimeLessThan30MinutesPassedSinceLastOperationOfCart: aCartId.
	
	self updateTimeOfLastOperationOfCart: aCartId.
	
	^cart content! !


!RestInterface methodsFor: 'assertions' stamp: 'sp 6/15/2023 15:48:43'!
assertTimeLessThan30MinutesPassedSinceLastOperationOfCart: aCartId

	^ (interfaceTimer currentTime >= ((timeOfLastOperation at: aCartId) + 30 minutes)) ifTrue: [self error: self cartTimerExpiredErrorMessage]! !


!RestInterface methodsFor: 'initialization' stamp: 'sp 6/15/2023 15:37:03'!
initializeAuthenticatingWith: anAuthenticationSystem acceptingItemsOf: aCatalog merchantProcessor: anMP withTimer: anInterfaceTimer 

	authenticationSystem := anAuthenticationSystem.
	catalog := aCatalog.
	carts := Dictionary new.
	lastId := 0.
	merchantProcessor := anMP.
	interfaceTimer := anInterfaceTimer.
	timeOfLastOperation := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'sp 6/15/2023 14:34:21'!
authenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog merchantProcessor: anMP withTimer: anInterfaceTimer 


	^self new initializeAuthenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog merchantProcessor: anMP withTimer: anInterfaceTimer ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStore
	
	^'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/22/2013 00:16'!
anotherItemSellByTheStorePrice
	
	^15! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/22/2013 00:16'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredCreditCard
	
	^CreditCard expiringOn: self notExpiredMonthOfYear! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/22/2013 11:06'!
notExpiredMonthOfYear

	^ Month month: today monthIndex year: today yearNumber + 1! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
