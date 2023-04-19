!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 10:54:49'!
* aMultiplier 

	^aMultiplier multiplyYourselfToAnInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 10:54:54'!
+ anAdder 
	
	^anAdder addYourselfToAnInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 10:54:11'!
- aSubtrahend 
	
	^aSubtrahend subtractYourselfFromAnInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 11:00:28'!
/ aDivisor 
	
	^aDivisor divideAnIntegerByYourself: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 15:50:21'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 12:20:21'!
fibonacci

	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:18:22'!
addYourselfToAFraction: aFractionToBeAddedTo

	^aFractionToBeAddedTo numerator + aFractionToBeAddedTo denominator * self / aFractionToBeAddedTo denominator 
! !

!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:13:59'!
addYourselfToAnInteger: anIntegerToBeAddedTo
	
	^Entero with: anIntegerToBeAddedTo integerValue + value
	! !

!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:24:31'!
divideAFractionByYourself: aFractionToBeDivided

	^aFractionToBeDivided numerator / (aFractionToBeDivided denominator * self)! !

!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:00:33'!
divideAnIntegerByYourself: anIntegerToBeDivided
	
	^Fraccion with: anIntegerToBeDivided over: self
	! !

!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:10:47'!
multiplyYourselfToAFraction: aFractionToBeMultiplied

	^aFractionToBeMultiplied numerator * self / aFractionToBeMultiplied denominator 
! !

!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 10:54:24'!
multiplyYourselfToAnInteger: anIntegerToBeMultiplied 
	
	^Entero with: anIntegerToBeMultiplied integerValue * value

	! !

!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:22:01'!
subtractYourselfFromAFraction: aFractionToBeSubtractedFrom

	^aFractionToBeSubtractedFrom numerator - aFractionToBeSubtractedFrom denominator * self / aFractionToBeSubtractedFrom denominator ! !

!Entero methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 10:54:20'!
subtractYourselfFromAnInteger: anIntegerToBeSubtractedFrom 
	
	^Entero with: anIntegerToBeSubtractedFrom integerValue - value
	! !


!Entero methodsFor: 'auxiliary comparing operations' stamp: 'FP 4/19/2023 11:40:54'!
compareYourselfToAFraction: aFractionToBeComparedTo

	^false! !

!Entero methodsFor: 'auxiliary comparing operations' stamp: 'FP 4/19/2023 11:36:59'!
compareYourselfToAnInteger: anIntegerToBeComparedTo

	^anIntegerToBeComparedTo integerValue = value
	! !


!Entero methodsFor: 'comparing' stamp: 'FP 4/19/2023 11:36:47'!
= anObject

	^anObject compareYourselfToAnInteger: self! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'FP 4/19/2023 15:13:28'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'FP 4/19/2023 15:40:55'!
getSubclassFor: aValue 

	
	aValue < 0 ifTrue: [	^EnteroNegativo].
	aValue = 0 ifTrue: [	^Cero].
	aValue = 1 ifTrue: [	^Uno].
	^EnteroMayorQueUno 
	
! !

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'FP 4/19/2023 15:42:38'!
with: aValue 
	|subclassForAValue|
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	subclassForAValue := self getSubclassFor: aValue.
	^subclassForAValue new initializeWith: aValue.
	
! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'as yet unclassified' stamp: 'FP 4/19/2023 13:27:51'!
fibonacci

	| one |
	one := Entero with: 1.
	^one! !


!classDefinition: #EnteroMayorQueUno category: 'Numero-Exercise'!
Entero subclass: #EnteroMayorQueUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroMayorQueUno methodsFor: 'as yet unclassified' stamp: 'FP 4/19/2023 13:28:36'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
		
	^ (self - one) fibonacci + (self - two) fibonacci
		! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'as yet unclassified' stamp: 'FP 4/19/2023 12:20:03'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'as yet unclassified' stamp: 'FP 4/19/2023 13:28:10'!
fibonacci

	|one|
	one := Entero with: 1.
	^one! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 11:10:36'!
* aMultiplier 
	
	^aMultiplier multiplyYourselfToAFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 11:18:11'!
+ anAdder 

	^anAdder addYourselfToAFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 11:21:55'!
- aSubtrahend 
	
	^aSubtrahend subtractYourselfFromAFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'FP 4/19/2023 11:24:14'!
/ aDivisor 

	^aDivisor divideAFractionByYourself: self! !


!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:18:17'!
addYourselfToAFraction: aFractionToBeAddedTo 
	
	| newNumerator newDenominator |
	
	newNumerator := (aFractionToBeAddedTo numerator * denominator) + (aFractionToBeAddedTo denominator * numerator).
	newDenominator := aFractionToBeAddedTo denominator * denominator.
	
	^newNumerator / newDenominator
	
	! !

!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:14:12'!
addYourselfToAnInteger: anIntegerToBeAddedTo

	^anIntegerToBeAddedTo * denominator + numerator / denominator ! !

!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:24:26'!
divideAFractionByYourself: aFractionToBeDivided 
	
	^(aFractionToBeDivided numerator * denominator) / (aFractionToBeDivided denominator * numerator)
! !

!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:00:38'!
divideAnIntegerByYourself: anIntegerToBeDivided

	^Fraccion with: anIntegerToBeDivided * denominator over: numerator 
! !

!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:10:42'!
multiplyYourselfToAFraction: aFractionToBeMultiplied 
	
	^(aFractionToBeMultiplied numerator * numerator) / (aFractionToBeMultiplied denominator * denominator)
	! !

!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 10:54:38'!
multiplyYourselfToAnInteger: anIntegerToBeMultiplied

	^ anIntegerToBeMultiplied * numerator / denominator 
! !

!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 11:21:46'!
subtractYourselfFromAFraction: aFractionToBeSubtractedFrom 
		
	| newNumerator newDenominator |
	
	newNumerator := (aFractionToBeSubtractedFrom numerator * denominator) - (aFractionToBeSubtractedFrom denominator * numerator).
	newDenominator := aFractionToBeSubtractedFrom denominator * denominator.
	
	^newNumerator / newDenominator 
	
	! !

!Fraccion methodsFor: 'auxiliary arithmetic operations' stamp: 'FP 4/19/2023 10:54:42'!
subtractYourselfFromAnInteger: anIntegerToBeSubtractedFrom

	^anIntegerToBeSubtractedFrom * denominator - numerator / denominator
! !


!Fraccion methodsFor: 'auxiliary comparing operations' stamp: 'FP 4/19/2023 11:40:33'!
compareYourselfToAFraction: aFractionToBeComparedTo

	^(aFractionToBeComparedTo numerator * denominator) = (aFractionToBeComparedTo denominator *  numerator)! !

!Fraccion methodsFor: 'auxiliary comparing operations' stamp: 'FP 4/19/2023 11:35:48'!
compareYourselfToAnInteger: anIntegerToBeComparedTo

	^false ! !


!Fraccion methodsFor: 'comparing' stamp: 'FP 4/19/2023 11:41:08'!
= anObject

	^anObject compareYourselfToAFraction: self! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
