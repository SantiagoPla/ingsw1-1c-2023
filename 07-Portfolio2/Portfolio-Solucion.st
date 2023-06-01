!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportsTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test01AccountSummaryOfEmptyReceptiveAccountIsEmpty

	self assert: (OrderedCollection with: 'Balance = 0') equals: (AccountSummaryPrinter with: ReceptiveAccount new) generateReport .! !

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test02AccountSummaryOfReceptiveAccountShowsDeposits
	
	|receptiveAccount expectedSummary|
	
	receptiveAccount := ReceptiveAccount new.
	Deposit register:  100 on: receptiveAccount.
	Deposit register:  200 on: receptiveAccount.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Deposito por 100'.
	expectedSummary add: 'Deposito por 200'.		
	expectedSummary add: 'Balance = 300'.
	
	self assert: expectedSummary equals: (AccountSummaryPrinter with: receptiveAccount) generateReport .! !

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test03AccountSummaryOfReceptiveAccountShowsWithdraws
	
	|receptiveAccount expectedSummary|
	
	receptiveAccount := ReceptiveAccount new.
	Deposit register:  200 on: receptiveAccount.
	Withdraw register: 100 on: receptiveAccount.
	Withdraw register: 50 on: receptiveAccount.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Deposito por 200'.
	expectedSummary add: 'Extraccion por 100'.		
	expectedSummary add: 'Extraccion por 50'.		
	expectedSummary add: 'Balance = 50'.
	
	self assert: expectedSummary equals: (AccountSummaryPrinter with: receptiveAccount) generateReport .! !

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test04AccountSummaryOfReceptiveAccountShowsDepositPaws
	
	|receptiveAccount expectedSummary|
	
	receptiveAccount := ReceptiveAccount new.
	Deposit register:  200 on: receptiveAccount.
	Withdraw register: 100 on: receptiveAccount.
	Transfer from: ReceptiveAccount new to: receptiveAccount for: 50.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Deposito por 200'.
	expectedSummary add: 'Extraccion por 100'.		
	expectedSummary add: 'Entrada por transferencia de 50'.		
	expectedSummary add: 'Balance = 150'.
	
	self assert: expectedSummary equals: (AccountSummaryPrinter with: receptiveAccount) generateReport .! !

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test05AccountSummaryOfReceptiveAccountShowsWithdrawPaws
	
	|receptiveAccount expectedSummary|
	
	receptiveAccount := ReceptiveAccount new.
	Deposit register:  200 on: receptiveAccount.
	Withdraw register: 100 on: receptiveAccount.
	Transfer from: receptiveAccount to: ReceptiveAccount new for: 50.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Deposito por 200'.
	expectedSummary add: 'Extraccion por 100'.		
	expectedSummary add: 'Salida por transferencia de 50'.		
	expectedSummary add: 'Balance = 50'.
	
	self assert: expectedSummary equals: (AccountSummaryPrinter with: receptiveAccount) generateReport .! !

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test06AccountSummaryOfEmptyPortfolioIsEmpty

	self assert: (OrderedCollection with: 'Balance = 0') equals: (AccountSummaryPrinter with: Portfolio new) generateReport .! !

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test07AccountSummaryOfPortfolioWithOnlyReceptiveAccountsShowsTheirTransactions
	|portfolio receptiveAccount1 receptiveAccount2 expectedSummary|
	
	receptiveAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Withdraw register: 50 on: receptiveAccount1.
	
	portfolio := Portfolio with: receptiveAccount1 with: receptiveAccount2.
	
	expectedSummary := OrderedCollection 
		with: 'Deposito por 100'
		with: 'Extraccion por 50'
		with: 'Balance = 50'.
		
	self assert: expectedSummary equals:  (AccountSummaryPrinter with: portfolio) generateReport .! !

!ReportsTest methodsFor: 'account summary' stamp: 'FP 5/31/2023 13:12:34'!
test08AccountSummaryOfPortfolioContainingPortfoliosShowsAllTransactions
	|portfolio innerPortfolio receptiveAccount1 receptiveAccount2 expectedSummary|
	
	receptiveAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Withdraw register: 50 on: receptiveAccount1.
	
	innerPortfolio := Portfolio with: receptiveAccount1.
	
	portfolio := Portfolio with: innerPortfolio with: receptiveAccount2.
	
	expectedSummary := OrderedCollection 
		with: 'Deposito por 100'
		with: 'Extraccion por 50'
		with: 'Balance = 50'.
		
	self assert: expectedSummary equals:  (AccountSummaryPrinter with: portfolio) generateReport .! !


!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test09TransferNetOfEmptyReceptiveAccountIsZero

	self assert:  0 equals: (TransferNetCalculator with: ReceptiveAccount new) generateReport ! !

!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test10TransferNetOfReceptiveAccountSumsDepositPaws
	|receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	Transfer from: ReceptiveAccount new to: receptiveAccount for: 100.
	Transfer from: ReceptiveAccount new to: receptiveAccount for: 200.	
	
	self assert: 300 equals: (TransferNetCalculator with: receptiveAccount) generateReport ! !

!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test11TransferNetOfReceptiveAccountDoesNotSumDeposits
	|receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	Transfer from: ReceptiveAccount new to: receptiveAccount for: 100.
	Deposit register: 50 on: receptiveAccount.
	
	self assert: 100 equals: (TransferNetCalculator with: receptiveAccount) generateReport ! !

!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test12TransferNetOfReceptiveAccountDoesNotSumWithdraws
	|receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	Transfer from: ReceptiveAccount new to: receptiveAccount for: 100.
	Withdraw register: 50 on: receptiveAccount.
	
	self assert: 100 equals: (TransferNetCalculator with: receptiveAccount) generateReport ! !

!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test13TransferNetOfReceptiveAccountSubtractsWithdrawPaws
	|receptiveAccount |
	
	receptiveAccount := ReceptiveAccount new.
	Transfer from: ReceptiveAccount new to: receptiveAccount for: 100.
	Transfer from: receptiveAccount to: ReceptiveAccount new for: 50.	
	
	self assert: 50 equals: (TransferNetCalculator with: receptiveAccount) generateReport ! !

!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test14TransferNetOfEmptyPortfolioIsZero

	self assert: 0 equals: (TransferNetCalculator with: Portfolio new) generateReport ! !

!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test15TransferNetOfPortfolioWithOnlyReceptiveAccountsShowsTheirTransferNet
	|portfolio receptiveAccount1 receptiveAccount2|
	
	receptiveAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Withdraw register: 50 on: receptiveAccount1.
	
	Transfer from: ReceptiveAccount new to: receptiveAccount1 for: 25.
	Transfer from: receptiveAccount2 to: ReceptiveAccount new for: 10.
	
	portfolio := Portfolio with: receptiveAccount1 with: receptiveAccount2.

	self assert: 15 equals:  (TransferNetCalculator with: portfolio) generateReport ! !

!ReportsTest methodsFor: 'transfer net' stamp: 'FP 5/31/2023 13:12:55'!
test16TransferNetOfPortfolioContainingPortfoliosAddsAllTransferNets
	|portfolio innerPortfolio receptiveAccount1 receptiveAccount2 |
	
	receptiveAccount1 := ReceptiveAccount new.
	Deposit register: 100 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount new.
	Withdraw register: 50 on: receptiveAccount1.
	
	Transfer from: ReceptiveAccount new to: receptiveAccount1 for: 25.
	Transfer from: receptiveAccount2 to: ReceptiveAccount new for: 10.
	
	innerPortfolio := Portfolio with: receptiveAccount1.
	
	portfolio := Portfolio with: innerPortfolio with: receptiveAccount2.
	
	self assert: 15 equals:  (TransferNetCalculator with: portfolio) generateReport ! !


!ReportsTest methodsFor: 'tree' stamp: 'FP 6/1/2023 13:04:23'!
test17TreeReportOfEmptyPortfolioOnlyShowsItsName

	self 
		assert: (OrderedCollection with: 'Portfolio de la familia') 
		equals: (PortfolioTreePrinter with: (Portfolio named: 'Portfolio de la familia')) generatePortfolioReport ! !

!ReportsTest methodsFor: 'tree' stamp: 'FP 6/1/2023 13:04:23'!
test18TreeReportOfPortfolioWithOnlyReceptiveAccountsShowsNamesCorrectlyIndented
	|portfolio receptiveAccount1 receptiveAccount2 expectedReport|
	
	receptiveAccount1 := ReceptiveAccount named: 'Cuenta de Juan'.
	receptiveAccount2 := ReceptiveAccount named: 'Cuenta de Angeles'.

	portfolio := Portfolio named: 'Portfolio de la familia' with: receptiveAccount1 with: receptiveAccount2.
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Portfolio de la familia'.
	expectedReport add: '    Cuenta de Juan'.
	expectedReport add: '    Cuenta de Angeles'.

	self assert: expectedReport equals:  (PortfolioTreePrinter with: portfolio) generatePortfolioReport ! !

!ReportsTest methodsFor: 'tree' stamp: 'FP 6/1/2023 13:59:19'!
test19TreeReportOfPortfolioContainingPortfoliosShowsAllNamesCorrectlyIndented
	|portfolio innerPortfolio receptiveAccount1 receptiveAccount2 receptiveAccount3 expectedReport|
	
	receptiveAccount1 := ReceptiveAccount named: 'Cuenta Mia'.	
	receptiveAccount2 := ReceptiveAccount named: 'Cuenta de Juan'.
	receptiveAccount3 := ReceptiveAccount named: 'Cuenta de Angeles'.
		
	innerPortfolio := Portfolio named: 'Portfolio de hijos' with: receptiveAccount2 with: receptiveAccount3.
	
	portfolio := Portfolio named: 'Portfolio de la familia' with: receptiveAccount1 with: innerPortfolio .
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Portfolio de la familia'.
	expectedReport add: '    Cuenta Mia'.
	expectedReport add: '    Portfolio de hijos'.
	expectedReport add: '        Cuenta de Juan'.
	expectedReport add: '        Cuenta de Angeles'.	
	

	
	self assert: expectedReport equals:  (PortfolioTreePrinter with: portfolio) generatePortfolioReport ! !


!ReportsTest methodsFor: 'transactions tree' stamp: 'FP 6/1/2023 13:34:32'!
test20TransactionsTreeReportOfPortfolioContainingPortfoliosShowsEverythingCorrectlyIndented
	|portfolio innerPortfolio receptiveAccount1 receptiveAccount2 receptiveAccount3 expectedReport|
	
	receptiveAccount1 := ReceptiveAccount named: 'Cuenta Mia'.	
	Deposit register: 100 on: receptiveAccount1.
	Withdraw register: 50 on: receptiveAccount1.
	
	receptiveAccount2 := ReceptiveAccount named: 'Cuenta de Juan'.
	receptiveAccount3 := ReceptiveAccount named: 'Cuenta de Angeles'.
	
	Transfer from: receptiveAccount2 to:  receptiveAccount3 for: 50.
		
	innerPortfolio := Portfolio named: 'Portfolio de hijos' with: receptiveAccount2 with: receptiveAccount3.
	
	portfolio := Portfolio named: 'Portfolio de la familia' with: receptiveAccount1 with: innerPortfolio .
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Portfolio de la familia'.
	expectedReport add: '    Cuenta Mia'.
	expectedReport add: '        Deposito por 100'.
	expectedReport add: '        Extraccion por 50'.
	expectedReport add: '        Balance = 50'.
	expectedReport add: '    Portfolio de hijos'.
	expectedReport add: '        Cuenta de Juan'.
	expectedReport add: '            Salida por transferencia de 50'.
	expectedReport add: '            Balance = -50'.
	expectedReport add: '        Cuenta de Angeles'.	
	expectedReport add: '            Entrada por transferencia de 50'.
	expectedReport add: '            Balance = 50'.
	expectedReport add: '        Balance = 0'.	
	expectedReport add: '    Balance = 50'.

	
	self assert: expectedReport equals:  (PortfolioTransactionsTreePrinter with: portfolio) generatePortfolioReport ! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'FP 5/29/2023 10:48:51'!
test01TransferCorrectlyAffectsBothAccountsBalance

	|transferingAccount transferedAccount|
	
	transferingAccount := ReceptiveAccount new.
	transferedAccount := ReceptiveAccount new.
	
	Transfer from: transferingAccount to: transferedAccount for: 100.
	
	self assert: 100 negated equals: transferingAccount balance.
	self assert: 100 equals: transferedAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'FP 5/29/2023 12:56:52'!
test02CanNavigateFromExtractionPawToDepositPawAndViceversa

	|transfer |
	
	transfer := Transfer from: ReceptiveAccount new to: ReceptiveAccount new for: 100.
	
	self assert: transfer withdrawPaw otherPaw equals: transfer depositPaw.
	self assert: transfer depositPaw otherPaw equals: transfer withdrawPaw.! !

!TransferTest methodsFor: 'tests' stamp: 'FP 5/29/2023 12:52:28'!
test03PawsAreRegisteredOnAccountsTransactions

    | transferingAccount transferedAccount transfer |

    transferingAccount := ReceptiveAccount new.
    transferedAccount := ReceptiveAccount new.

    transfer := Transfer from: transferingAccount to: transferedAccount for: 100.

   self assert: (transferingAccount hasRegistered: transfer withdrawPaw). 
   self assert: (transferedAccount hasRegistered: transfer depositPaw).! !

!TransferTest methodsFor: 'tests' stamp: 'FP 5/29/2023 12:55:25'!
test04PawsValuesEqualTransferValue

    | transferingAccount transferedAccount transfer |

    transferingAccount := ReceptiveAccount new.
    transferedAccount := ReceptiveAccount new.

    transfer := Transfer from: transferingAccount to: transferedAccount for: 100.

   self assert: 100 equals: transfer withdrawPaw value. 
   self assert: 100 equals: transfer depositPaw value.! !

!TransferTest methodsFor: 'tests' stamp: 'FP 5/30/2023 11:47:24'!
test05CannotTransferToSameAccount

    | receptiveAccount   |

    receptiveAccount := ReceptiveAccount new.

    self 
	should: [Transfer from: receptiveAccount to: receptiveAccount for: 100.] 
	raise: Error 
	withExceptionDo: [:anError | self assert: Transfer cannotTransferToSameAccountErrorDescription equals: anError messageText]

   ! !

!TransferTest methodsFor: 'tests' stamp: 'FP 5/30/2023 11:51:49'!
test06CannotTransferNonPositiveAmount

    self 
	should: [Transfer from: ReceptiveAccount new to: ReceptiveAccount new for: 0.] 
	raise: Error 
	withExceptionDo: [:anError | self assert: Transfer cannotTransferNonPositiveAmountErrorDescription equals: anError messageText]

   ! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'account reports' stamp: 'FP 6/1/2023 10:13:07'!
affectReportOn: aReportGenerator

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'FP 6/1/2023 10:31:35'!
name 

	^name! !


!Account methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:05:00'!
affectPortfolioReportOn: aTreeReportPrinter

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'FP 6/1/2023 10:20:54'!
initializeNamed: aName

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := aName! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'account reports' stamp: 'FP 6/1/2023 10:13:26'!
affectReportOn: aReportGenerator 
	
	accounts do:
		[ :anAccount | anAccount affectReportOn: aReportGenerator ].
		
	! !


!Portfolio methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:58:03'!
affectPortfolioReportOn: aPortfolioReportGenerator

	aPortfolioReportGenerator affectPortfolioReportWithPortfolio: self

	
! !

!Portfolio methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:58:10'!
makeInnerAccountsAffectPortfolioReportOn: aPortfolioReportGenerator

	accounts do: [:anAccount | anAccount affectPortfolioReportOn: aPortfolioReportGenerator ].
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'FP 6/1/2023 10:29:41'!
named: aName with: anAccount with: anotherAccount

	^self new initializeNamed: aName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'instance creation' stamp: 'FP 6/1/2023 10:20:32'!
named: aName 

	^self new initializeNamed: aName ! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'FP 6/1/2023 10:27:12'!
initializeNamed: aName

	super initialize.
	transactions := OrderedCollection new.
	name := aName! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'account reports' stamp: 'FP 5/31/2023 21:51:11'!
affectReportOn: aReportGenerator

	
	transactions do: [ :aTransaction | aTransaction affectReportOn: aReportGenerator]
	
! !


!ReceptiveAccount methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:55:05'!
affectPortfolioReportOn: aPortfolioReportGenerator

	aPortfolioReportGenerator affectPortfolioReportWithReceptiveAccount: self.
	
	
! !

!ReceptiveAccount methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:44:05'!
makeTransactionsAffectPortfolioReportOn: aPortfolioReportGenerator

	transactions do: [:aTransaction | aTransaction affectPortfolioReportOn: aPortfolioReportGenerator ]
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'FP 6/1/2023 10:26:40'!
named: aName 

	^self new initializeNamed: aName ! !


!classDefinition: #AccountReportGenerator category: 'Portfolio-Solucion'!
Object subclass: #AccountReportGenerator
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReportGenerator methodsFor: 'initialization' stamp: 'FP 5/31/2023 21:13:30'!
initializeWith: anAccount

	self subclassResponsibility ! !


!AccountReportGenerator methodsFor: 'report generation' stamp: 'FP 5/31/2023 21:14:48'!
generateReport

	self subclassResponsibility ! !


!AccountReportGenerator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:45:52'!
affectReportWithDeposit: aValue

	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:46:23'!
affectReportWithDepositPaw: aValue

	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:46:53'!
affectReportWithWithdraw: aValue

	self subclassResponsibility ! !

!AccountReportGenerator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:46:37'!
affectReportWithWithdrawPaw: aValue

	self subclassResponsibility ! !


!classDefinition: #AccountSummaryPrinter category: 'Portfolio-Solucion'!
AccountReportGenerator subclass: #AccountSummaryPrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryPrinter methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:48:03'!
affectReportWithDeposit: aDeposit

	report add: 'Deposito por ', aDeposit value asString! !

!AccountSummaryPrinter methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:47:58'!
affectReportWithDepositPaw: aDepositPaw

	report add: 'Entrada por transferencia de ', aDepositPaw value asString! !

!AccountSummaryPrinter methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:48:12'!
affectReportWithWithdraw: aWithdraw

	report add: 'Extraccion por ', aWithdraw value asString! !

!AccountSummaryPrinter methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:48:22'!
affectReportWithWithdrawPaw: aWithdrawPaw

	report add: 'Salida por transferencia de ', aWithdrawPaw value asString! !


!AccountSummaryPrinter methodsFor: 'initialization' stamp: 'FP 5/31/2023 21:14:00'!
initializeWith: anAccount

	account := anAccount.
	report := OrderedCollection new.! !


!AccountSummaryPrinter methodsFor: 'report generation' stamp: 'FP 5/31/2023 21:51:11'!
generateReport

	account affectReportOn: self.
	report add: 'Balance = ', account balance asString.
	^report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryPrinter class' category: 'Portfolio-Solucion'!
AccountSummaryPrinter class
	instanceVariableNames: ''!

!AccountSummaryPrinter class methodsFor: 'as yet unclassified' stamp: 'FP 5/31/2023 10:50:55'!
with: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #TransferNetCalculator category: 'Portfolio-Solucion'!
AccountReportGenerator subclass: #TransferNetCalculator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetCalculator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:47:06'!
affectReportWithDeposit: aDeposit

	! !

!TransferNetCalculator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:47:15'!
affectReportWithDepositPaw: aDepositPaw

	report := report + aDepositPaw value! !

!TransferNetCalculator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:47:20'!
affectReportWithWithdraw: aWithdraw

! !

!TransferNetCalculator methodsFor: 'transaction operations' stamp: 'FP 5/31/2023 21:47:30'!
affectReportWithWithdrawPaw: aWithdrawPaw

	report := report - aWithdrawPaw value! !


!TransferNetCalculator methodsFor: 'initialization' stamp: 'FP 5/31/2023 21:39:44'!
initializeWith: anAccount

	account := anAccount.
	report := 0! !


!TransferNetCalculator methodsFor: 'report generation' stamp: 'FP 5/31/2023 21:51:11'!
generateReport

	account affectReportOn: self.
	^report
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetCalculator class' category: 'Portfolio-Solucion'!
TransferNetCalculator class
	instanceVariableNames: ''!

!TransferNetCalculator class methodsFor: 'as yet unclassified' stamp: 'FP 5/31/2023 12:31:52'!
with: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:14:28'!
affectPortfolioReportOn: aPortfolioReportGenerator

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'account reports' stamp: 'FP 6/1/2023 10:14:46'!
affectReportOn: aReportGenerator

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:15:19'!
affectPortfolioReportOn: aPortfolioReportGenerator

	aPortfolioReportGenerator affectPortfolioReportWithDeposit: self! !


!Deposit methodsFor: 'account reports' stamp: 'FP 5/31/2023 21:45:58'!
affectReportOn: aReportGenerator
	
	^aReportGenerator affectReportWithDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferPaw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferPaw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferPaw methodsFor: 'initialization' stamp: 'FP 5/31/2023 11:21:44'!
initializeRegister: anAmount onAccount: aReceptiveAccount onTransfer: aTransfer
	
	aReceptiveAccount register: self.
	transfer := aTransfer. 
! !


!TransferPaw methodsFor: 'balance' stamp: 'FP 5/31/2023 11:20:58'!
affectBalance: aBalance

	self subclassResponsibility ! !


!TransferPaw methodsFor: 'transfer' stamp: 'FP 5/31/2023 11:22:27'!
otherPaw

	self subclassResponsibility ! !

!TransferPaw methodsFor: 'transfer' stamp: 'FP 5/31/2023 11:21:58'!
value

	^transfer value! !


!classDefinition: #DepositPaw category: 'Portfolio-Solucion'!
TransferPaw subclass: #DepositPaw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositPaw methodsFor: 'balance' stamp: 'FP 5/29/2023 14:24:18'!
affectBalance: aBalance

	^aBalance + self value ! !


!DepositPaw methodsFor: 'transfer' stamp: 'FP 5/29/2023 12:57:16'!
otherPaw
	
	^transfer withdrawPaw ! !


!DepositPaw methodsFor: 'account reports' stamp: 'FP 6/1/2023 10:15:08'!
affectReportOn: aReportGenerator
	
	^aReportGenerator affectReportWithDepositPaw: self ! !


!DepositPaw methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:15:33'!
affectPortfolioReportOn: aPortfolioReportGenerator

	aPortfolioReportGenerator affectPortfolioReportWithDepositPaw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositPaw class' category: 'Portfolio-Solucion'!
DepositPaw class
	instanceVariableNames: ''!

!DepositPaw class methodsFor: 'as yet unclassified' stamp: 'FP 5/29/2023 12:22:55'!
register: anAmount onAccount: anAccountToTransferTo onTransfer: aTransfer

	^self new initializeRegister: anAmount onAccount: anAccountToTransferTo onTransfer: aTransfer ! !


!classDefinition: #WithdrawPaw category: 'Portfolio-Solucion'!
TransferPaw subclass: #WithdrawPaw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawPaw methodsFor: 'balance' stamp: 'FP 5/29/2023 14:24:06'!
affectBalance: aBalance

	^aBalance - self value! !


!WithdrawPaw methodsFor: 'transfer' stamp: 'FP 5/29/2023 12:18:36'!
otherPaw
	
	^transfer depositPaw! !


!WithdrawPaw methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:16:02'!
affectPortfolioReportOn: aPortfolioReportGenerator

	aPortfolioReportGenerator affectPortfolioReportWithWithdrawPaw: self! !


!WithdrawPaw methodsFor: 'account reports' stamp: 'FP 6/1/2023 10:15:14'!
affectReportOn: aReportGenerator
	
	^aReportGenerator affectReportWithWithdrawPaw: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawPaw class' category: 'Portfolio-Solucion'!
WithdrawPaw class
	instanceVariableNames: ''!

!WithdrawPaw class methodsFor: 'as yet unclassified' stamp: 'FP 5/29/2023 12:22:55'!
register: anAmount onAccount: anAccountToTransferTo onTransfer: aTransfer

	^self new initializeRegister: anAmount onAccount: anAccountToTransferTo onTransfer: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'account reports' stamp: 'FP 6/1/2023 10:15:20'!
affectReportOn: aReportGenerator
	
	^aReportGenerator affectReportWithWithdraw: self! !


!Withdraw methodsFor: 'portfolio reports' stamp: 'FP 6/1/2023 13:16:46'!
affectPortfolioReportOn: aPortfolioReportGenerator

	aPortfolioReportGenerator affectPortfolioReportWithWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioReportGenerator category: 'Portfolio-Solucion'!
Object subclass: #PortfolioReportGenerator
	instanceVariableNames: 'portfolio report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReportGenerator methodsFor: 'initialization' stamp: 'FP 6/1/2023 12:57:07'!
initializeWith: aPortfolio 

	self subclassResponsibility ! !


!PortfolioReportGenerator methodsFor: 'account operations' stamp: 'FP 6/1/2023 13:03:44'!
affectPortfolioReportWithPortfolio: aPortfolio

	self subclassResponsibility ! !

!PortfolioReportGenerator methodsFor: 'account operations' stamp: 'FP 6/1/2023 13:04:01'!
affectPortfolioReportWithReceptiveAccount: aReceptiveAccount

	self subclassResponsibility ! !


!PortfolioReportGenerator methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:20:27'!
affectPortfolioReportWithDeposit: aDeposit

	self subclassResponsibility ! !

!PortfolioReportGenerator methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:20:31'!
affectPortfolioReportWithDepositPaw: aDepositPaw

	self subclassResponsibility ! !

!PortfolioReportGenerator methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:20:45'!
affectPortfolioReportWithWithdraw: aWithdraw

	self subclassResponsibility ! !

!PortfolioReportGenerator methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:20:42'!
affectPortfolioReportWithWithdrawPaw: aWithdrawPaw

	self subclassResponsibility ! !


!PortfolioReportGenerator methodsFor: 'report generation' stamp: 'FP 6/1/2023 13:04:23'!
generatePortfolioReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReportGenerator class' category: 'Portfolio-Solucion'!
PortfolioReportGenerator class
	instanceVariableNames: ''!

!PortfolioReportGenerator class methodsFor: 'as yet unclassified' stamp: 'FP 6/1/2023 13:48:43'!
with: aPortfolio

	^self new initializeWith: aPortfolio! !


!classDefinition: #PortfolioTransactionsTreePrinter category: 'Portfolio-Solucion'!
PortfolioReportGenerator subclass: #PortfolioTransactionsTreePrinter
	instanceVariableNames: 'indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTransactionsTreePrinter methodsFor: 'indentation' stamp: 'FP 6/1/2023 14:08:20'!
decreaseIndentation

	4 timesRepeat: [indentation := indentation allButLast]! !

!PortfolioTransactionsTreePrinter methodsFor: 'indentation' stamp: 'FP 6/1/2023 14:08:23'!
increaseIndentation

	4 timesRepeat: [indentation := indentation , ' ']! !

!PortfolioTransactionsTreePrinter methodsFor: 'indentation' stamp: 'FP 6/1/2023 14:04:50'!
indented: aBlock

	self increaseIndentation .
	aBlock value.
	self decreaseIndentation ! !


!PortfolioTransactionsTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:46:48'!
affectPortfolioReportWithDeposit: aDeposit


	report add: (indentation , ('Deposito por ', aDeposit value asString)).
! !

!PortfolioTransactionsTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:46:52'!
affectPortfolioReportWithDepositPaw: aDepositPaw


	report add: (indentation , ('Entrada por transferencia de ', aDepositPaw value asString)).
! !

!PortfolioTransactionsTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:46:55'!
affectPortfolioReportWithWithdraw: aWithdraw


	report add: (indentation , ('Extraccion por ', aWithdraw value asString)).
! !

!PortfolioTransactionsTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:46:59'!
affectPortfolioReportWithWithdrawPaw: aWithdrawPaw


	report add: (indentation , ('Salida por transferencia de ', aWithdrawPaw value asString)).
! !


!PortfolioTransactionsTreePrinter methodsFor: 'account operations' stamp: 'FP 6/1/2023 14:06:01'!
affectPortfolioReportWithPortfolio: aPortfolio

	self indented: [
		report add: (indentation , aPortfolio name).
		aPortfolio makeInnerAccountsAffectPortfolioReportOn: self.
	
		self indented: [report add: (indentation , ('Balance = ', aPortfolio balance asString)).]
	]! !

!PortfolioTransactionsTreePrinter methodsFor: 'account operations' stamp: 'FP 6/1/2023 14:06:45'!
affectPortfolioReportWithReceptiveAccount: aReceptiveAccount
	
	self indented: [
		report add: (indentation , aReceptiveAccount name).
	
		self indented: [
			aReceptiveAccount makeTransactionsAffectPortfolioReportOn: self.
			report add: (indentation , ('Balance = ', aReceptiveAccount balance asString)).
		]
	]
	! !


!PortfolioTransactionsTreePrinter methodsFor: 'report generation' stamp: 'FP 6/1/2023 13:56:51'!
generatePortfolioReport

	report add: portfolio name.
	portfolio makeInnerAccountsAffectPortfolioReportOn: self.
	
	report add: ('    ', 'Balance = ', portfolio balance asString).
	
	
	^report! !


!PortfolioTransactionsTreePrinter methodsFor: 'initialization' stamp: 'FP 6/1/2023 13:35:51'!
initializeWith: aPortfolio

	portfolio := aPortfolio.
	report := OrderedCollection new.
	indentation := ''.! !


!classDefinition: #PortfolioTreePrinter category: 'Portfolio-Solucion'!
PortfolioReportGenerator subclass: #PortfolioTreePrinter
	instanceVariableNames: 'indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'FP 6/1/2023 12:30:14'!
initializeWith: aPortfolio

	portfolio := aPortfolio.
	report := OrderedCollection new.
	indentation := ''.! !


!PortfolioTreePrinter methodsFor: 'report generation' stamp: 'FP 6/1/2023 13:42:53'!
generatePortfolioReport

	report add: portfolio name.
	portfolio makeInnerAccountsAffectPortfolioReportOn: self.
	
	^report! !


!PortfolioTreePrinter methodsFor: 'account operations' stamp: 'FP 6/1/2023 14:07:30'!
affectPortfolioReportWithPortfolio: aPortfolio

	self indented: [
		report add: (indentation , aPortfolio name).
		aPortfolio makeInnerAccountsAffectPortfolioReportOn: self.
	]! !

!PortfolioTreePrinter methodsFor: 'account operations' stamp: 'FP 6/1/2023 14:07:43'!
affectPortfolioReportWithReceptiveAccount: aReceptiveAccount
	
	self indented: [
		report add: (indentation , aReceptiveAccount name).
	]

	! !


!PortfolioTreePrinter methodsFor: 'indentation' stamp: 'FP 6/1/2023 14:08:13'!
decreaseIndentation

	4 timesRepeat: [indentation := indentation allButLast]! !

!PortfolioTreePrinter methodsFor: 'indentation' stamp: 'FP 6/1/2023 14:08:16'!
increaseIndentation

	4 timesRepeat: [indentation := indentation , ' ']! !

!PortfolioTreePrinter methodsFor: 'indentation' stamp: 'FP 6/1/2023 14:07:16'!
indented: aBlock

	self increaseIndentation .
	aBlock value.
	self decreaseIndentation ! !


!PortfolioTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:21:21'!
affectPortfolioReportWithDeposit: aDeposit

	! !

!PortfolioTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:21:16'!
affectPortfolioReportWithDepositPaw: aDepositPaw

	! !

!PortfolioTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:21:04'!
affectPortfolioReportWithWithdraw: aWithdraw

	! !

!PortfolioTreePrinter methodsFor: 'transaction operations' stamp: 'FP 6/1/2023 13:21:08'!
affectPortfolioReportWithWithdrawPaw: aWithdrawPaw

	! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'withdrawPaw depositPaw value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'FP 5/29/2023 14:22:20'!
initializeFrom: aTransferingAccount to: anAccountToTransferTo for: anAmount 
	
	depositPaw := DepositPaw register: anAmount onAccount: anAccountToTransferTo onTransfer: self.
	withdrawPaw := WithdrawPaw register: anAmount onAccount: aTransferingAccount onTransfer: self.
	value := anAmount ! !


!Transfer methodsFor: 'accessing' stamp: 'FP 5/29/2023 12:19:28'!
depositPaw

	^depositPaw! !

!Transfer methodsFor: 'accessing' stamp: 'FP 5/29/2023 14:22:31'!
value 

	^value! !

!Transfer methodsFor: 'accessing' stamp: 'FP 5/29/2023 12:19:14'!
withdrawPaw
	
	^withdrawPaw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FP 5/30/2023 14:38:47'!
assertAccountTransfering: aTransferingAccount isNotEqualTo: anAccountToTransferTo

	^ aTransferingAccount = anAccountToTransferTo ifTrue: [self error: self cannotTransferToSameAccountErrorDescription ]! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FP 5/30/2023 14:40:33'!
assertAmountTransferedIsPositive: anAmount

	^ anAmount <= 0 ifTrue: [self error: self cannotTransferNonPositiveAmountErrorDescription]! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FP 5/30/2023 11:50:18'!
cannotTransferNonPositiveAmountErrorDescription

	^'La transferencia debe ser por un monto mayor a cero'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FP 5/30/2023 11:48:07'!
cannotTransferToSameAccountErrorDescription

	^'No se puede transferir a la misma cuenta'! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'FP 5/30/2023 14:40:33'!
from: aTransferingAccount to: anAccountToTransferTo for: anAmount 
	
	self assertAccountTransfering: aTransferingAccount isNotEqualTo: anAccountToTransferTo.
	
	self assertAmountTransferedIsPositive: anAmount.
	
	^self new initializeFrom: aTransferingAccount to: anAccountToTransferTo for: anAmount ! !
