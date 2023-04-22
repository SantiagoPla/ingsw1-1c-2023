!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !

!OOStackTest methodsFor: 'test'!
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'state size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'instance creation' stamp: 'FP 4/22/2023 16:16:21'!
initialize

	state := StackStateEmpty new.
	size := 0! !


!OOStack methodsFor: 'modifying' stamp: 'FP 4/22/2023 16:38:17'!
pop
	^ state tellStackToPopDependingOnState: self.! !

!OOStack methodsFor: 'modifying' stamp: 'FP 4/22/2023 16:20:39'!
push: anElementToBePushed

	| newStackState |
	
	newStackState := StackStateNotEmpty with: anElementToBePushed onTopOf: state.
	state := newStackState.
	size := size + 1.

	
! !


!OOStack methodsFor: 'accessing' stamp: 'FP 4/22/2023 15:48:41'!
isEmpty
	
	^ state isEmpty.! !

!OOStack methodsFor: 'accessing' stamp: 'FP 4/22/2023 16:17:19'!
size
	^ size.! !

!OOStack methodsFor: 'accessing' stamp: 'FP 4/22/2023 16:37:58'!
top
	^ state tellStackToGetTopDependingOnState: self.! !


!OOStack methodsFor: 'auxiliary operations' stamp: 'FP 4/22/2023 16:17:09'!
popWhenStateIsNotEmpty
	
	| poppedElement |
	
	poppedElement := self top.
	state := state below.
	size := size  - 1.
	^ poppedElement .! !

!OOStack methodsFor: 'auxiliary operations' stamp: 'FP 4/22/2023 16:20:57'!
raiseErrorForAccessingWhenStateIsEmpty

	self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'auxiliary operations' stamp: 'FP 4/22/2023 16:21:08'!
topWhenStateIsNotEmpty

	^ state content.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions'!
! !


!OOStack class methodsFor: 'as yet unclassified'!
! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'accessing' stamp: 'FP 4/22/2023 16:40:19'!
isEmpty

	self subclassResponsibility ! !


!StackState methodsFor: 'stack redirecting' stamp: 'FP 4/22/2023 19:47:54'!
tellStackToGetTopDependingOnState: aStackToGetTheTopFrom
	self subclassResponsibility.! !

!StackState methodsFor: 'stack redirecting' stamp: 'FP 4/22/2023 16:38:17'!
tellStackToPopDependingOnState: aStackToPopFrom
	self subclassResponsibility.! !


!classDefinition: #StackStateEmpty category: 'Stack-Exercise'!
StackState subclass: #StackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackStateEmpty methodsFor: 'accessing'!
! !


!StackStateEmpty methodsFor: 'stack redirecting' stamp: 'FP 4/22/2023 16:37:58'!
tellStackToGetTopDependingOnState: anEmptyStackToGetTheTopFrom
	anEmptyStackToGetTheTopFrom raiseErrorForAccessingWhenStateIsEmpty.! !

!StackStateEmpty methodsFor: 'stack redirecting' stamp: 'FP 4/22/2023 16:38:17'!
tellStackToPopDependingOnState: anEmptyStackToPopFrom
	anEmptyStackToPopFrom raiseErrorForAccessingWhenStateIsEmpty.! !


!classDefinition: #StackStateNotEmpty category: 'Stack-Exercise'!
StackState subclass: #StackStateNotEmpty
	instanceVariableNames: 'below content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackStateNotEmpty methodsFor: 'instance creation' stamp: 'FP 4/22/2023 16:06:08'!
initializeWith: aValue onTopOf: aStackStateBelow

	content := aValue.
	below := aStackStateBelow ! !


!StackStateNotEmpty methodsFor: 'accessing' stamp: 'FP 4/22/2023 15:56:39'!
below

	^below ! !

!StackStateNotEmpty methodsFor: 'accessing' stamp: 'FP 4/22/2023 16:19:39'!
content 

	^content! !

!StackStateNotEmpty methodsFor: 'accessing'!
! !


!StackStateNotEmpty methodsFor: 'stack redirecting' stamp: 'FP 4/22/2023 16:37:58'!
tellStackToGetTopDependingOnState: aNotEmptyStackToGetTheTopFrom
	^ aNotEmptyStackToGetTheTopFrom topWhenStateIsNotEmpty.! !

!StackStateNotEmpty methodsFor: 'stack redirecting' stamp: 'FP 4/22/2023 16:38:17'!
tellStackToPopDependingOnState: aNotEmptyStackToPopFrom
	^ aNotEmptyStackToPopFrom popWhenStateIsNotEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackStateNotEmpty class' category: 'Stack-Exercise'!
StackStateNotEmpty class
	instanceVariableNames: ''!

!StackStateNotEmpty class methodsFor: 'as yet unclassified' stamp: 'FP 4/22/2023 16:05:35'!
with: aValue onTopOf: aStackStateBelow

	^self new initializeWith: aValue onTopOf: aStackStateBelow ! !
