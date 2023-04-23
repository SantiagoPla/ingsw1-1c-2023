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

!SentenceFinderByPrefix methodsFor: 'instance creation' stamp: 'SP 4/23/2023 13:34:45'!
initializeWithAPrefix: aPrefix inAStringStack: aSentenceStack

	aPrefixToFindSentences := aPrefix.
	aSentenceStackToGetSentencesFrom := aSentenceStack.
	tempStackToStoreOriginalSentences := OOStack new.
	foundSentencesWithPrefix := OrderedCollection new.! !


!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 13:32:17'!
addASentenceToFoundSentencesIfItHasPrefix: aSentenceToSearchForPrefix

	(aSentenceToSearchForPrefix beginsWith: aPrefixToFindSentences) ifTrue: [ 
			foundSentencesWithPrefix add: aSentenceToSearchForPrefix.
			 ]! !

!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 13:34:19'!
findAllSentencesWithPrefixEmptyingOriginalStack

	aSentenceStackToGetSentencesFrom isEmpty whileFalse:[
			| lastPoppedSentence |	
			
		lastPoppedSentence  := self popFrom: aSentenceStackToGetSentencesFrom andPushInto: tempStackToStoreOriginalSentences.
		
		self addASentenceToFoundSentencesIfItHasPrefix: lastPoppedSentence
		]! !

!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 13:34:19'!
popFrom: aStackToBePopped andPushInto: aStackToBePushed
		
		| poppedElement |
		
		poppedElement  := aSentenceStackToGetSentencesFrom pop.
		tempStackToStoreOriginalSentences push: poppedElement.
		
		^poppedElement.
		
		! !

!SentenceFinderByPrefix methodsFor: 'auxiliary operations' stamp: 'SP 4/23/2023 13:34:19'!
putSentencesBackInOriginalStack

	tempStackToStoreOriginalSentences isEmpty whileFalse: [
			self popFrom: tempStackToStoreOriginalSentences andPushInto: aSentenceStackToGetSentencesFrom 
		]! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'SP 4/23/2023 13:03:41'!
findAllSentencesWithPrefixInStringStack

	self findAllSentencesWithPrefixEmptyingOriginalStack.
	
	self putSentencesBackInOriginalStack.
	
	^foundSentencesWithPrefix.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'SP 4/23/2023 12:46:40'!
withAPrefix: aPrefix inAStringStack: aStringStack

	^self new initializeWithAPrefix: aPrefix inAStringStack: aStringStack! !


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
