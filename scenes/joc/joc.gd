extends Node2D

@onready var baralla_scene = preload("res://scenes/baralla/baralla.tscn")

var baralla: Baralla
var maJugador : Array = []
var maOrdinador: Array = []
var maDescarts: Array = []

var scoreJugador: int = 0
var scoreOrdinador: int = 0

var posicioJugador = Vector2(-100,400)
var posicioOrdinador = Vector2(-100, 200)

var valors = ["2","3","4","5","6","7","8","9","10","J","Q","K","ACE"]
var pesos = [2,3,4,5,6,7,8,9,10,10,10,10,11]

var fiPartida: bool = false
var fiJugador: bool = false

# Valor inicial dels diners del jugador
var credits: int = 20

# Valor de l'aposta del jugador
var aposta: int = 2

var fiDiners: bool = false

var cartaCover: Carta = Carta.new("ACE","Clubs")
var cartaCoverBaralla: Carta = Carta.new("ACE","Clubs")
var trasera: String

var numCartes: int


func inicialitzarVariables() -> void:
	$nouJoc.disabled = true
	$nouJoc.visible = false
	$nouJoc.text = ""
	$guanyes.visible = false
	$perds.visible = false
	numCartes = 52
	trasera = "Back_1.png"
	
	# També inicialitzam els textes
	$credit.text = "Crèdit: " + str(credits) + "€"
	$scoreJugador.text = "Punts Jugador: " + str(scoreJugador)
	$scoreOrdinador.text =  "Punts Ordinador: " + str(scoreOrdinador)
	$ncartes.text = "Cartes restants: " + str(numCartes)
	
	# Finalment assignam la imagte de la trassera a la carta de l'ordinador
	cartaCover.set_imatge("res://assets/KINCards/" + trasera)
	cartaCoverBaralla.set_imatge("res://assets/KINCards/" + trasera)

func _ready() -> void:
	
	inicialitzarVariables()
	# Instanciar la baralla y afegir-la a l'escena
	creaBaralla()
	
	
func _process(_delta) -> void:
	
	# Funcionament del BlackJack
	# Se fa s'aposta per part del jugador.
	# Se reparteixen 2 cartes vistes al jugador i 1 vista i una no vista a la banca
	# Ara se pot:
	#   1. Demanar cartes fins a que acabis de demanar o te passis
	#   2. Se pot doblar l'aposta i te donen just una carta. Fi del torn del jugador
	#   3. Te plantes
		
	#Si s'han repartit al menys 3 cartes o el jugador se planta, revisam qui ha guanyat i qui no
	if fiJugador:
		
		#Llevam el cover de l'ordinador
		eliminarCoverOrdinador()
		$collir.disabled = true
		$passar.disabled = true
		$doblar.disabled = true
		
		if scoreOrdinador > 16:
			fiPartida = true
			
		if (scoreJugador > 22 or fiJugador) and !fiPartida:
			tornOrdinador()
		
		if fiPartida:
			var icona: String
			
			if scoreOrdinador > 21:
				#print("Guanayador Jugador")
				#$guanyes.visible = true
				icona = "res://assets/guanyes.png"
				credits += aposta
			elif (scoreJugador > scoreOrdinador) and scoreJugador < 22:
				#print("Guanayador Jugador")
				#$guanyes.visible = true
				icona = "res://assets/guanyes.png"
				credits += aposta
			else:
				#print("Guanyador Ordinador")
				#$perds.visible = true
				icona = "res://assets/perds.png"
				credits -= aposta
			
			$scoreOrdinador.text = "Punts Ordinador: " + str(scoreOrdinador)
			
			$credit.text = "Crèdit: " + str(credits) + "€"
			set_process(false)
			$nouJoc.disabled = false
			$nouJoc.visible = true
			$nouJoc.icon = load(icona)

func tornOrdinador() -> void:
	if numCartes > 1:
		if scoreJugador < 22:
			collirCartaOrdinador()
		else:
			fiPartida = true
	else:
		# Hem de collir els descarts, escapçar-los i tornar-los a ficar a la baralla
		eliminarCoverBaralla()
		collirCartaOrdinador()
		referBaralla()
		

func tapaCartaOrdinador() -> void:
		# Cream una carta per a què tapi les altres de la ma de l'ordinador
	add_child(cartaCover)
	cartaCover.position = Vector2(130,280)
	cartaCover.visible = true

func eliminarCoverOrdinador() -> void:
	cartaCover.visible = false


#############################################################
#							BARALLA							#
#############################################################

func creaBaralla() -> void:
	baralla = baralla_scene.instantiate()
	baralla.barallar()
	mostrarBaralla()

func borrarBaralla() -> void:
	remove_child(baralla)
	
func mostrarBaralla() -> void:
	add_child(baralla)
	baralla.position = Vector2(200, 80)
	tapaCartaBaralla()

func tapaCartaBaralla() -> void:
	#cartaCoverBaralla.set_imatge("res://assets/KINCards/" + trasera)
	add_child(cartaCoverBaralla)
	cartaCoverBaralla.position = Vector2(200,80)

func mostrarCoverBaralla() -> void:
	cartaCoverBaralla.visible = true

func eliminarCoverBaralla() -> void:
	#remove_child(cartaCoverBaralla)
	cartaCoverBaralla.visible = false

func referBaralla() -> void:
		
		# Guardam quantes cartes hi ha als descarts
		numCartes = maDescarts.size()
		
		#Cream la baralla amb les cartes descartades
		baralla.afegirCartes(maDescarts)
		# Escapçam totes les cartes
		baralla.barallar()
		#Feim visibles totes les cartes
		for c in baralla.get_cartes():
			c.position = Vector2(200, 80)
			c.visible = true
		#Posam la carta a sobre
		
		#Netejam les cartes descartades
		maDescarts.clear()
		
		#Afegim la cover de la baralla
		await get_tree().create_timer(1.0).timeout
		mostrarCoverBaralla()


#############################################################
#						COLLIR CARTES						#
#############################################################


func collirCartaJugador() -> void:
	var carta: Carta
	carta = baralla.collir()
	
	var offset = Vector2(30, 0)  # Distància entre les cartes
	
	carta.position = posicioJugador + offset * maJugador.size()
	
	maJugador.push_back(carta)
	var numStr: String = carta.get_numero()
	var num: int = valors.find(numStr)
	var pes: int = pesos[num]
	
	scoreJugador += pes
	$scoreJugador.text = "Punts Jugador: " + str(scoreJugador)
	
	numCartes -= 1
	
	if scoreJugador > 21:
		_on_passar_pressed()
	
	
func collirCartaOrdinador() -> void:
	var carta: Carta
	carta = baralla.collir()
	
	var offset = Vector2(30, 0)  # Distància entre les cartes
	
	carta.position = posicioOrdinador + offset * maOrdinador.size()
	
	maOrdinador.push_back(carta)
	var numStr: String = carta.get_numero()
	var num: int = valors.find(numStr)
	var pes: int = pesos[num]
	
	#Si toca un AS i ens passam de 21 amb un 11, el posam a 1
	if pes == 11:
		if scoreOrdinador + pes > 21:
			pes = 1
	
	#Si l'ordinador té un AS i se passa de 21, canviam el valor de 11 a 1	
	#Això té una errada. Si hi ha més d'un AS pot ser que no ho comptem correctament
	#TODO	
	if scoreOrdinador > 21:
		for c:Carta in maOrdinador:
			if c.get_numero() == "ACE":
				scoreOrdinador -= 10
	
	scoreOrdinador += pes
	
	numCartes -= 1
	
func repartir() -> void:
	#Primer collim una carta pel jugador
	collirCartaJugador()
	
func borrarCartes() -> void:
	for c in maJugador:
		c.visible = false
	
	for c in maOrdinador:
		c.visible = false

#################################################################
# 						Gestió dels botons						#
#################################################################

func _on_collir_pressed():
	if numCartes > 4:
		if maJugador.size() == 0:
			collirCartaJugador()
			collirCartaOrdinador()
			collirCartaJugador()
			collirCartaOrdinador()
			tapaCartaOrdinador()
		else:
			collirCartaJugador()
	else:
		if maJugador.size() == 0:
			match numCartes:
				4:
					collirCartaJugador()
					collirCartaOrdinador()
					collirCartaJugador()
					collirCartaOrdinador()
					eliminarCoverBaralla()
					referBaralla()
				3:
					collirCartaJugador()
					collirCartaOrdinador()
					collirCartaJugador()
					eliminarCoverBaralla()
					referBaralla()
					collirCartaOrdinador()
				2:
					collirCartaJugador()
					collirCartaOrdinador()
					eliminarCoverBaralla()
					referBaralla()
					collirCartaJugador()
					collirCartaOrdinador()
				1:
					collirCartaJugador()
					eliminarCoverBaralla()
					referBaralla()
					collirCartaOrdinador()
					collirCartaJugador()
					collirCartaOrdinador()
		elif numCartes == 1:
			# Hem de collir els descarts, escapçar-los i tornar-los a ficar a la baralla
			collirCartaJugador()
			referBaralla()
		else:
			collirCartaJugador()
		
func _on_passar_pressed() -> void:
	fiJugador = true
	$passar.disabled = true

func _on_doblar_pressed():
	if credits - aposta > 0:
		aposta += 2
		collirCartaJugador()
		fiJugador = true
		$aposta.text = "Aposta: " + str(aposta) + "€"
	else:
		print("No té prou crèdit")
	
func _on_nou_joc_pressed():
	scoreJugador = 0
	scoreOrdinador = 0
	aposta = 2
	$scoreJugador.text = "Punts Jugador: " + str(scoreJugador)
	$scoreOrdinador.text =  "Punts Ordinador: " + str(scoreOrdinador)
	$aposta.text = "Aposta: " + str(aposta) + "€"
	$ncartes.text = "Cartes restants: " + str(numCartes)
	
	#Guardam totes les cartes jugades
	maDescarts.append_array(maJugador)
	maDescarts.append_array(maOrdinador)
		
	borrarCartes()
	
	maJugador = []
	maOrdinador = []
	
	fiJugador = false
	fiPartida = false
	
	$collir.disabled = false
	$passar.disabled = false
	$doblar.disabled = false
	$nouJoc.disabled = true
	$nouJoc.visible = false
	
	set_process(true)


