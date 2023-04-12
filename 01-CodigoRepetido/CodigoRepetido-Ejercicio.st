!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 12:30:48'!
addAndSuspend: aClient from: aCustomerBook

	aCustomerBook addCustomerNamed: aClient. 
	aCustomerBook  suspendCustomerNamed: aClient. 
	! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 13:10:11'!
assertThatIfValuating: aClosure sendsTheError: anError then: anotherClosure
	
	aClosure on: anError do: anotherClosure 
! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 12:44:09'!
assertThatInBook: aCustomerBook numberOfCustomersIs: numberOfCustomers numberOfActiveCustomersIs: numberOfActiveCustomers numberOfSuspendedCustomersIs: numberOfSuspendedCustomers 
	
	self assert: numberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 13:08:16'!
assertThatValuating: aClosure takesLessThan: anAmountOfTime

	self assert: aClosure millisecondsToRun < anAmountOfTime
	
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 13:05:53'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.

	self assertThatValuating: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: 	50 * millisecond 
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 13:05:53'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertThatValuating: [	customerBook removeCustomerNamed: paulMcCartney] takesLessThan: 100 * millisecond
		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 13:10:11'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertThatIfValuating: [ customerBook addCustomerNamed: ''. self fail ] 
		sendsTheError: Error
		then: [ :anError | 
            			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
           	 		self assert: customerBook isEmpty ] 
	 
        ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 13:10:11'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThatIfValuating:  [ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ]
	sendsTheError: NotFound  
	then: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	

		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 12:46:41'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspend: paulMcCartney from: customerBook.
	
	self assertThatInBook: customerBook numberOfCustomersIs: 1 numberOfActiveCustomersIs: 0 numberOfSuspendedCustomersIs: 1.

	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 12:47:31'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspend: paulMcCartney from: customerBook.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatInBook: customerBook numberOfCustomersIs: 0 numberOfActiveCustomersIs: 0 numberOfSuspendedCustomersIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 13:10:11'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThatIfValuating:  [ customerBook suspendCustomerNamed: 'George Harrison'. self fail ]
	sendsTheError:  CantSuspend
	then: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FP 4/12/2023 13:10:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addAndSuspend: johnLennon from: customerBook.
	
	self assertThatIfValuating:  [ customerBook suspendCustomerNamed: johnLennon. self fail ]
	sendsTheError:  CantSuspend
	then: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
	

		   
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'FP 4/12/2023 14:52:24'!
addCustomerNamed: aName

	self signalIfCannotAddCustomerToBook: aName.
	active add: aName.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FP 4/12/2023 14:21:03'!
removeCustomerNamed: aName 
 
	self removeFromActiveOrSuspended: aName 
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'FP 4/12/2023 15:04:56'!
suspendCustomerNamed: aName 
	
	self signalIfCustomerNotActive: aName.	
	self moveActiveCustomerToSuspended: aName
! !


!CustomerBook methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 15:03:36'!
moveActiveCustomerToSuspended: aName.
	
	active remove: aName.
	suspended add: aName
! !

!CustomerBook methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 14:17:54'!
remove: anElement from: aCollection

	1 to: aCollection size do: 	
	[ :index |
		anElement = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ anElement 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 14:25:25'!
removeFromActiveOrSuspended: aName 
 
	[self remove: aName from: active]
	on: NotFound 
	do: [self remove: aName from: suspended]
	
	! !

!CustomerBook methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 14:51:45'!
signalIfCannotAddCustomerToBook: aName

	self signalIfCustomerNameIsEmpty: aName.
	self signalIfCustomerNameAlreadyInBook: aName
! !

!CustomerBook methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 14:46:23'!
signalIfCustomerNameAlreadyInBook: aName

	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
! !

!CustomerBook methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 14:45:19'!
signalIfCustomerNameIsEmpty: aName
	
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	

	
! !

!CustomerBook methodsFor: 'auxiliares' stamp: 'FP 4/12/2023 15:01:47'!
signalIfCustomerNotActive: aName	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
