!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:29:37'!
test01ValidInputStreamIsImportedCorrectly

	CustomerImporter importFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 16:49:37'!
test02CannotImportEmptyStream

	self 
		should:  [CustomerImporter importFrom: (ReadStream on: '')  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: 'Error al importar el archivo' equals: anError messageText.
			self assert: (session selectAllOfType: Customer) isEmpty]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:43:59'!
test03CannotImportStreamContainingAddressWithoutCustomer

	self 
		should:  [CustomerImporter importFrom: self streamWithAddressAndNoCustomers  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: (session selectAllOfType: Customer) isEmpty.
			self assert: 'Error al importar el archivo' equals: anError messageText]

! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:02'!
test04CannotImportStreamContainingIncompleteCustomer

	self 
		should:  [CustomerImporter importFrom: self streamWithIncompleteCustomer  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: (session selectAllOfType: Customer) isEmpty.
			self assert: 'Error al importar el archivo' equals: anError messageText]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:05'!
test05CannotImportStreamContainingOverflowedCustomer

	self 
		should:  [CustomerImporter importFrom: self streamWithOverflowedCustomer  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: (session selectAllOfType: Customer) isEmpty.
			self assert: 'Error al importar el archivo' equals: anError messageText]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:08'!
test06CannotImportStreamContainingIncompleteAddress

	self 
		should:  [CustomerImporter importFrom: self streamWithIncompleteAddress  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: 'Error al importar el archivo' equals: anError messageText.
			self assert: (session selectAllOfType: Customer) size = 1.
			self assert: (session selectAllOfType: Address) isEmpty 
			]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:10'!
test07CannotImportStreamContainingOverflowedAddress

	self 
		should:  [CustomerImporter importFrom: self streamWithOverflowedAddress  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: 'Error al importar el archivo' equals: anError messageText.
			self assert: (session selectAllOfType: Customer) size = 1.
			self assert: (session selectAllOfType: Address) isEmpty ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:12'!
test08ShouldOnlyImportCustomerWhenLinesFirstEntryIsExactlyC

	self 
		should:  [CustomerImporter importFrom: self streamWithInvalidTypeOfCustomer  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: 'Error al importar el archivo' equals: anError messageText.
			self assert: (session selectAllOfType: Customer) isEmpty]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:15'!
test09ShouldOnlyImportAddressWhenLinesFirstEntryIsExactlyA

	self 
		should:  [CustomerImporter importFrom: self streamWithInvalidTypeOfAddress  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: 'Error al importar el archivo' equals: anError messageText.
			self assert: (session selectAllOfType: Customer) size = 1.
			self assert: (session selectAllOfType: Address) isEmpty]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:17'!
test10ShouldNotImportAddressWhenStreetNumberIsNotANumber

	self 
		should:  [CustomerImporter importFrom: self streamWithInvalidAddressStreetNumber  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: 'Error al importar el archivo' equals: anError messageText.
			self assert: (session selectAllOfType: Customer) size = 1.
			self assert: (session selectAllOfType: Address) isEmpty]

	! !

!ImportTest methodsFor: 'tests' stamp: 'FP 6/28/2023 17:44:19'!
test11ShouldNotImportAddressWhenZipCodeIsNotANumber

	self 
		should:  [CustomerImporter importFrom: self streamWithInvalidAddressZipCode  into: session]
		raise: Error
		withExceptionDo: [:anError | 
			self assert: 'Error al importar el archivo' equals: anError messageText.
			self assert: (session selectAllOfType: Customer) size = 1.
			self assert: (session selectAllOfType: Address) isEmpty]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:31:25'!
streamWithAddressAndNoCustomers

	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:33:17'!
streamWithIncompleteAddress

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,Maipu,888'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:31:09'!
streamWithIncompleteCustomer

	^ ReadStream on: 'C,Pepe,Sanchez'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:37:16'!
streamWithInvalidAddressStreetNumber

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,treinta,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:37:32'!
streamWithInvalidAddressZipCode

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,diez,BsAs'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:36:18'!
streamWithInvalidTypeOfAddress

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
Address,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:34:29'!
streamWithInvalidTypeOfCustomer

	^ ReadStream on: 'Customer,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:33:38'!
streamWithOverflowedAddress

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,Maipu,888,Florida,1122,Buenos Aires,estoy,pasado'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'FP 6/28/2023 17:31:44'!
streamWithOverflowedCustomer

	^ ReadStream on: 'C,Pepe,Sanchez, D, 22333444,estoy,pasado'! !

!ImportTest methodsFor: 'testing stream inputs' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


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


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

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

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream currentCustomer line record currentAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'import' stamp: 'FP 6/28/2023 16:45:27'!
import

	self streamLinesDo: [self processLine]! !


!CustomerImporter methodsFor: 'auxiliary' stamp: 'FP 6/28/2023 16:39:13'!
getRecordFromLine

	^ line findTokens: $,! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'FP 6/28/2023 17:11:01'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'FP 6/28/2023 17:08:22'!
isCustomerRecord

	^record first = 'C' ! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'FP 6/28/2023 17:40:10'!
processAddressRecord

	self assertValidAddressRecord.
	
	currentAddress := Address new.
	
	currentCustomer addAddress: currentAddress.
	currentAddress streetName: record second.
	currentAddress streetNumber: record third asNumber .
	currentAddress town: record fourth.
	currentAddress zipCode: record fifth asNumber .
	currentAddress province: record sixth! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'FP 6/28/2023 16:56:58'!
processCustomerRecord

	self assertRecordHasFiveEntries.
	
	currentCustomer := Customer new.
	
	currentCustomer firstName: record second.
	currentCustomer lastName: record third.
	currentCustomer identificationType: record fourth.
	currentCustomer identificationNumber: record fifth.
	
	session persist: currentCustomer! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'FP 6/28/2023 17:25:38'!
processLine

	record := self getRecordFromLine.
	self isCustomerRecord 
		ifTrue: [self processCustomerRecord]
		ifFalse:[self isAddressRecord 
				ifTrue: [self processAddressRecord]
				ifFalse: [self error: 'Error al importar el archivo']]
	! !

!CustomerImporter methodsFor: 'auxiliary' stamp: 'FP 6/28/2023 16:52:03'!
streamLinesDo: aBlock

	line := readStream nextLine.
	[ line notNil ] whileTrue: [aBlock value. line := readStream nextLine. ].

	! !


!CustomerImporter methodsFor: 'assertions' stamp: 'FP 6/28/2023 17:42:19'!
assertCurrentCustomerIsNotNil

	^ currentCustomer ifNil: [self signalImportError]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'FP 6/28/2023 17:42:19'!
assertRecordHasFiveEntries

	^ record size = 5 ifFalse: [self signalImportError]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'FP 6/28/2023 17:42:19'!
assertRecordHasSixEntries

	^ record size  = 6 ifFalse: [self signalImportError]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'FP 6/28/2023 17:42:19'!
assertStreetNumberCanBeConvertedToNumber

	^ (record third allSatisfy: [:aCharacter | aCharacter isDigit]) ifFalse: [self signalImportError]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'FP 6/28/2023 17:40:10'!
assertValidAddressRecord

	self assertCurrentCustomerIsNotNil.
	self assertRecordHasSixEntries.
	self assertStreetNumberCanBeConvertedToNumber.
	self assertZipCodeCanBeConvertedToNumber! !

!CustomerImporter methodsFor: 'assertions' stamp: 'FP 6/28/2023 17:42:19'!
assertZipCodeCanBeConvertedToNumber

	^ (record fifth allSatisfy: [:aCharacter | aCharacter isDigit]) ifFalse: [self signalImportError]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'FP 6/28/2023 17:42:19'!
signalImportError

	^ self error: self class importErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'FP 6/28/2023 16:52:27'!
assertReadStreamIsNotEmpty: aReadStream

	^ aReadStream isEmpty ifTrue: [self error: 'Error al importar el archivo']! !

!CustomerImporter class methodsFor: 'importing' stamp: 'FP 6/28/2023 16:52:27'!
importFrom: aReadStream into: aSession
	
	self assertReadStreamIsNotEmpty: aReadStream.
	^(self from: aReadStream into: aSession) import! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'FP 6/28/2023 17:41:09'!
importErrorDescription

	^'Error al importar el archivo'! !


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
