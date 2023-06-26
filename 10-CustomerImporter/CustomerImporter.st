!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'pepe sanchez assertions' stamp: 'sp 6/25/2023 21:27:39'!
assertPepeSanchezAddressesAreImportedCorrectly

	| setThatShouldOnlyIncludePepe customerPepeSanchez  |
	
	setThatShouldOnlyIncludePepe := self findCustomerInSessionByIDType: 'D' andNumber: '22333444'.
	customerPepeSanchez := setThatShouldOnlyIncludePepe anyOne.

	self assert: 2 equals: customerPepeSanchez addresses size.
	
	self assertThatCustomer:  customerPepeSanchez 
		hasStreetWithStreetName:  'San Martin'
		andStreetNumber:  3322
		andTown:  'Olivos'
		andZipCode:  1636
		andProvince: 'BsAs'.

	self assertThatCustomer:  customerPepeSanchez 
		hasStreetWithStreetName:   'Maipu'
		andStreetNumber:  888
		andTown:  'Florida'
		andZipCode:  1122
		andProvince: 'Buenos Aires'.


	
	! !

!ImportTest methodsFor: 'pepe sanchez assertions' stamp: 'sp 6/25/2023 21:28:26'!
assertPepeSanchezIsImportedCorrectlyWithoutCheckingAddresses

	| setThatShouldOnlyIncludePepe customerPepeSanchez  |
	

	setThatShouldOnlyIncludePepe := self findCustomerInSessionByIDType: 'D' andNumber: '22333444'.
	self deny: setThatShouldOnlyIncludePepe isEmpty.
	
	customerPepeSanchez := setThatShouldOnlyIncludePepe anyOne.
	
	self 
		assertCustomer: customerPepeSanchez 
		hasFirstName: 'Pepe' 
		andLastName: 'Sanchez' 
		andIDType: 'D' 
		andIDNumber: '22333444'.
	
	


	
	! !

!ImportTest methodsFor: 'pepe sanchez assertions' stamp: 'sp 6/25/2023 21:27:16'!
assertPepeSanchezIsImportedWithAddresses


	self assertPepeSanchezIsImportedCorrectlyWithoutCheckingAddresses.
	
	self  assertPepeSanchezAddressesAreImportedCorrectly.


	
	! !


!ImportTest methodsFor: 'juan perez assertions' stamp: 'sp 6/25/2023 21:29:36'!
assertJuanPerezAddressesAreImportedCorrectly

	| setThatShouldOnlyIncludeJuan customerJuanPerez |

	
	setThatShouldOnlyIncludeJuan := self findCustomerInSessionByIDType: 'C' andNumber: '23-25666777-9'.
	customerJuanPerez := setThatShouldOnlyIncludeJuan anyOne.
	
	self assert: 1 equals: customerJuanPerez addresses size.
	
	self assertThatCustomer:  customerJuanPerez
		hasStreetWithStreetName:   'Alem'
		andStreetNumber:  1122
		andTown:   'CABA'
		andZipCode:  1001
		andProvince: 'CABA'.
	


	
	
	 ! !

!ImportTest methodsFor: 'juan perez assertions' stamp: 'sp 6/25/2023 21:30:00'!
assertJuanPerezIsImportedCorrectlyWithoutCheckingAddresses

	| setThatShouldOnlyIncludeJuan customerJuanPerez |

	
	setThatShouldOnlyIncludeJuan := self findCustomerInSessionByIDType: 'C' andNumber: '23-25666777-9'.
	self deny: setThatShouldOnlyIncludeJuan isEmpty.
	
	customerJuanPerez := setThatShouldOnlyIncludeJuan anyOne.
	self assertCustomer: customerJuanPerez hasFirstName: 'Juan' andLastName: 'Perez' andIDType: 'C' andIDNumber: '23-25666777-9'.



	
	
	 ! !

!ImportTest methodsFor: 'juan perez assertions' stamp: 'sp 6/25/2023 21:30:15'!
assertJuanPerezIsImportedWithAddresses

	self assertJuanPerezIsImportedCorrectlyWithoutCheckingAddresses.
	
	self assertJuanPerezAddressesAreImportedCorrectly.


	
	
	 ! !


!ImportTest methodsFor: 'assertions' stamp: 'sp 6/25/2023 20:01:38'!
assertAddress: anAddress hasStreetName: expectedStreetName andStreetNumber: expectedStreetNumber andTown: expectedTown andZipCode: expectedZipCode andProvince: expectedProvince     

	self assert: expectedStreetName equals: anAddress streetName.
	self assert: expectedStreetNumber equals: anAddress streetNumber.
	self assert: expectedTown equals: anAddress town.
	self assert: expectedZipCode equals: anAddress zipCode.
	self assert: expectedProvince equals: anAddress province! !

!ImportTest methodsFor: 'assertions' stamp: 'sp 6/25/2023 20:00:08'!
assertCustomer: aCustomer hasFirstName: expectedFirstName andLastName: expectedLastName andIDType: expectedIdType andIDNumber: expectedIDNumber    

	self assert: expectedFirstName equals: aCustomer firstName.
	self assert: expectedLastName equals: aCustomer lastName.
	self assert: expectedIdType equals: aCustomer identificationType.
	self assert: expectedIDNumber equals: aCustomer identificationNumber! !

!ImportTest methodsFor: 'assertions' stamp: 'sp 6/25/2023 21:07:33'!
assertNumberOfCustomersEquals: expectedNumberOfCustomers

	^ self assert: expectedNumberOfCustomers equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'sp 6/25/2023 21:17:35'!
assertThatCustomer: aCustomer hasStreetWithStreetName: expectedStreetName andStreetNumber: expectedStreetNumber andTown: expectedTown andZipCode: expectedZipCode andProvince: expectedProvince
	
	| customerAddress |
	
	customerAddress := self findAddressFrom: aCustomer byStreetName: expectedStreetName.
	self 
		assertAddress: customerAddress 
		hasStreetName: expectedStreetName 
		andStreetNumber: expectedStreetNumber 
		andTown: expectedTown 
		andZipCode: expectedZipCode 
		andProvince: expectedProvince 
! !


!ImportTest methodsFor: 'auxiliary' stamp: 'sp 6/25/2023 21:32:34'!
findAddressFrom: aCustomer byStreetName: aStreetName 

	^ aCustomer addresses detect: [:anAddress | anAddress streetName = aStreetName]! !

!ImportTest methodsFor: 'auxiliary' stamp: 'sp 6/25/2023 19:54:13'!
findCustomerInSessionByIDType: anIDType andNumber: anIDNumber 

	^ session select: [:aCustomer | 
		aCustomer identificationType = anIDType and: 
		aCustomer identificationNumber = anIDNumber] ofType: Customer! !


!ImportTest methodsFor: 'tests' stamp: 'sp 6/25/2023 21:47:45'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
	inputStream := UniFileStream new open: 'input.txt' forWrite: false.! !

!ImportTest methodsFor: 'tests' stamp: 'sp 6/25/2023 21:47:58'!
tearDown

	session commit.
	session close.
	inputStream close.! !

!ImportTest methodsFor: 'tests' stamp: 'sp 6/25/2023 21:47:03'!
test01Import

	
	CustomerImporter new importCustomers: inputStream inSession: session.
	
	self assertNumberOfCustomersEquals: 2.
	
	self assertPepeSanchezIsImportedWithAddresses.
	
	self assertJuanPerezIsImportedWithAddresses.
	
	
	 ! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'importing' stamp: 'sp 6/25/2023 21:39:00'!
importCustomers: anInputStream inSession: aSession 

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'import' stamp: 'sp 6/25/2023 21:46:31'!
importCustomers: anInputStream inSession: aSession 

	"
	self importCustomers
	"
	| newCustomer line |

	line := anInputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth .
			aSession persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth .].

		line := anInputStream nextLine. ].

	! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
