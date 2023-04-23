!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 18:38:19'!
assertThatCollection: aCollection hasExactlyTheSameElementsAsCollection: anotherCollection

	self assert: (aCollection includesAllOf: anotherCollection).
	self assert: (aCollection size = anotherCollection size)! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 18:50:49'!
assertThatStack: aComparedStack isEqualTo: aComparingStack

	| poppedElementFromComparedStack poppedElementFromComparingStack | 

	self assert: aComparedStack size = aComparingStack size.
	
	aComparedStack isEmpty ifTrue: [^true]	.
	
	poppedElementFromComparedStack := aComparedStack pop.
	poppedElementFromComparingStack := aComparingStack pop.
	
	self assert: poppedElementFromComparedStack = poppedElementFromComparingStack.
	
	self assertThatStack: aComparedStack isEqualTo: aComparingStack.
	
	aComparedStack push: poppedElementFromComparedStack.
	aComparingStack push: poppedElementFromComparingStack.! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 20:07:20'!
copyStack: aStackToBeCopied 

	| stackCopy temporaryReversedStack |
	
	stackCopy := OOStack new.
	temporaryReversedStack := OOStack new.
	
	self popAllFrom: aStackToBeCopied andPushAllInto: temporaryReversedStack.
	self popAllFrom: temporaryReversedStack andPushAllInto: stackCopy andInto: aStackToBeCopied.
	
	^stackCopy! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 20:29:51'!
popAllFrom: aStackToPopFrom andPushAllInto: aStackToPushInto
	
	"Nota: el mensaje popAllFrom:andPushAllInto: es un mensaje ya implementado en la clase SentenceFinderByPrefix. 
	Si bien hay código repetido, no usamos ese mensaje ya que no nos parece correcto crear una instancia de SentenceFinderByPrefix sólo para usar ese método. 
	Además, creemos que debería estar 	en el protocolo de OOStack, lo cual no está permitido por la consigna. "

	[aStackToPopFrom isEmpty] whileFalse: [
		aStackToPushInto push: aStackToPopFrom pop.
		]! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 20:06:59'!
popAllFrom: aStackToPopFrom andPushAllInto: aStackToPushInto andInto: anotherStackToPushInto

	[aStackToPopFrom isEmpty] whileFalse: [
		| poppedElement |
		
		poppedElement := aStackToPopFrom pop.
		aStackToPushInto push: poppedElement.
		anotherStackToPushInto push: poppedElement.
		]! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 16:28:35'!
shouldValuating: aClosureThatShouldFail failWith: anError assert: aClosureWithConditions 

	[aClosureThatShouldFail value.
		self fail]
		on: anError 
		do: aClosureWithConditions! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:49:22'!
test01SearchingOnAnEmptyStackReturnsNoSentences

	| sentenceFinderWithEmptyStack emptySentenceStack emptySentenceStackCopy |
	
	emptySentenceStack := OOStack new.
	emptySentenceStackCopy := self copyStack: emptySentenceStack.	
	
	sentenceFinderWithEmptyStack := SentenceFinderByPrefix withAPrefix: 'buy' inASentenceStack: emptySentenceStack.

	self assert: sentenceFinderWithEmptyStack findAllSentencesWithPrefixInSentenceStack isEmpty.
	self assertThatStack: emptySentenceStack isEqualTo: emptySentenceStackCopy.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:50:08'!
test02EmptyPrefixIsNotValid
	
	| nonEmptySentenceStack |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'Summer is my favourite season'.
	
	self shouldValuating: [SentenceFinderByPrefix withAPrefix: '' inASentenceStack: nonEmptySentenceStack.] 
		failWith: Error  
		assert:  [ :anError | self assert: anError messageText = SentenceFinderByPrefix emptyPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 16:50:41'!
test03PrefixWithEmptySpacesIsNotValid
	
	| nonEmptySentenceStack |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'Summer is my favourite season'.
	
	self shouldValuating: [SentenceFinderByPrefix withAPrefix: 'Summer is' inASentenceStack: nonEmptySentenceStack.] 
		failWith: Error  
		assert:  [ :anError | self assert: anError messageText = SentenceFinderByPrefix emptySpacesPrefixErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:52:01'!
test04FindingSentencesIsCaseSensitive

	| nonEmptySentenceStack sentenceFinderWithNonEmptyStack  correctSentencesCaseSensitive foundSentences nonEmptySentenceStackCopy |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'Summer is my favourite season'.
	nonEmptySentenceStack push: 'summer is great!!'.
	
	nonEmptySentenceStackCopy := self copyStack: nonEmptySentenceStack.	
	
	sentenceFinderWithNonEmptyStack := SentenceFinderByPrefix withAPrefix: 'Summer' inASentenceStack: nonEmptySentenceStack .
	
	correctSentencesCaseSensitive := OrderedCollection  new.
	correctSentencesCaseSensitive add: 'Summer is my favourite season'.
	
	foundSentences := sentenceFinderWithNonEmptyStack findAllSentencesWithPrefixInSentenceStack.
	self assertThatCollection: foundSentences hasExactlyTheSameElementsAsCollection: correctSentencesCaseSensitive.
	self assertThatStack: nonEmptySentenceStack isEqualTo: nonEmptySentenceStackCopy.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:20:34'!
test05FindingPreservesOriginalOrder

	| nonEmptySentenceStack sentenceFinderWithNonEmptyStack  correctSentencesInOrder foundSentences nonEmptySentenceStackCopy |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'Summer is my favourite season'.
	nonEmptySentenceStack push: 'Smalltalk is awesome!!'.
	nonEmptySentenceStack push: 'Summer is awesome!!'.
	
	nonEmptySentenceStackCopy := self copyStack: nonEmptySentenceStack.	
	
	sentenceFinderWithNonEmptyStack := SentenceFinderByPrefix withAPrefix: 'Summer' inASentenceStack: nonEmptySentenceStack .
	
	correctSentencesInOrder := OrderedCollection  new.
	
	correctSentencesInOrder add: 'Summer is awesome!!'.
	correctSentencesInOrder add: 'Summer is my favourite season'.
	
	
	foundSentences := sentenceFinderWithNonEmptyStack findAllSentencesWithPrefixInSentenceStack.
	self assertThatCollection: foundSentences hasExactlyTheSameElementsAsCollection: correctSentencesInOrder.
	self assertThatStack: nonEmptySentenceStack isEqualTo: nonEmptySentenceStackCopy.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:51:15'!
test06SentencesNotBegginingWithPrefixWordButContainingItAreNotReturned

	| nonEmptySentenceStack sentenceFinderWithNonEmptyStack  correctSentences foundSentences nonEmptySentenceStackCopy |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'I like Summer'.
	nonEmptySentenceStack push: 'Summer is my favourite season'.
	nonEmptySentenceStack push: 'Smalltalk is awesome!!'.
	nonEmptySentenceStack push: 'summer is great!!'.
	nonEmptySentenceStack push: 'Summer is awesome!!'.
	
	nonEmptySentenceStackCopy := self copyStack: nonEmptySentenceStack.	
	
	sentenceFinderWithNonEmptyStack := SentenceFinderByPrefix withAPrefix: 'Winter' inASentenceStack: nonEmptySentenceStack .
	
	correctSentences := OrderedCollection  new.

	
	foundSentences := sentenceFinderWithNonEmptyStack findAllSentencesWithPrefixInSentenceStack.
	self assertThatCollection: foundSentences hasExactlyTheSameElementsAsCollection: correctSentences.
	self assertThatStack: nonEmptySentenceStack isEqualTo: nonEmptySentenceStackCopy.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:51:40'!
test07NoSentencesAreReturnedWhenPrefixDoesNotAppear

	| nonEmptySentenceStack sentenceFinderWithNonEmptyStack  correctSentences foundSentences nonEmptySentenceStackCopy |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'I like Summer'.
	nonEmptySentenceStack push: 'Summer is my favourite season'.
	nonEmptySentenceStack push: 'Smalltalk is awesome!!'.
	nonEmptySentenceStack push: 'summer is great!!'.
	nonEmptySentenceStack push: 'Summer is awesome!!'.
	
	nonEmptySentenceStackCopy := self copyStack: nonEmptySentenceStack.	
	
	sentenceFinderWithNonEmptyStack := SentenceFinderByPrefix withAPrefix: 'Winter' inASentenceStack: nonEmptySentenceStack .
	
	correctSentences := OrderedCollection  new.

	foundSentences := sentenceFinderWithNonEmptyStack findAllSentencesWithPrefixInSentenceStack.
	self assertThatCollection: foundSentences hasExactlyTheSameElementsAsCollection: correctSentences.
	self assertThatStack: nonEmptySentenceStack isEqualTo: nonEmptySentenceStackCopy.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:51:48'!
test08SentencesWithPrefixAreReturnedEvenIfTheirFirstWordIsLongerThanIt

	| nonEmptySentenceStack sentenceFinderWithNonEmptyStack  correctSentences foundSentences nonEmptySentenceStackCopy |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'Summer is my favourite season'.
	nonEmptySentenceStack push: 'Sum two numbers'.
	
	nonEmptySentenceStackCopy := self copyStack: nonEmptySentenceStack.	
	
	sentenceFinderWithNonEmptyStack := SentenceFinderByPrefix withAPrefix: 'Sum' inASentenceStack: nonEmptySentenceStack .
	
	correctSentences := OrderedCollection  new.
	
	correctSentences add: 'Sum two numbers'.
	correctSentences add: 'Summer is my favourite season'.
		
	foundSentences := sentenceFinderWithNonEmptyStack findAllSentencesWithPrefixInSentenceStack.
	self assertThatCollection: foundSentences hasExactlyTheSameElementsAsCollection: correctSentences.
	self assertThatStack: nonEmptySentenceStack isEqualTo: nonEmptySentenceStackCopy.
! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'SP 4/23/2023 19:51:53'!
test09SentencesWithSeparatedPrefixAreNotReturned

	| nonEmptySentenceStack sentenceFinderWithNonEmptyStack  correctSentences foundSentences nonEmptySentenceStackCopy |
	
	nonEmptySentenceStack := OOStack new.
	nonEmptySentenceStack push: 'The reform was necessary'.
	nonEmptySentenceStack push: 'There are many points'.
	
	nonEmptySentenceStackCopy := self copyStack: nonEmptySentenceStack.	
	
	sentenceFinderWithNonEmptyStack := SentenceFinderByPrefix withAPrefix: 'There' inASentenceStack: nonEmptySentenceStack .
	
	correctSentences := OrderedCollection  new.
	
	correctSentences add: 'There are many points'.
		
	foundSentences := sentenceFinderWithNonEmptyStack findAllSentencesWithPrefixInSentenceStack.
	self assertThatCollection: foundSentences hasExactlyTheSameElementsAsCollection: correctSentences.
	self assertThatStack: nonEmptySentenceStack isEqualTo: nonEmptySentenceStackCopy.

	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topState size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'instance creation' stamp: 'SP 4/23/2023 11:49:01'!
initialize
	
	topState := StackStateEmpty new.
	size := 0.! !


!OOStack methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 11:49:01'!
popWhenStateIsNotEmpty

	| poppedElement |
	
	poppedElement := self top.
	topState := topState below.
	size := size - 1.	
	^poppedElement 
	! !

!OOStack methodsFor: 'auxiliary operations' stamp: 'SP 4/22/2023 12:49:33'!
raiseErrorForAccesingWhenStateIsEmpty

	self error: self class stackEmptyErrorDescription ! !

!OOStack methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 11:49:01'!
topWhenStateIsNotEmpty

	^topState content! !


!OOStack methodsFor: 'modifying' stamp: 'SP 4/23/2023 11:49:01'!
pop 

	^topState tellStackToPopIDependingOnState: self
! !

!OOStack methodsFor: 'modifying' stamp: 'SP 4/23/2023 11:49:01'!
push: anElementToBePushed

	| newStackState |
	
	newStackState := StackStateNotEmpty with: anElementToBePushed onTopOf: topState.
	topState := newStackState.
	size := size + 1

! !


!OOStack methodsFor: 'accesing' stamp: 'SP 4/23/2023 11:49:01'!
isEmpty

	^topState isEmpty

	! !

!OOStack methodsFor: 'accesing' stamp: 'SP 4/22/2023 16:17:27'!
size

	^size ! !

!OOStack methodsFor: 'accesing' stamp: 'SP 4/23/2023 11:49:01'!
top

	^topState tellStackToGetTopDependingOnState: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'SP 4/22/2023 11:01:11'!
new

	^super new initialize! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'aSentenceStackToGetSentencesFrom aPrefixToFindSentences foundSentencesWithPrefix tempStackToStoreOriginalSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'instance creation' stamp: 'SP 4/23/2023 17:17:29'!
initializeWithAPrefix: aPrefix inASentenceStack: aSentenceStack

	aPrefixToFindSentences := aPrefix.
	aSentenceStackToGetSentencesFrom := aSentenceStack.
	tempStackToStoreOriginalSentences := OOStack new.
	foundSentencesWithPrefix := OrderedCollection new.! !


!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 15:22:14'!
addASentenceToFoundSentencesIfItHasPrefix: aSentenceToSearchForPrefix

	(aSentenceToSearchForPrefix beginsWith: aPrefixToFindSentences) ifTrue: [ 
			foundSentencesWithPrefix add: aSentenceToSearchForPrefix.
			 ]! !

!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 20:28:57'!
findAllSentencesWithPrefixEmptyingOriginalStack

	[aSentenceStackToGetSentencesFrom isEmpty] whileFalse:[
			| lastPoppedSentence |	
		
		lastPoppedSentence := aSentenceStackToGetSentencesFrom pop.
		tempStackToStoreOriginalSentences push: lastPoppedSentence.
		
		self addASentenceToFoundSentencesIfItHasPrefix: lastPoppedSentence
		]! !

!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 20:32:36'!
popAllFrom: aStackToPopFrom andPushAllInto: aStackToPushInto

	[aStackToPopFrom isEmpty] whileFalse: [
		aStackToPushInto push: aStackToPopFrom pop.
		]! !

!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 20:23:01'!
putSentencesBackInOriginalStack

	self popAllFrom: tempStackToStoreOriginalSentences andPushAllInto: aSentenceStackToGetSentencesFrom! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'SP 4/23/2023 15:55:47'!
findAllSentencesWithPrefixInSentenceStack

	self findAllSentencesWithPrefixEmptyingOriginalStack.
	
	self putSentencesBackInOriginalStack.
	
	^foundSentencesWithPrefix.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'SP 4/23/2023 17:17:29'!
withAPrefix: aPrefix inASentenceStack: aSentenceStack

	self assertThatPrefixIsNotEmpty: aPrefix.
	self assertThatPrefixContainsNoEmptySpaces: aPrefix.

	^self new initializeWithAPrefix: aPrefix inASentenceStack: aSentenceStack! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'SP 4/23/2023 15:44:05'!
assertThatPrefixContainsNoEmptySpaces: aPrefix

	^ (aPrefix includesSubString: ' ') ifTrue: [self error: self emptySpacesPrefixErrorDescription]! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'SP 4/23/2023 15:43:30'!
assertThatPrefixIsNotEmpty: aPrefix

	^ (aPrefix = '') ifTrue: [self error: self emptyPrefixErrorDescription]! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'SP 4/23/2023 15:37:41'!
emptyPrefixErrorDescription

	^'El prefijo no puede ser vacío!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'SP 4/23/2023 15:37:38'!
emptySpacesPrefixErrorDescription

	^'El prefijo no puede contener espacios vacíos!!!!!!'! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'accesing' stamp: 'SP 4/22/2023 16:40:17'!
isEmpty

	self subclassResponsibility ! !


!StackState methodsFor: 'stack redirecting' stamp: 'SP 4/22/2023 16:38:50'!
tellStackToGetTopDependingOnState: aStackToGetTheTopFrom

	self subclassResponsibility ! !

!StackState methodsFor: 'stack redirecting' stamp: 'SP 4/22/2023 16:39:05'!
tellStackToPopIDependingOnState: aStackToPopFrom

	self subclassResponsibility ! !


!classDefinition: #StackStateEmpty category: 'Stack-Exercise'!
StackState subclass: #StackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackStateEmpty methodsFor: 'stack redirecting' stamp: 'SP 4/22/2023 16:38:51'!
tellStackToGetTopDependingOnState: anEmptyStackToGetTheTopFrom

	anEmptyStackToGetTheTopFrom raiseErrorForAccesingWhenStateIsEmpty 

	

	
! !

!StackStateEmpty methodsFor: 'stack redirecting' stamp: 'SP 4/22/2023 16:39:05'!
tellStackToPopIDependingOnState: anEmptyStackToPopFrom

	anEmptyStackToPopFrom raiseErrorForAccesingWhenStateIsEmpty 

	
! !


!StackStateEmpty methodsFor: 'accesing' stamp: 'SP 4/22/2023 12:00:24'!
isEmpty

	^true! !


!classDefinition: #StackStateNotEmpty category: 'Stack-Exercise'!
StackState subclass: #StackStateNotEmpty
	instanceVariableNames: 'below content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackStateNotEmpty methodsFor: 'instance creation' stamp: 'SP 4/22/2023 16:06:15'!
initializeWith: aValue onTopOf: aStackStateBelow

	content := aValue.
	below := aStackStateBelow.! !


!StackStateNotEmpty methodsFor: 'accesing' stamp: 'SP 4/22/2023 15:56:44'!
below

	^below! !

!StackStateNotEmpty methodsFor: 'accesing' stamp: 'SP 4/22/2023 16:19:37'!
content

	^content! !

!StackStateNotEmpty methodsFor: 'accesing' stamp: 'SP 4/22/2023 12:00:34'!
isEmpty

	^false! !


!StackStateNotEmpty methodsFor: 'stack redirecting' stamp: 'SP 4/22/2023 16:38:51'!
tellStackToGetTopDependingOnState: aNotEmptyStackToGetTheTopFrom

	^aNotEmptyStackToGetTheTopFrom topWhenStateIsNotEmpty

	
	

	
! !

!StackStateNotEmpty methodsFor: 'stack redirecting' stamp: 'SP 4/22/2023 16:39:06'!
tellStackToPopIDependingOnState: aNotEmptyStackToPopFrom

	^aNotEmptyStackToPopFrom popWhenStateIsNotEmpty
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackStateNotEmpty class' category: 'Stack-Exercise'!
StackStateNotEmpty class
	instanceVariableNames: ''!

!StackStateNotEmpty class methodsFor: 'as yet unclassified' stamp: 'SP 4/22/2023 16:22:32'!
with: aValue onTopOf: aStackStateBelow

	^self new initializeWith: aValue onTopOf: aStackStateBelow ! !
