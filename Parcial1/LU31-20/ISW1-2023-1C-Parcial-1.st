!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'creacion de excavadoras' stamp: 'FP 5/8/2023 20:37:12'!
crearExcavadoraSobreSueloDado: unSueloParaExcavar

	^Perforadora sobreSuelo: unSueloParaExcavar! !


!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 21:02:53'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora  |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Arenoso new.
			Tierra new.
			Concreto with: 5 } .
	
	self alTaladrarConMechaSoftUnaCantidadDeVeces: 1
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | self assert: Tierra new equals: unaExcavadora capaDeSueloInmediata]
	
	
	
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 21:03:24'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora  |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Tierra new.
			Concreto with: 5 } .
	
	self alTaladrarConMechaSoftUnaCantidadDeVeces: 1
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | self assert: Tierra new equals: unaExcavadora capaDeSueloInmediata]
	
	
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:38:19'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Concreto with: 5.
			Tierra new.} .
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:58:46'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Arenoso new.
			Tierra new.
			Concreto with: 5 } .
		
	self alTaladrarConMechaWidiaUnaCantidadDeVeces: 1 
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | self assert: Tierra new equals: unaExcavadora capaDeSueloInmediata]
	
	
	
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:59:14'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Tierra new.
			Concreto with: 5 } .
	
	self alTaladrarConMechaWidiaUnaCantidadDeVeces: 2 
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | self assert: Arenoso new equals: unaExcavadora capaDeSueloInmediata]
	
	
	
	
	
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 21:00:10'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Concreto with: 5.	
			Tierra new} .
	
	self alTaladrarConMechaWidiaUnaCantidadDeVeces: 2 
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | 
			self should: [unaExcavadora darGolpeDeTaladro]
			raise: Error
			withExceptionDo: [:unError |
				self assert: 'Se rompió' equals: unError messageText.
				self assert: unaExcavadora conMechaRota.]]
		
		
	
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:39:29'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Arenoso new.
			Tierra new.
			Concreto with: 5 } .
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:55:26'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Tierra new.
			Concreto with: 5 } .
	
	self alTaladrarConMechaDiamanteUnaCantidadDeVeces: 1 
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | self assert: (Concreto with: 5) equals: unaExcavadora capaDeSueloInmediata]
	
	
	

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:54:18'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Concreto with: 5.
			Tierra new.
			} .
			
	self alTaladrarConMechaDiamanteUnaCantidadDeVeces: 2 
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | self assert: (Concreto with: 4) equals: unaExcavadora capaDeSueloInmediata]
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 21:09:55'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora |
	
	excavadora :=self crearExcavadoraSobreSueloDado: {
			Arenoso new.
			'Mica'.
			'Marmol'
			} .
			
	self alTaladrarConMechaSoftUnaCantidadDeVeces: 1 
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora |self assert: {	'Mica'. 'Marmol'} equals: unaExcavadora elementsInContainer]
	
	
	
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 21:10:35'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			Arenoso new.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self alTaladrarConMechaSoftUnaCantidadDeVeces: 1 
		conExcavadora:  excavadora 
		seCumpleQue: [:unaExcavadora | self assert: unaExcavadora elementsInContainer isEmpty]
	

	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:43:06'!
test12NoPuedePerforarSinMecha

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: {
			Arenoso new.
			} .
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: Arenoso new equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:41:00'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora |
	
	excavadora := self crearExcavadoraSobreSueloDado: { self ArenosoConAlturaDos. self TierraConAlturaCuarenta. Arenoso new} .
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:30:17'!
test14PuedeContarLasCapasDeTipoArenoso

	self asegurarQueHayUnaCantidad: 2 deTipoDeCapa: Arenoso ! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:30:27'!
test15PuedeContarLasCapasDeTipoTierra

	self asegurarQueHayUnaCantidad: 1 deTipoDeCapa: Tierra
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:30:50'!
test16PuedeContarLasCapasDeTipoConcreto

	self asegurarQueHayUnaCantidad: 1 deTipoDeCapa: Concreto
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:33:09'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	self asegurarQueLaProfundidadHastaPrimerCapaDeTipo: Arenoso es: 0.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:32:58'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	self asegurarQueLaProfundidadHastaPrimerCapaDeTipo: Tierra es: 2.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 20:32:39'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	self asegurarQueLaProfundidadHastaPrimerCapaDeTipo: Concreto es: 42.! !

!TestDePerforación methodsFor: 'test' stamp: 'FP 5/8/2023 21:43:39'!
test20NoPuedePerforarSinMecha
	
	
	self should: [Perforadora sobreSuelo: {
			Tierra new.
			Tierra new.
			}]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'El suelo no puede tener dos capas contiguas del mismo tipo' equals: unError messageText].	
	! !


!TestDePerforación methodsFor: 'creacion de capas' stamp: 'FP 5/8/2023 20:34:47'!
ArenosoConAlturaDos

	^ Arenoso new setAltura: 2! !

!TestDePerforación methodsFor: 'creacion de capas' stamp: 'FP 5/8/2023 20:35:08'!
TierraConAlturaCuarenta

	^ Tierra new setAltura: 40! !


!TestDePerforación methodsFor: 'aserciones - scan' stamp: 'FP 5/8/2023 20:35:08'!
asegurarQueHayUnaCantidad: cantidadDeCapas deTipoDeCapa: unTipoDeCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { self ArenosoConAlturaDos. self TierraConAlturaCuarenta. Arenoso new. Concreto with: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: cantidadDeCapas equals: (excavadora contarCapas: unTipoDeCapa ).

	! !

!TestDePerforación methodsFor: 'aserciones - scan' stamp: 'FP 5/8/2023 21:06:44'!
asegurarQueLaProfundidadHastaPrimerCapaDeTipo: unTipoDeCapa es: profundidadEsperada
	
	| excavadora sueloAExcavar |
	
	sueloAExcavar := { self ArenosoConAlturaDos. self TierraConAlturaCuarenta. Arenoso new. Concreto with: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: profundidadEsperada equals: (excavadora calcularProfundidadDelSueloHasta: unTipoDeCapa ).

	! !


!TestDePerforación methodsFor: 'aserciones - cantidad de golpes de taladro' stamp: 'FP 5/8/2023 21:03:51'!
alTaladrarConMechaDiamanteUnaCantidadDeVeces: unaCantidadDeGolpes conExcavadora: unaExcavadora seCumpleQue: unBloqueParaAsegurarCondicionesSobreLaExcavacion
	
	unaExcavadora ponerMechaDiamante.
	unaCantidadDeGolpes timesRepeat: [unaExcavadora darGolpeDeTaladro].
	unBloqueParaAsegurarCondicionesSobreLaExcavacion value: unaExcavadora 

	
	! !

!TestDePerforación methodsFor: 'aserciones - cantidad de golpes de taladro' stamp: 'FP 5/8/2023 21:03:48'!
alTaladrarConMechaSoftUnaCantidadDeVeces: unaCantidadDeGolpes conExcavadora: unaExcavadora seCumpleQue: unBloqueParaAsegurarCondicionesSobreLaExcavacion
	
	unaExcavadora ponerMechaSoft.
	unaCantidadDeGolpes timesRepeat: [unaExcavadora darGolpeDeTaladro].
	unBloqueParaAsegurarCondicionesSobreLaExcavacion value: unaExcavadora 

	
	! !

!TestDePerforación methodsFor: 'aserciones - cantidad de golpes de taladro' stamp: 'FP 5/8/2023 21:03:44'!
alTaladrarConMechaWidiaUnaCantidadDeVeces: unaCantidadDeGolpes conExcavadora: unaExcavadora seCumpleQue: unBloqueParaAsegurarCondicionesSobreLaExcavacion
	
	unaExcavadora ponerMechaWidia.
	unaCantidadDeGolpes timesRepeat: [unaExcavadora darGolpeDeTaladro].
	unBloqueParaAsegurarCondicionesSobreLaExcavacion value: unaExcavadora 

	
	! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'resistencia altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:18:13'!
esArenoso

	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:18:17'!
esConcreto

	self subclassResponsibility ! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:18:20'!
esTierra
	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'FP 5/8/2023 21:19:29'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [resistencia = unaCapaDeSuelo resistencia]! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'FP 5/8/2023 21:19:47'!
hash

	^self class hash + resistencia hash! !


!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
sinResistencia
	^resistencia = 0! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 5/8/2023 13:10:35'!
resistencia

	^ resistencia.! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'FRT 5/5/2023 16:31:36'!
scan

	self esArenoso ifTrue: [ ^ 7 ].
	self esTierra ifTrue: [ ^ 10 ].
	^ 50. ! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'FRT 5/5/2023 16:07:55'!
setAltura: unaAltura

	altura := unaAltura! !


!CapaDeSuelo methodsFor: 'excavacion' stamp: 'FP 5/8/2023 19:16:03'!
recibirGolpeDePerforadora: unaPerforadoraQueTaladra

	self subclassResponsibility ! !


!classDefinition: #Arenoso category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Arenoso methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:23'!
esArenoso
	^true! !

!Arenoso methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:28'!
esConcreto
	^false! !

!Arenoso methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:31'!
esTierra
	^false! !


!Arenoso methodsFor: 'initialization' stamp: 'FP 5/8/2023 21:20:11'!
initialize 

	altura := 0.! !


!Arenoso methodsFor: 'excavacion' stamp: 'FP 5/8/2023 17:46:48'!
recibirGolpeDePerforadora: unaPerforadoraQueTaladra

	^unaPerforadoraQueTaladra darGolpeDeTaladroACapaArenosa
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arenoso class' category: 'ISW1-2023-1C-Parcial-1'!
Arenoso class
	instanceVariableNames: ''!

!Arenoso class methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:22:26'!
scan 

	^ 7 ! !


!classDefinition: #Concreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Concreto methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:39'!
esArenoso
	^false! !

!Concreto methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:42'!
esConcreto
	^true! !

!Concreto methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:46'!
esTierra
	^false! !


!Concreto methodsFor: 'initialization' stamp: 'FP 5/8/2023 21:20:16'!
initializeWith: resistenciaInicial

	resistencia := resistenciaInicial.
	altura := 0.! !


!Concreto methodsFor: 'excavacion' stamp: 'FP 5/8/2023 17:46:48'!
recibirGolpeDePerforadora: unaPerforadoraQueTaladra

	^unaPerforadoraQueTaladra darGolpeDeTaladroACapaConcreto
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Concreto class' category: 'ISW1-2023-1C-Parcial-1'!
Concreto class
	instanceVariableNames: ''!

!Concreto class methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:22:54'!
scan 

	^ 50. ! !

!Concreto class methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 17:50:47'!
with: resistenciaInicial

	^self new initializeWith: resistenciaInicial ! !


!classDefinition: #Tierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Tierra methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:51'!
esArenoso
	^false! !

!Tierra methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:55'!
esConcreto
	^false! !

!Tierra methodsFor: 'tipo' stamp: 'FP 5/8/2023 19:17:58'!
esTierra
	^true! !


!Tierra methodsFor: 'initialization' stamp: 'FP 5/8/2023 21:20:22'!
initialize 

	altura := 0.! !


!Tierra methodsFor: 'excavacion' stamp: 'FP 5/8/2023 17:46:48'!
recibirGolpeDePerforadora: unaPerforadoraQueTaladra

	^unaPerforadoraQueTaladra darGolpeDeTaladroACapaTierra
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tierra class' category: 'ISW1-2023-1C-Parcial-1'!
Tierra class
	instanceVariableNames: ''!

!Tierra class methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:23:03'!
scan 

	^10
! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: 'rota'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'excavacion' stamp: 'FP 5/8/2023 19:05:36'!
estaRota 

	^rota ! !

!Mecha methodsFor: 'excavacion' stamp: 'FP 5/8/2023 18:55:07'!
initialize 

	rota := false.! !

!Mecha methodsFor: 'excavacion' stamp: 'FP 5/8/2023 19:15:23'!
taladrarCapaArenosaCon: unaPerforadoraQueTaladra 

	self subclassResponsibility ! !

!Mecha methodsFor: 'excavacion' stamp: 'FP 5/8/2023 19:15:27'!
taladrarCapaConcretoCon: unaPerforadoraQueTaladra 

	self subclassResponsibility ! !

!Mecha methodsFor: 'excavacion' stamp: 'FP 5/8/2023 19:15:30'!
taladrarCapaTierraCon: unaPerforadoraQueTaladra 

	self subclassResponsibility ! !


!classDefinition: #Diamante category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Diamante methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 18:56:10'!
taladrarCapaArenosaCon: unaPerforadoraQueTaladra 
	
	rota := true. 
	self error: 'Se rompió'.
	^self
	! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:01:24'!
taladrarCapaConcretoCon: unaPerforadoraQueTaladra 

	unaPerforadoraQueTaladra vecesQueGolpeoCapaActual even ifTrue: [ 
		unaPerforadoraQueTaladra bajarUnDecimoDeResistenciaCapaInmediata].
	unaPerforadoraQueTaladra tieneONoResistenciaLaCapaInmediata ifTrue: [ ^unaPerforadoraQueTaladra transformarCapaEnArenoso].
	^unaPerforadoraQueTaladra vecesQueGolpeoCapaActual
	! !

!Diamante methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:01:44'!
taladrarCapaTierraCon: unaPerforadoraQueTaladra 

	^unaPerforadoraQueTaladra pasarAProximaCapa
	! !


!classDefinition: #Soft category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Soft methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:02:03'!
taladrarCapaArenosaCon: unaPerforadoraQueTaladra 

	^unaPerforadoraQueTaladra pasarAProximaCapa
	! !

!Soft methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:03:41'!
taladrarCapaConcretoCon: unaPerforadoraQueTaladra 

	
	rota := true. 
	unaPerforadoraQueTaladra error: 'Se rompió'.
	! !

!Soft methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:02:41'!
taladrarCapaTierraCon: unaPerforadoraQueTaladra 

	^unaPerforadoraQueTaladra 
	! !


!classDefinition: #Widia category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Widia methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:02:55'!
taladrarCapaArenosaCon: unaPerforadoraQueTaladra 

	
	^unaPerforadoraQueTaladra pasarAProximaCapa
	! !

!Widia methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:03:32'!
taladrarCapaConcretoCon: unaPerforadoraQueTaladra 

	
	unaPerforadoraQueTaladra vecesQueGolpeoCapaActual = 3 ifTrue: [ rota := true. unaPerforadoraQueTaladra error: 'Se rompió' ].
	^unaPerforadoraQueTaladra 
	! !

!Widia methodsFor: 'as yet unclassified' stamp: 'FP 5/8/2023 19:04:08'!
taladrarCapaTierraCon: unaPerforadoraQueTaladra 

	unaPerforadoraQueTaladra vecesQueGolpeoCapaActual = 2 ifTrue: [ ^unaPerforadoraQueTaladra transformarCapaEnArenoso ].
	^unaPerforadoraQueTaladra 
	! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container sinMecha'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'FP 5/8/2023 18:58:54'!
bajarUnDecimoDeResistenciaCapaInmediata

	^ capasDeSueloDebajo first bajaUnDecimoDeResistencia! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 5/1/2023 20:07:29'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(capasDeSueloDebajo first isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'FP 5/8/2023 17:55:32'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: Arenoso new;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'FP 5/8/2023 19:12:19'!
asegurarQueHayMecha

	^ self sinMecha ifTrue: [self error: 'No puede perforar']! !

!Perforadora methodsFor: 'excavation' stamp: 'FP 5/8/2023 19:12:19'!
darGolpeDeTaladro
		
	self asegurarQueHayMecha.

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.

	^self capaDeSueloInmediata recibirGolpeDePerforadora: self.! !

!Perforadora methodsFor: 'excavation' stamp: 'FP 5/8/2023 18:32:07'!
darGolpeDeTaladroACapaArenosa
	
	^mechaPuesta taladrarCapaArenosaCon: self! !

!Perforadora methodsFor: 'excavation' stamp: 'FP 5/8/2023 18:36:02'!
darGolpeDeTaladroACapaConcreto
		
	^mechaPuesta taladrarCapaConcretoCon: self! !

!Perforadora methodsFor: 'excavation' stamp: 'FP 5/8/2023 18:36:07'!
darGolpeDeTaladroACapaTierra
	
	^mechaPuesta taladrarCapaTierraCon: self! !

!Perforadora methodsFor: 'excavation' stamp: 'FP 5/8/2023 19:00:35'!
tieneONoResistenciaLaCapaInmediata

	^ capasDeSueloDebajo first sinResistencia! !


!Perforadora methodsFor: 'initialization' stamp: 'FP 5/8/2023 19:10:37'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	sinMecha := true.! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'FP 5/8/2023 19:05:15'!
conMechaRota

	^mechaPuesta estaRota! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'FP 5/8/2023 19:09:49'!
sinMecha

	^sinMecha ! !

!Perforadora methodsFor: 'accessing' stamp: 'FP 5/8/2023 18:59:19'!
vecesQueGolpeoCapaActual

	^vecesQueGolpeoCapaActual ! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'FP 5/8/2023 19:09:11'!
ponerMechaDiamante
	mechaPuesta := Diamante new.
	sinMecha := false.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'FP 5/8/2023 19:09:17'!
ponerMechaSoft
	mechaPuesta := Soft new.
	sinMecha := false.! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'FP 5/8/2023 19:09:22'!
ponerMechaWidia
	mechaPuesta := Widia new.
	sinMecha := false! !


!Perforadora methodsFor: 'scan' stamp: 'FP 5/8/2023 18:09:05'!
calcularProfundidadDelSuelo
	
	^capasDeSueloDebajo 
		sum: [:capa | capa altura] 
		ifEmpty: [^0].
	
	! !

!Perforadora methodsFor: 'scan' stamp: 'FP 5/8/2023 19:31:08'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valorScanDeTipoDeCapaAContar profundidadAcumulada|
	
	profundidadAcumulada := 0.
	valorScanDeTipoDeCapaAContar := tipoDeCapa scan.
	
	capasDeSueloDebajo do: [ :capa| 		
		valorScanDeTipoDeCapaAContar = capa scan ifTrue: [ ^ profundidadAcumulada ].
		profundidadAcumulada := profundidadAcumulada + capa altura.
	].

	^profundidadAcumulada 
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'FP 5/8/2023 19:28:34'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| valorScanDeTipoDeCapaAContar capasDelTipoBuscado|
	
	valorScanDeTipoDeCapaAContar := tipoDeCapa scan.

	capasDelTipoBuscado :=  capasDeSueloDebajo select: [ :capa | 
		valorScanDeTipoDeCapaAContar = capa scan
	].
	
	^capasDelTipoBuscado sum: [:capa | 1] ifEmpty: [^0]

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'FP 5/8/2023 21:37:54'!
assertNoHayDosCapasContiguasDelMismoTipo: capasDeSueloAExcavar
	
	capasDeSueloAExcavar fold: [:a :b |
		((a class = b class and: (a class = String) not)) ifTrue: [self error: 'El suelo no puede tener dos capas contiguas del mismo tipo']. b]
	
! !

!Perforadora class methodsFor: 'instance creation' stamp: 'FP 5/8/2023 20:13:07'!
sobreSuelo: capasDeSueloAExcavar 
	self assertNoHayDosCapasContiguasDelMismoTipo: capasDeSueloAExcavar.
	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !
