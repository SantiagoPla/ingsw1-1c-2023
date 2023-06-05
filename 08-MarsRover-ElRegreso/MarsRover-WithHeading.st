!classDefinition: #LogAndWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LogAndWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LogAndWindowTest methodsFor: 'position log tests' stamp: 'FP 6/4/2023 16:19:23'!
test01PositionLogDoesNotChangeWithEmptyCommand
	
	|marsRover initialLog positionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogTracer := PositionLogTracer with: marsRover.
	
	initialLog := positionLogTracer log.
	
	marsRover process: ''.
	
	self assert: initialLog equals: positionLogTracer log.! !

!LogAndWindowTest methodsFor: 'position log tests' stamp: 'FP 6/4/2023 16:19:23'!
test03PositionLogAddsNewPositionWithForwardCommand 

	|marsRover positionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogTracer := PositionLogTracer with: marsRover.
		
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 1@2) equals: positionLogTracer log.! !

!LogAndWindowTest methodsFor: 'position log tests' stamp: 'FP 6/4/2023 16:19:23'!
test05PositionLogAddsNewPositionWithBackwardCommand 

	|marsRover positionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogTracer := PositionLogTracer with: marsRover.
		
	marsRover process: 'b'.
	
	self assert: (OrderedCollection with: 1@0) equals: positionLogTracer log.! !

!LogAndWindowTest methodsFor: 'position log tests' stamp: 'FP 6/4/2023 16:19:23'!
test18PositionLogDoesNotChangeWithHeadingUpdate
	
	|marsRover initialLog positionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionLogTracer := PositionLogTracer with: marsRover.
	
	initialLog := positionLogTracer log.
	
	marsRover process: 'rrrr'.
	
	self assert: initialLog equals: positionLogTracer log.! !


!LogAndWindowTest methodsFor: 'heading log tests' stamp: 'FP 6/4/2023 16:19:10'!
test07HeadingLogDoesNotChangeWithEmptyCommand
	
	|marsRover initialLog headingLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingLogTracer := HeadingLogTracer with: marsRover.
	
	initialLog := headingLogTracer log.
	
	marsRover process: ''.
	
	self assert: initialLog equals: headingLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading log tests' stamp: 'FP 6/4/2023 16:19:10'!
test09HeadingLogAddsHeadingWestWithRotateLeftCommand

	|marsRover headingLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingLogTracer := HeadingLogTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'Apuntando al Oeste') equals: headingLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading log tests' stamp: 'FP 6/4/2023 16:19:10'!
test10HeadingLogAddsHeadingSouthWithRotateLeftCommand

	|marsRover headingLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingWest.
	headingLogTracer := HeadingLogTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'Apuntando al Sur') equals: headingLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading log tests' stamp: 'FP 6/4/2023 16:19:10'!
test11HeadingLogAddsHeadingEastWithRotateLeftCommand

	|marsRover headingLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	headingLogTracer := HeadingLogTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'Apuntando al Este') equals: headingLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading log tests' stamp: 'FP 6/4/2023 16:19:10'!
test12HeadingLogAddsHeadingNorthWithRotateLeftCommand

	|marsRover headingLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	headingLogTracer := HeadingLogTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'Apuntando al Norte') equals: headingLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading log tests' stamp: 'FP 6/4/2023 16:19:10'!
test17HeadingLogAndHeadingWindowUpdateHeadingWithRotateRightCommand

	|marsRover headingLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingLogTracer := HeadingLogTracer with: marsRover.
		
	marsRover process: 'r'.

	self assert: (OrderedCollection with: 'Apuntando al Este') equals: headingLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading log tests' stamp: 'FP 6/4/2023 16:19:10'!
test20HeadingLogDoesNotChangeWithPositionUpdate
	
	|marsRover initialLog headingLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingLogTracer := HeadingLogTracer with: marsRover.
	
	initialLog := headingLogTracer log.
	
	marsRover process: 'f'.
	
	self assert: initialLog equals: headingLogTracer log.! !


!LogAndWindowTest methodsFor: 'position window tests' stamp: 'FP 6/4/2023 16:19:29'!
test02PositionWindowDoesNotChangeAfterEmptyCommand 

	|marsRover initialWindow positionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionWindowTracer := PositionWindowTracer with: marsRover.
	
	initialWindow := positionWindowTracer window.
	
	marsRover process: ''.
	
	self assert: initialWindow equals: positionWindowTracer window.! !

!LogAndWindowTest methodsFor: 'position window tests' stamp: 'FP 6/4/2023 16:19:29'!
test04PositionWindowShowsNewPositionWithForwardCommand

	|marsRover positionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.	
	positionWindowTracer := PositionWindowTracer with: marsRover.
		
	marsRover process: 'f'.
	
	self assert: (1@2) asString equals: positionWindowTracer window .! !

!LogAndWindowTest methodsFor: 'position window tests' stamp: 'FP 6/4/2023 16:19:29'!
test06PositionWindowShowsNewPositionWithBackwardCommand

	|marsRover positionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.	
	positionWindowTracer := PositionWindowTracer with: marsRover.
		
	marsRover process: 'b'.
	
	self assert: (1@0) asString equals: positionWindowTracer window .! !

!LogAndWindowTest methodsFor: 'position window tests' stamp: 'FP 6/4/2023 16:19:29'!
test19PositionWindowDoesNotChangeWithHeadingUpdate

	|marsRover initialWindow positionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	positionWindowTracer := PositionWindowTracer with: marsRover.
	
	initialWindow := positionWindowTracer window.
	
	marsRover process: 'rrrr'.
	
	self assert: initialWindow equals: positionWindowTracer window.! !


!LogAndWindowTest methodsFor: 'heading window tests' stamp: 'FP 6/4/2023 16:19:18'!
test08HeadingWindowDoesNotChangeAfterEmptyCommand 

	|marsRover initialWindow headingWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingWindowTracer := HeadingWindowTracer with: marsRover.
	
	initialWindow := headingWindowTracer window.
	
	marsRover process: ''.
	
	self assert: initialWindow equals: headingWindowTracer window.! !

!LogAndWindowTest methodsFor: 'heading window tests' stamp: 'FP 6/4/2023 16:19:18'!
test13HeadingWindowShowsHeadingWestMessageWithRotateLeftCommand

	|marsRover headingWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingWindowTracer := HeadingWindowTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: 'Apuntando al Oeste' equals: headingWindowTracer window .! !

!LogAndWindowTest methodsFor: 'heading window tests' stamp: 'FP 6/4/2023 16:19:18'!
test14HeadingWindowShowsHeadingSouthMessageWithRotateLeftCommand

	|marsRover headingWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingWest.
	headingWindowTracer := HeadingWindowTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: 'Apuntando al Sur' equals: headingWindowTracer window .! !

!LogAndWindowTest methodsFor: 'heading window tests' stamp: 'FP 6/4/2023 16:19:18'!
test15HeadingWindowShowsHeadingEastMessageWithRotateLeftCommand

	|marsRover headingWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth .
	headingWindowTracer := HeadingWindowTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: 'Apuntando al Este' equals: headingWindowTracer window .! !

!LogAndWindowTest methodsFor: 'heading window tests' stamp: 'FP 6/4/2023 16:19:18'!
test16HeadingWindowShowsHeadingNorthMessageWithRotateLeftCommand

	|marsRover headingWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast .
	headingWindowTracer := HeadingWindowTracer with: marsRover.
		
	marsRover process: 'l'.
	
	self assert: 'Apuntando al Norte' equals: headingWindowTracer window .! !

!LogAndWindowTest methodsFor: 'heading window tests' stamp: 'FP 6/4/2023 16:19:18'!
test21HeadingWindowDoesNotChangeWithPositionUpdate

	|marsRover initialWindow headingWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingWindowTracer := HeadingWindowTracer with: marsRover.
	
	initialWindow := headingWindowTracer window.
	
	marsRover process: 'f'.
	
	self assert: initialWindow equals: headingWindowTracer window.! !


!LogAndWindowTest methodsFor: 'heading and position window tests' stamp: 'FP 6/5/2023 11:39:04'!
test28HeadingAndPositionWindowDoesNotChangeWithEmptyCommand
	
	|marsRover initialWindow headingAndPositionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionWindowTracer := HeadingAndPositionWindowTracer with: marsRover.
	
	initialWindow := headingAndPositionWindowTracer window.
	
	marsRover process: ''.
	
	self assert: initialWindow equals: headingAndPositionWindowTracer window.! !

!LogAndWindowTest methodsFor: 'heading and position window tests' stamp: 'FP 6/5/2023 11:45:27'!
test29HeadingAndPositionWindowShowsNewPosition

	|marsRover expectedWindow headingAndPositionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionWindowTracer := HeadingAndPositionWindowTracer with: marsRover.
	
	marsRover process: 'f'.
	
	expectedWindow := 'Posicion: ', (1@2) asString , ' - Heading: '.
	
	self assert: expectedWindow equals: headingAndPositionWindowTracer window.! !

!LogAndWindowTest methodsFor: 'heading and position window tests' stamp: 'FP 6/5/2023 11:50:01'!
test30HeadingAndPositionWindowAddsHeadingEast
	
	|marsRover expectedWindow headingAndPositionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionWindowTracer := HeadingAndPositionWindowTracer with: marsRover.
		
	marsRover process: 'fr'.
	
	expectedWindow := 'Posicion: ', (1@2) asString , ' - Heading: Apuntando al Este'.
	
	self assert: expectedWindow equals: headingAndPositionWindowTracer window.! !

!LogAndWindowTest methodsFor: 'heading and position window tests' stamp: 'FP 6/5/2023 11:51:03'!
test31HeadingAndPositionWindowAddsHeadingSouth
	
	|marsRover expectedWindow headingAndPositionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast .
	headingAndPositionWindowTracer := HeadingAndPositionWindowTracer with: marsRover.
		
	marsRover process: 'fr'.
	
	expectedWindow := 'Posicion: ', (2@1) asString , ' - Heading: Apuntando al Sur'.
	
	self assert: expectedWindow equals: headingAndPositionWindowTracer window.! !

!LogAndWindowTest methodsFor: 'heading and position window tests' stamp: 'FP 6/5/2023 11:52:18'!
test32HeadingAndPositionWindowAddsHeadingWest
	
	|marsRover expectedWindow headingAndPositionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	headingAndPositionWindowTracer := HeadingAndPositionWindowTracer with: marsRover.
		
	marsRover process: 'fr'.
	
	expectedWindow := 'Posicion: ', (1@0) asString , ' - Heading: Apuntando al Oeste'.
	
	self assert: expectedWindow equals: headingAndPositionWindowTracer window.! !

!LogAndWindowTest methodsFor: 'heading and position window tests' stamp: 'FP 6/5/2023 11:53:18'!
test33HeadingAndPositionWindowAddsHeadingNorth
	
	|marsRover expectedWindow headingAndPositionWindowTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingWest.
	headingAndPositionWindowTracer := HeadingAndPositionWindowTracer with: marsRover.
		
	marsRover process: 'fr'.
	
	expectedWindow := 'Posicion: ', (0@1) asString , ' - Heading: Apuntando al Norte'.
	
	self assert: expectedWindow equals: headingAndPositionWindowTracer window.! !


!LogAndWindowTest methodsFor: 'heading and position log tests' stamp: 'FP 6/5/2023 11:23:07'!
test22HeadingAndPositionLogDoesNotChangeWithEmptyCommand
	
	|marsRover initialLog headingAndPositionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionLogTracer := HeadingAndPositionLogTracer with: marsRover.
	
	initialLog := headingAndPositionLogTracer log.
	
	marsRover process: ''.
	
	self assert: initialLog equals: headingAndPositionLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading and position log tests' stamp: 'FP 6/5/2023 11:27:13'!
test23HeadingAndPositionLogAddsNewPosition

	|marsRover headingAndPositionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionLogTracer := HeadingAndPositionLogTracer with: marsRover.
		
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 1@2) equals: headingAndPositionLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading and position log tests' stamp: 'FP 6/5/2023 11:32:53'!
test24HeadingAndPositionLogAddsHeadingEast
	
	|marsRover headingAndPositionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	headingAndPositionLogTracer := HeadingAndPositionLogTracer with: marsRover.
		
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'Apuntando al Este') equals: headingAndPositionLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading and position log tests' stamp: 'FP 6/5/2023 11:33:39'!
test25HeadingAndPositionLogAddsHeadingSouth
	
	|marsRover headingAndPositionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	headingAndPositionLogTracer := HeadingAndPositionLogTracer with: marsRover.
		
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'Apuntando al Sur') equals: headingAndPositionLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading and position log tests' stamp: 'FP 6/5/2023 11:34:09'!
test26HeadingAndPositionLogAddsHeadingWest
	
	|marsRover headingAndPositionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	headingAndPositionLogTracer := HeadingAndPositionLogTracer with: marsRover.
		
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'Apuntando al Oeste') equals: headingAndPositionLogTracer log.! !

!LogAndWindowTest methodsFor: 'heading and position log tests' stamp: 'FP 6/5/2023 11:34:57'!
test27HeadingAndPositionLogAddsHeadingNorth
	
	|marsRover headingAndPositionLogTracer|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingWest.
	headingAndPositionLogTracer := HeadingAndPositionLogTracer with: marsRover.
		
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'Apuntando al Norte') equals: headingAndPositionLogTracer log.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'FP 6/4/2023 15:01:13'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	
	observers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'FP 6/4/2023 15:16:09'!
rotateLeft
	
	head rotateLeft.
	
	head updateObservers! !

!MarsRover methodsFor: 'heading' stamp: 'FP 6/4/2023 16:00:22'!
rotateRight
	
	head rotateRight.
	
	head updateObservers 
	
! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'FP 6/4/2023 15:02:50'!
moveBackward
	
	head moveBackward.
	
	observers do: [:anObserver | anObserver updatePosition: position]! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'FP 6/4/2023 15:02:27'!
moveForward
	
	head moveForward.
	
	observers do: [:anObserver | anObserver updatePosition: position]! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observers' stamp: 'FP 6/4/2023 15:03:47'!
addObserver: anObserver 

	observers add: anObserver ! !

!MarsRover methodsFor: 'observers' stamp: 'FP 6/4/2023 15:33:43'!
updateObserversWhenHeadingEast
	
	observers do: [:anObserver | anObserver updateWhenHeadingEast]! !

!MarsRover methodsFor: 'observers' stamp: 'FP 6/4/2023 15:35:08'!
updateObserversWhenHeadingNorth
	
	observers do: [:anObserver | anObserver updateWhenHeadingNorth]! !

!MarsRover methodsFor: 'observers' stamp: 'FP 6/4/2023 15:31:54'!
updateObserversWhenHeadingSouth
	
	observers do: [:anObserver | anObserver updateWhenHeadingSouth ]! !

!MarsRover methodsFor: 'observers' stamp: 'FP 6/4/2023 15:17:48'!
updateObserversWhenHeadingWest
	
	observers do: [:anObserver | anObserver updateWhenHeadingWest]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'observers' stamp: 'FP 6/5/2023 12:04:56'!
updateObservers 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'observers' stamp: 'FP 6/4/2023 15:33:18'!
updateObservers

	marsRover updateObserversWhenHeadingEast! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'observers' stamp: 'FP 6/4/2023 15:34:40'!
updateObservers
	
	marsRover updateObserversWhenHeadingNorth! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'observers' stamp: 'FP 6/4/2023 15:27:08'!
updateObservers
	
	marsRover updateObserversWhenHeadingSouth! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'observers' stamp: 'FP 6/4/2023 15:16:46'!
updateObservers
	
	marsRover updateObserversWhenHeadingWest! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'position updates' stamp: 'FP 6/4/2023 16:21:24'!
updatePosition: aPosition 

	self subclassResponsibility ! !


!MarsRoverObserver methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:21:34'!
updateWhenHeadingEast

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:21:41'!
updateWhenHeadingNorth

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:21:39'!
updateWhenHeadingSouth

	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:21:44'!
updateWhenHeadingWest

	self subclassResponsibility ! !


!MarsRoverObserver methodsFor: 'initialization' stamp: 'FP 6/4/2023 16:20:17'!
initializeWith: aMarsRover 

	marsRover := aMarsRover.
	marsRover addObserver: self
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'FP 6/4/2023 16:22:54'!
with: aMarsRover 

	^self new initializeWith: aMarsRover ! !


!classDefinition: #HeadingAndPositionLogTracer category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #HeadingAndPositionLogTracer
	instanceVariableNames: 'headingAndPositionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingAndPositionLogTracer methodsFor: 'initialization' stamp: 'FP 6/5/2023 11:37:47'!
initializeWith: aMarsRover 

	super initializeWith: aMarsRover.
	headingAndPositionLog := OrderedCollection new.
	
	! !


!HeadingAndPositionLogTracer methodsFor: 'log' stamp: 'FP 6/5/2023 11:24:10'!
log
	
	^headingAndPositionLog! !


!HeadingAndPositionLogTracer methodsFor: 'position updates' stamp: 'FP 6/5/2023 11:28:04'!
updatePosition: aPosition 
	
	headingAndPositionLog add: aPosition ! !


!HeadingAndPositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:32:15'!
updateWhenHeadingEast
	
	headingAndPositionLog add: 'Apuntando al Este'! !

!HeadingAndPositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:35:14'!
updateWhenHeadingNorth
	
	headingAndPositionLog add: 'Apuntando al Norte'! !

!HeadingAndPositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:33:53'!
updateWhenHeadingSouth
	
	headingAndPositionLog add: 'Apuntando al Sur'! !

!HeadingAndPositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:34:22'!
updateWhenHeadingWest
	
	headingAndPositionLog add: 'Apuntando al Oeste'! !


!classDefinition: #HeadingAndPositionWindowTracer category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #HeadingAndPositionWindowTracer
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingAndPositionWindowTracer methodsFor: 'initialization' stamp: 'FP 6/5/2023 11:54:55'!
initializeWith: aMarsRover 

	super initializeWith: aMarsRover.
	position := ''.
	heading := ''.
	
! !


!HeadingAndPositionWindowTracer methodsFor: 'window' stamp: 'FP 6/5/2023 11:48:11'!
window
	
	^'Posicion: ', position , ' - Heading: ', heading ! !


!HeadingAndPositionWindowTracer methodsFor: 'position updates' stamp: 'FP 6/5/2023 11:47:22'!
updatePosition: aPosition 
	
	position := aPosition asString! !


!HeadingAndPositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:50:16'!
updateWhenHeadingEast
	
	heading := 'Apuntando al Este'! !

!HeadingAndPositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:53:52'!
updateWhenHeadingNorth
	
	heading := 'Apuntando al Norte'! !

!HeadingAndPositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:51:17'!
updateWhenHeadingSouth
	
	heading := 'Apuntando al Sur'! !

!HeadingAndPositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/5/2023 11:52:34'!
updateWhenHeadingWest
	
	heading := 'Apuntando al Oeste'! !


!classDefinition: #HeadingLogTracer category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #HeadingLogTracer
	instanceVariableNames: 'headingLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLogTracer methodsFor: 'initialization' stamp: 'FP 6/4/2023 16:20:32'!
initializeWith: aMarsRover 

	super initializeWith: aMarsRover.
	headingLog := OrderedCollection new.
	

	! !


!HeadingLogTracer methodsFor: 'log' stamp: 'FP 6/4/2023 15:06:44'!
log
	
	^headingLog! !


!HeadingLogTracer methodsFor: 'position updates' stamp: 'FP 6/4/2023 16:14:40'!
updatePosition: aPosition 
	! !


!HeadingLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:34:04'!
updateWhenHeadingEast
	
	headingLog add: 'Apuntando al Este'! !

!HeadingLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:35:28'!
updateWhenHeadingNorth
	
	headingLog add: 'Apuntando al Norte'! !

!HeadingLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:32:20'!
updateWhenHeadingSouth
	
	headingLog add: 'Apuntando al Sur'! !

!HeadingLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:18:49'!
updateWhenHeadingWest
	
	headingLog add: 'Apuntando al Oeste'! !


!classDefinition: #HeadingWindowTracer category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #HeadingWindowTracer
	instanceVariableNames: 'headingWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingWindowTracer methodsFor: 'initialization' stamp: 'FP 6/4/2023 16:20:46'!
initializeWith: aMarsRover 

	super initializeWith: aMarsRover.
	headingWindow := ''.
	

	! !


!HeadingWindowTracer methodsFor: 'window' stamp: 'FP 6/4/2023 15:08:09'!
window
	
	^headingWindow! !


!HeadingWindowTracer methodsFor: 'position updates' stamp: 'FP 6/4/2023 16:15:07'!
updatePosition: aPosition 
	! !


!HeadingWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:45:11'!
updateWhenHeadingEast
	
	headingWindow := 'Apuntando al Este'! !

!HeadingWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:45:42'!
updateWhenHeadingNorth
	
	headingWindow := 'Apuntando al Norte'! !

!HeadingWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:44:34'!
updateWhenHeadingSouth
	
	headingWindow := 'Apuntando al Sur'! !

!HeadingWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 15:43:58'!
updateWhenHeadingWest
	
	headingWindow := 'Apuntando al Oeste'! !


!classDefinition: #PositionLogTracer category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #PositionLogTracer
	instanceVariableNames: 'positionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLogTracer methodsFor: 'initialization' stamp: 'FP 6/4/2023 16:20:55'!
initializeWith: aMarsRover 

	super initializeWith: aMarsRover.
	positionLog := OrderedCollection new.
	
! !


!PositionLogTracer methodsFor: 'log' stamp: 'FP 6/4/2023 14:36:00'!
log
	
	^positionLog! !


!PositionLogTracer methodsFor: 'position updates' stamp: 'FP 6/4/2023 15:02:09'!
updatePosition: aPosition 
	
	positionLog add: aPosition ! !


!PositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:10:31'!
updateWhenHeadingEast
! !

!PositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:11:53'!
updateWhenHeadingNorth
	! !

!PositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:11:39'!
updateWhenHeadingSouth
	! !

!PositionLogTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:11:47'!
updateWhenHeadingWest
	! !


!classDefinition: #PositionWindowTracer category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #PositionWindowTracer
	instanceVariableNames: 'positionWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindowTracer methodsFor: 'initialization' stamp: 'FP 6/4/2023 16:21:03'!
initializeWith: aMarsRover 

	super initializeWith: aMarsRover.
	positionWindow := ''.
	
! !


!PositionWindowTracer methodsFor: 'window' stamp: 'FP 6/4/2023 14:38:46'!
window
	
	^positionWindow! !


!PositionWindowTracer methodsFor: 'position updates' stamp: 'FP 6/4/2023 14:55:22'!
updatePosition: aPosition 
	
	positionWindow := aPosition asString! !


!PositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:13:26'!
updateWhenHeadingEast
	! !

!PositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:13:47'!
updateWhenHeadingNorth
	! !

!PositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:13:33'!
updateWhenHeadingSouth
	! !

!PositionWindowTracer methodsFor: 'heading updates' stamp: 'FP 6/4/2023 16:13:40'!
updateWhenHeadingWest
	! !
