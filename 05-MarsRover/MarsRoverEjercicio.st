!classDefinition: #MarsRoverTest category: 'MarsRoverEjercicio'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'sp 5/12/2023 15:46:37'!
assertMarsRover: aMarsRover isInPosition: aPosition withFacingState: aFacingState


	self assert: aPosition equals: aMarsRover currentPosition.
	self assert: aFacingState equals: aMarsRover facingState.
	
	! !


!MarsRoverTest methodsFor: 'mars rovers' stamp: 'sp 5/12/2023 16:05:43'!
marsRoverFacingEast

	^ MarsRover on: 0@0 facingState: MarsRoverFacingEast new! !

!MarsRoverTest methodsFor: 'mars rovers' stamp: 'sp 5/12/2023 16:05:13'!
marsRoverFacingNorth

	^ MarsRover on: 0@0 facingState: MarsRoverFacingNorth new! !

!MarsRoverTest methodsFor: 'mars rovers' stamp: 'sp 5/12/2023 16:05:55'!
marsRoverFacingSouth

	^ MarsRover on: 0@0 facingState: MarsRoverFacingSouth new! !

!MarsRoverTest methodsFor: 'mars rovers' stamp: 'sp 5/12/2023 16:06:09'!
marsRoverFacingWest

	^ MarsRover on: 0@0 facingState: MarsRoverFacingWest new! !


!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:07:29'!
test01MarsRoverIsInInitialPositionPointingToInitialCardinalPoint


	self assertMarsRover: (self marsRoverFacingNorth) 
		isInPosition: 0@0
		withFacingState: MarsRoverFacingNorth 
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:13'!
test02EmptyCommandDoesNothing

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover readCommands: ''.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 withFacingState: MarsRoverFacingNorth 
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:13'!
test03MarsRoverFacingNorthKnowsHowToReceiveForwardCommand

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover readCommands: 'f'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 + (0@1) withFacingState: MarsRoverFacingNorth. 
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:43'!
test04MarsRoverFacingEastKnowsHowToReceiveForwardCommand

	| marsRover |
	
	marsRover := self marsRoverFacingEast.
	
	marsRover readCommands: 'f'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 + (1@0) withFacingState: MarsRoverFacingEast 
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:55'!
test05MarsRoverFacingSouthKnowsHowToReceiveForwardCommand

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover readCommands: 'f'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 - (0@1) withFacingState: MarsRoverFacingSouth
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:06:09'!
test06MarsRoverFacingWestKnowsHowToReceiveForwardCommand

	| marsRover |
	
	marsRover := self marsRoverFacingWest.
	
	marsRover readCommands: 'f'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 - (1@0) withFacingState: MarsRoverFacingWest
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:13'!
test07MarsRoverKnowsHowToReceiveBackwardCommand

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover readCommands: 'b'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 - (0@1) withFacingState: MarsRoverFacingNorth 
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:13'!
test08MarsRoverFacingNorthKnowsHowToReceiveRightRotationCommand

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover readCommands: 'r'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 withFacingState: MarsRoverFacingEast. 
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:43'!
test09MarsRoverFacingEastKnowsHowToReceiveRightRotationCommand

	| marsRover |
	
	marsRover := self marsRoverFacingEast.
	
	marsRover readCommands: 'r'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 withFacingState: MarsRoverFacingSouth
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:55'!
test10MarsRoverFacingSouthKnowsHowToReceiveRightRotationCommand

	| marsRover |
	
	marsRover := self marsRoverFacingSouth.
	
	marsRover readCommands: 'r'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 withFacingState: MarsRoverFacingWest
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:06:09'!
test11MarsRoverFacingWestKnowsHowToReceiveRightRotationCommand

	| marsRover |
	
	marsRover := self marsRoverFacingWest.
	
	marsRover readCommands: 'r'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 withFacingState: MarsRoverFacingNorth 
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:13'!
test12MarsRoverKnowsHowToReceiveLeftRotationCommand

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover readCommands: 'l'.	
	
	self assertMarsRover: marsRover isInPosition: 0@0 withFacingState: MarsRoverFacingWest
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'sp 5/12/2023 16:05:13'!
test13MarsRoverKnowsHowToReceiveMoreThanOneCommand

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
	
	marsRover readCommands: 'rfflbrr'.	
	
	self assertMarsRover: marsRover isInPosition: (2@-1) withFacingState: MarsRoverFacingSouth.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'FP 5/15/2023 13:13:22'!
test14MarsRoverRaisesErrorWhenEncounteringInvalidCommand

	| marsRover |
	
	marsRover := self marsRoverFacingNorth.
			
	self 
		should:  [marsRover readCommands: 'rfflbxrr'] 
		raise:  Error 
		withExceptionDo: [:anError | self assert: anError messageText = MarsRover invalidCommandErrorDescription.
				self assertMarsRover: marsRover isInPosition:  2@-1 withFacingState: MarsRoverFacingNorth ].
	

	
	! !


!classDefinition: #MarsRover category: 'MarsRoverEjercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition facingState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRover methodsFor: 'initialization' stamp: 'sp 5/12/2023 15:32:07'!
initializeOn: initialPosition facingState: initialFacingState 
	
	currentPosition := initialPosition.
	facingState := initialFacingState.! !


!MarsRover methodsFor: 'commands' stamp: 'FP 5/14/2023 11:45:42'!
readCommands: aCommandList

	aCommandList asOrderedCollection do: [ :command |

		self assertCommandIsValid: command.

		command = $f ifTrue: [facingState moveForward: self			].
		command = $b ifTrue: [facingState moveBackwards: self			].
		command = $r ifTrue: [facingState rotateRight: self			].
		command = $l ifTrue: [facingState rotateLeft: self].
	]

	! !


!MarsRover methodsFor: 'accessing' stamp: 'sp 5/12/2023 13:26:02'!
currentPosition
	
	^currentPosition! !

!MarsRover methodsFor: 'accessing' stamp: 'sp 5/12/2023 15:47:25'!
facingState
	
	^facingState class! !


!MarsRover methodsFor: 'moving forward - private' stamp: 'sp 5/12/2023 15:54:53'!
moveForwardWhenFacingEast
	
	currentPosition := currentPosition + (1@0)! !

!MarsRover methodsFor: 'moving forward - private' stamp: 'sp 5/12/2023 15:54:32'!
moveForwardWhenFacingNorth
	
	currentPosition := currentPosition + (0@1)! !

!MarsRover methodsFor: 'moving forward - private' stamp: 'sp 5/12/2023 15:55:07'!
moveForwardWhenFacingSouth
	
	currentPosition := currentPosition - (0@1)! !

!MarsRover methodsFor: 'moving forward - private' stamp: 'sp 5/12/2023 15:55:20'!
moveForwardWhenFacingWest
	
	currentPosition := currentPosition - (1@0)! !


!MarsRover methodsFor: 'moving backward - private' stamp: 'sp 5/12/2023 17:07:01'!
moveBackwardsWhenFacingEast
	
	currentPosition := currentPosition - (1@0)! !

!MarsRover methodsFor: 'moving backward - private' stamp: 'sp 5/12/2023 15:55:34'!
moveBackwardsWhenFacingNorth
	
	currentPosition := currentPosition - (0@1)! !

!MarsRover methodsFor: 'moving backward - private' stamp: 'sp 5/12/2023 17:06:50'!
moveBackwardsWhenFacingSouth
	
	currentPosition := currentPosition + (0@1)! !

!MarsRover methodsFor: 'moving backward - private' stamp: 'sp 5/12/2023 17:07:06'!
moveBackwardsWhenFacingWest
	
	currentPosition := currentPosition + (1@0)! !


!MarsRover methodsFor: 'rotating left - private' stamp: 'sp 5/12/2023 15:59:12'!
rotateLeftWhenFacingEast
	
	facingState := MarsRoverFacingNorth new.! !

!MarsRover methodsFor: 'rotating left - private' stamp: 'sp 5/12/2023 15:58:42'!
rotateLeftWhenFacingNorth
	
	facingState := MarsRoverFacingWest new.! !

!MarsRover methodsFor: 'rotating left - private' stamp: 'sp 5/12/2023 17:07:57'!
rotateLeftWhenFacingSouth
	
	facingState := MarsRoverFacingEast new.! !

!MarsRover methodsFor: 'rotating left - private' stamp: 'sp 5/12/2023 17:07:29'!
rotateLeftWhenFacingWest
	
	facingState := MarsRoverFacingSouth new.! !


!MarsRover methodsFor: 'assertions' stamp: 'FP 5/14/2023 11:45:42'!
assertCommandIsValid: command

	^ (self isCommandValid: command) ifFalse: [self signalInvalidCommandError]! !

!MarsRover methodsFor: 'assertions' stamp: 'sp 5/12/2023 14:34:30'!
isCommandValid: aCommand

        ^'fblr' asOrderedCollection includes: aCommand! !

!MarsRover methodsFor: 'assertions' stamp: 'FP 5/14/2023 11:45:07'!
signalInvalidCommandError 

	self error: self class invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'rotating right - private' stamp: 'sp 5/12/2023 15:56:34'!
rotateRightWhenFacingEast
	
	facingState := MarsRoverFacingSouth new.! !

!MarsRover methodsFor: 'rotating right - private' stamp: 'sp 5/12/2023 15:56:05'!
rotateRightWhenFacingNorth
	
	facingState := MarsRoverFacingEast new.! !

!MarsRover methodsFor: 'rotating right - private' stamp: 'sp 5/12/2023 15:56:55'!
rotateRightWhenFacingSouth
	
	facingState := MarsRoverFacingWest new.! !

!MarsRover methodsFor: 'rotating right - private' stamp: 'sp 5/12/2023 15:57:13'!
rotateRightWhenFacingWest
	
	facingState := MarsRoverFacingNorth new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverEjercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'sp 5/12/2023 15:31:07'!
on: initialPosition facingState: initialFacingState 
	
	^self new initializeOn: initialPosition facingState: initialFacingState ! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'FP 5/14/2023 11:44:31'!
invalidCommandErrorDescription

	^'Se ha ingresado un comando invalido.'! !


!classDefinition: #MarsRoverFacingState category: 'MarsRoverEjercicio'!
Object subclass: #MarsRoverFacingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverFacingState methodsFor: 'moving' stamp: 'sp 5/12/2023 15:22:53'!
moveBackwards: aMarsRoverToMove

	self subclassResponsibility ! !

!MarsRoverFacingState methodsFor: 'moving' stamp: 'sp 5/12/2023 15:23:18'!
moveForward: aMarsRoverToMove

	self subclassResponsibility ! !


!MarsRoverFacingState methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:23:34'!
rotateLeft: aMarsRoverToRotate

	self subclassResponsibility ! !

!MarsRoverFacingState methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:23:51'!
rotateRight: aMarsRoverToRotate

	self subclassResponsibility ! !


!classDefinition: #MarsRoverFacingEast category: 'MarsRoverEjercicio'!
MarsRoverFacingState subclass: #MarsRoverFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverFacingEast methodsFor: 'moving' stamp: 'sp 5/12/2023 15:24:28'!
moveBackwards: aMarsRoverToMove

	aMarsRoverToMove moveBackwardsWhenFacingEast! !

!MarsRoverFacingEast methodsFor: 'moving' stamp: 'sp 5/12/2023 15:25:26'!
moveForward: aMarsRoverToMove

	aMarsRoverToMove moveForwardWhenFacingEast! !


!MarsRoverFacingEast methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:26:10'!
rotateLeft: aMarsRoverToRotate

	aMarsRoverToRotate rotateLeftWhenFacingEast! !

!MarsRoverFacingEast methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:26:48'!
rotateRight: aMarsRoverToRotate

	aMarsRoverToRotate rotateRightWhenFacingEast! !


!classDefinition: #MarsRoverFacingNorth category: 'MarsRoverEjercicio'!
MarsRoverFacingState subclass: #MarsRoverFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverFacingNorth methodsFor: 'moving' stamp: 'sp 5/12/2023 15:24:54'!
moveBackwards: aMarsRoverToMove

	aMarsRoverToMove moveBackwardsWhenFacingNorth! !

!MarsRoverFacingNorth methodsFor: 'moving' stamp: 'sp 5/12/2023 15:25:37'!
moveForward: aMarsRoverToMove

	aMarsRoverToMove moveForwardWhenFacingNorth! !


!MarsRoverFacingNorth methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:26:16'!
rotateLeft: aMarsRoverToRotate

	aMarsRoverToRotate rotateLeftWhenFacingNorth! !

!MarsRoverFacingNorth methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:26:57'!
rotateRight: aMarsRoverToRotate

	aMarsRoverToRotate rotateRightWhenFacingNorth! !


!classDefinition: #MarsRoverFacingSouth category: 'MarsRoverEjercicio'!
MarsRoverFacingState subclass: #MarsRoverFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverFacingSouth methodsFor: 'moving' stamp: 'sp 5/12/2023 15:25:02'!
moveBackwards: aMarsRoverToMove

	aMarsRoverToMove moveBackwardsWhenFacingSouth! !

!MarsRoverFacingSouth methodsFor: 'moving' stamp: 'sp 5/12/2023 15:25:44'!
moveForward: aMarsRoverToMove

	aMarsRoverToMove moveForwardWhenFacingSouth! !


!MarsRoverFacingSouth methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:26:24'!
rotateLeft: aMarsRoverToRotate

	aMarsRoverToRotate rotateLeftWhenFacingSouth! !

!MarsRoverFacingSouth methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:27:06'!
rotateRight: aMarsRoverToRotate

	aMarsRoverToRotate rotateRightWhenFacingSouth! !


!classDefinition: #MarsRoverFacingWest category: 'MarsRoverEjercicio'!
MarsRoverFacingState subclass: #MarsRoverFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverEjercicio'!

!MarsRoverFacingWest methodsFor: 'moving' stamp: 'sp 5/12/2023 15:25:10'!
moveBackwards: aMarsRoverToMove

	aMarsRoverToMove moveBackwardsWhenFacingWest! !

!MarsRoverFacingWest methodsFor: 'moving' stamp: 'sp 5/12/2023 15:25:54'!
moveForward: aMarsRoverToMove

	aMarsRoverToMove moveForwardWhenFacingWest! !


!MarsRoverFacingWest methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:26:32'!
rotateLeft: aMarsRoverToRotate

	aMarsRoverToRotate rotateLeftWhenFacingWest! !

!MarsRoverFacingWest methodsFor: 'rotating' stamp: 'sp 5/12/2023 15:27:12'!
rotateRight: aMarsRoverToRotate

	aMarsRoverToRotate rotateRightWhenFacingWest! !
