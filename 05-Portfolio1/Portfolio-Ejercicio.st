!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'assertions' stamp: 'FP 5/22/2023 13:00:33'!
assertCannotAdd: aFinancialContainerToBeAdded to: aPortfolio
	
	self 
		should:  [aPortfolio add: aFinancialContainerToBeAdded ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: Portfolio cannotAddErrorMessage.
			]
	
		! !


!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:09:35'!
test08EmptyPorftolioHasBalanceZero 

	|portfolio |
	
	portfolio := Portfolio new. 
	
	self assert: 0 equals: portfolio balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:36:11'!
test09PortfolioIncludingOnlyAccountsHasSameBalanceAsTheirBalancesSum

	|portfolio account1 account2|
	
	portfolio := Portfolio new. 
	
	account1 := ReceptiveAccount new. 
	Deposit register:  100 on: account1. 
	account2 := ReceptiveAccount new. 
	Deposit register:  75 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.	
	
	self assert: 175 equals: portfolio balance.
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:36:38'!
test10PortfolioWithPortfoliosAndAccountsHasSameBalanceAsTheirBalanceSum

	|portfolio innerPortfolio account1 account2|
	
	portfolio := Portfolio new. 
	innerPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new. 
	Deposit register:  100 on: account1. 
	account2 := ReceptiveAccount new. 
	Deposit register:  75 on: account2.
	
	portfolio add: account1.
	innerPortfolio add: account2.	
	
	portfolio add: innerPortfolio.
	
	self assert: 175 equals: portfolio balance.
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:27:48'!
test11EmptyPortfolioHasNoRegisteredTransactions

	|portfolio account aDeposit|
	
	portfolio := Portfolio new. 
	account := ReceptiveAccount new.
	aDeposit := Deposit register:  100 on: account.
		
	self assert: false equals: (portfolio hasRegistered: aDeposit).
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:36:22'!
test12PortfolioOnlyWithAccountsHasSameRegisteredTransactionsAsAccounts

	|portfolio account1 account2 deposit1 deposit2|
	
	portfolio := Portfolio new. 
	
	account1 := ReceptiveAccount new. 
	deposit1:= Deposit register:  100 on: account1. 
	account2 := ReceptiveAccount new. 
	deposit2:= Deposit register:  75 on: account2.
	
	portfolio add: account1.
	portfolio add: account2.	
	
	self assert: true equals: (portfolio hasRegistered: deposit1).
	self assert: true equals: (portfolio hasRegistered: deposit2).	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:36:42'!
test13PortfolioWithPortfoliosAndAccountsHasSameRegisteredTransactionsAsThem

	|portfolio innerPortfolio account1 account2 deposit1 deposit2|
	
	portfolio := Portfolio new. 
	innerPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new. 
	deposit1 := Deposit register:  100 on: account1. 
	account2 := ReceptiveAccount new. 
	deposit2 := Deposit register:  75 on: account2.
	
	portfolio add: account1.
	innerPortfolio add: account2.	
	
	portfolio add: innerPortfolio.
	
	self assert: true equals: (portfolio hasRegistered: deposit1).
	self assert: true equals: (portfolio hasRegistered: deposit2).	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:40:04'!
test14EmptyPortfolioHasNoTransactions
	
	self assert: OrderedCollection new equals: Portfolio new transactions.
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/20/2023 11:40:59'!
test15PortfolioWithManyFinancialContainerHasSameTransactionsAsThem

	|portfolio innerPortfolio account1 account2 deposit1 deposit2 expectedTransactions|
	
	portfolio := Portfolio new. 
	innerPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new. 
	deposit1 := Deposit register:  100 on: account1. 
	account2 := ReceptiveAccount new. 
	deposit2 := Deposit register:  75 on: account2.
	
	portfolio add: account1.
	innerPortfolio add: account2.	
	
	portfolio add: innerPortfolio.
	
	expectedTransactions := OrderedCollection with: deposit1 with: deposit2.
	
	self assert: expectedTransactions equals: portfolio transactions.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/22/2023 13:01:07'!
test16PortfolioCannotAddItself

	|portfolio |
	portfolio := Portfolio new. 
	
	self assertCannotAdd: portfolio to: portfolio 
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/22/2023 13:00:56'!
test17CannotAddFinancialContainerThatIsAlreadyDirectlyConnectedToPortfolio

	|portfolio accountToBeAdded|
	
	portfolio := Portfolio new. 
	
	accountToBeAdded := ReceptiveAccount new. 
	portfolio add: accountToBeAdded . 
	
	self assertCannotAdd: accountToBeAdded to: portfolio.
	! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/22/2023 13:01:19'!
test18CannotAddFinancialContainerThatIsInsidePortfolioButNotDirectlyConnected

	|portfolio innerPortfolio accountToBeAdded|
	
	portfolio := Portfolio new. 
	innerPortfolio := Portfolio new.
	
	accountToBeAdded := ReceptiveAccount new. 
	Deposit register:  100 on: accountToBeAdded . 
	
	innerPortfolio add: accountToBeAdded .	
	portfolio add: innerPortfolio.
		
	self assertCannotAdd: accountToBeAdded to: portfolio 
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/22/2023 13:01:36'!
test19CannotAddFinancialContainerThatIncludesAnotherFinancialContainerThatIsAlreadyInsidePortfolio

	|portfolio1 portfolio2 portfolio3  account |
	
	portfolio1 := Portfolio new. 
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
		
	account := ReceptiveAccount new. 
	Deposit register:  100 on: account. 
	
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	
	portfolio3 add: account. 	
		
	self assertCannotAdd: portfolio3 to: portfolio1 
	

	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/22/2023 13:01:46'!
test20CannotAddFinancialContainerThatIsAParentsDescendantFromSiblingsBranches

	|portfolio parentPorftolio account|
	
	portfolio := Portfolio new. 
	parentPorftolio := Portfolio new.
			
	account := ReceptiveAccount new.
				
	parentPorftolio add: portfolio .
	parentPorftolio add: account.
	
		
	self assertCannotAdd: account to: portfolio 
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/22/2023 13:01:57'!
test21CannotAddFinancialContainerThatIsARootOrDescendantOfARoot

	|portfolio parentPorftolio grandparentPortfolio account|
	
	portfolio := Portfolio new. 
	parentPorftolio := Portfolio new.
	grandparentPortfolio := Portfolio new.
			
	account := ReceptiveAccount new.
				
	parentPorftolio add: portfolio.
	grandparentPortfolio add: account.
	grandparentPortfolio add: parentPorftolio.
		
	self assertCannotAdd: account to: portfolio 
	

! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'FP 5/22/2023 13:02:12'!
test22CannotAddFinancialContainerThatIncludesAnotherFinancialContainerThatIsARootOrDescendantOfARoot

	|portfolio aPortfolioToBeAdded parentPorftolio grandparentPortfolio account|
	
	portfolio := Portfolio new. 
	parentPorftolio := Portfolio new.
	grandparentPortfolio := Portfolio new.
	aPortfolioToBeAdded := Portfolio new.
	
	account := ReceptiveAccount new.
	aPortfolioToBeAdded add: account.
			
				
	parentPorftolio add: portfolio.
	grandparentPortfolio add: account.
	grandparentPortfolio add: parentPorftolio.
		
	self assertCannotAdd: aPortfolioToBeAdded to: portfolio 


! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'FP 5/20/2023 11:03:15'!
affectBalance: aBalanceToAffect 
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'FP 5/20/2023 11:03:52'!
affectBalance: aBalanceToAffect

	^aBalanceToAffect + value 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'FP 5/20/2023 11:04:17'!
affectBalance: aBalanceToAffefct 
	
	^aBalanceToAffefct - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialContainer category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialContainer
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialContainer methodsFor: 'hierarchy' stamp: 'FP 5/22/2023 12:26:26'!
addParent: aParentPortfolio

	parents add: aParentPortfolio ! !

!FinancialContainer methodsFor: 'hierarchy' stamp: 'FP 5/20/2023 12:35:22'!
hasAnythingIncludedIn: aFinancialContainer

	self subclassResponsibility ! !

!FinancialContainer methodsFor: 'hierarchy' stamp: 'FP 5/20/2023 12:22:58'!
includesFinancialContainer: aFinancialContainerToSearch

	self subclassResponsibility ! !


!FinancialContainer methodsFor: 'testing' stamp: 'FP 5/20/2023 11:39:07'!
hasRegistered: aTransaction 

	self subclassResponsibility ! !


!FinancialContainer methodsFor: 'transactions' stamp: 'FP 5/20/2023 11:39:20'!
transactions

	self subclassResponsibility ! !


!FinancialContainer methodsFor: 'initialization' stamp: 'FP 5/20/2023 13:16:13'!
initialize

	self subclassResponsibility ! !


!FinancialContainer methodsFor: 'balance' stamp: 'FP 5/20/2023 11:38:56'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialContainer subclass: #Portfolio
	instanceVariableNames: 'innerFinancialContainers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'FP 5/20/2023 11:37:23'!
balance
	
	^innerFinancialContainers sum: [:innerFinancialContainer | innerFinancialContainer balance] ifEmpty: [0].
	! !


!Portfolio methodsFor: 'hierarchy' stamp: 'FP 5/20/2023 13:04:47'!
add: aFinancialContainer
	
	self assertFinancialContainerHasNothingAlreadyIncludedInHierarchy: aFinancialContainer.
		
	innerFinancialContainers add: aFinancialContainer.
	aFinancialContainer addParent: self! !

!Portfolio methodsFor: 'hierarchy' stamp: 'FP 5/22/2023 12:44:30'!
hasAnythingIncludedIn: aFinancialContainer

	^(aFinancialContainer includesFinancialContainer: self)
		or: 
		(self anyOfMyDescendantsHasAnythingIncludedIn: aFinancialContainer)! !

!Portfolio methodsFor: 'hierarchy' stamp: 'FP 5/22/2023 12:43:38'!
includesFinancialContainer: aFinancialContainerToSearch

	^self = aFinancialContainerToSearch 
		or: 
		(self anyOfMyDescendantsIncludes: aFinancialContainerToSearch)! !

!Portfolio methodsFor: 'hierarchy' stamp: 'FP 5/22/2023 12:40:33'!
roots
	
	^parents 
		inject: (self addMyselfToEmptyListIfImRoot)
		into: [:allRoots :aParent | allRoots addAll: aParent roots]
! !


!Portfolio methodsFor: 'testing' stamp: 'FP 5/20/2023 11:37:55'!
hasRegistered: aTransaction 
	
	
	^innerFinancialContainers 
		anySatisfy: [:innerFinancialContainer| innerFinancialContainer hasRegistered: aTransaction]! !


!Portfolio methodsFor: 'initialization' stamp: 'FP 5/20/2023 12:51:54'!
initialize 

	innerFinancialContainers := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'assertions' stamp: 'FP 5/22/2023 12:46:35'!
assertFinancialContainerHasNothingAlreadyIncludedInHierarchy: aFinancialContainer

	^ (self hasGivenFinancialContainerAnythingIncludedInAnyRoot: aFinancialContainer)
		ifTrue: [self error: self class cannotAddErrorMessage ]! !


!Portfolio methodsFor: 'transactions' stamp: 'FP 5/20/2023 11:44:12'!
transactions
	
	^innerFinancialContainers 
		inject: OrderedCollection new
		into: [:accumulatedTransactions :innerFinancialContainer | 
				accumulatedTransactions , innerFinancialContainer transactions]! !


!Portfolio methodsFor: 'hierarchy - private' stamp: 'FP 5/22/2023 12:40:33'!
addMyselfToEmptyListIfImRoot

	^ parents isEmpty ifTrue: [OrderedCollection with: self] ifFalse: [OrderedCollection new]! !

!Portfolio methodsFor: 'hierarchy - private' stamp: 'FP 5/22/2023 12:44:30'!
anyOfMyDescendantsHasAnythingIncludedIn: aFinancialContainer

	^ innerFinancialContainers anySatisfy: [:innerFinancialContainer | innerFinancialContainer hasAnythingIncludedIn: aFinancialContainer ]! !

!Portfolio methodsFor: 'hierarchy - private' stamp: 'FP 5/22/2023 12:43:38'!
anyOfMyDescendantsIncludes: aFinancialContainerToSearch

	^ innerFinancialContainers 
			anySatisfy: [:innerFinancialContainer | innerFinancialContainer includesFinancialContainer: aFinancialContainerToSearch ]! !

!Portfolio methodsFor: 'hierarchy - private' stamp: 'FP 5/22/2023 12:46:35'!
hasGivenFinancialContainerAnythingIncludedInAnyRoot: aFinancialContainer

	^ self roots anySatisfy: [:aRoot | aFinancialContainer hasAnythingIncludedIn: aRoot]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FP 5/20/2023 11:49:38'!
cannotAddErrorMessage

	^'The financial container trying to be added is or includes a container already in hierarchy'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialContainer subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FP 5/20/2023 12:52:05'!
initialize

	transactions := OrderedCollection new.
	parents := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'FP 5/20/2023 11:02:17'!
balance

	^transactions 
		inject: 0 
		into: [:accumulatedBalance :aTransaction | aTransaction affectBalance: accumulatedBalance ].
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'hierarchy' stamp: 'FP 5/20/2023 12:35:40'!
hasAnythingIncludedIn: aFinancialContainer

	^aFinancialContainer includesFinancialContainer: self! !

!ReceptiveAccount methodsFor: 'hierarchy' stamp: 'FP 5/20/2023 12:24:51'!
includesFinancialContainer: aFinancialContainerToSearch

	^self = aFinancialContainerToSearch ! !
