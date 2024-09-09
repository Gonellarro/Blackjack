extends Node2D

@onready var musica_fons = $MusicaFons

var baralla: Baralla
var numBaralles: int
var maJugador : Array = []
var maOrdinador: Array = []
var maDescarts: Array = []

var scoreJugador: int
var scoreOrdinador: int

var posicioJugador = Vector2(100,550)
var posicioOrdinador = Vector2(100, 300)

var valors = ["2","3","4","5","6","7","8","9","10","J","Q","K","ACE","ASE"]
var pesos = [2,3,4,5,6,7,8,9,10,10,10,10,11,1]

var fiPartida: bool = false
var fiJugador: bool = false
var jugades: int

# Valor inicial dels diners del jugador
var credits: int

# Valor de l'aposta del jugador
var aposta: int
var apostaInicial: int

var fiDiners: bool = false

var cartaCover: Carta = Carta.new("ACE","Clubs")
var cartaCoverBaralla: Carta = Carta.new("ACE","Clubs")
var trasera: String

var numCartes: int


func inicialitzarVariables() -> void:
	$nouJoc.disabled = true
	$nouJoc.visible = false
	$nouJoc.text = ""
	
	$escapsa.disabled = true
	$escapsa.visible = false
	$escapsa.text = "Escapça!"
	
	numBaralles = Global.numBaralles
	credits = Global.creditsInicials
	Global.credits = credits
	Global.jugades = 0
	scoreJugador = Global.scoreJugador
	scoreOrdinador = Global.scoreOrdinador
	credits = Global.credits
	aposta = Global.aposta
	apostaInicial = Global.aposta
	jugades = Global.jugades
	Global.maxim = credits
	Global.numBlackJacks = 0
		
	numCartes = numBaralles * 52
	Global.numCartes = numCartes
	trasera = "Back_1.png"

	# Finalment assignam la imagte de la trassera a la carta de l'ordinador
	# La posam a l'escena, però la deixam oculta fins a que s'hagi de menester
	cartaCover.set_imatge("res://assets/Cards/" + trasera)
	cartaCoverBaralla.set_imatge("res://assets/Cards/" + trasera)
	cartaCover.position = Vector2(100,300)
	cartaCoverBaralla.position = Vector2(100, 100)
	cartaCover.visible = false
	cartaCover.top_level = true
	cartaCoverBaralla.visible = false
	cartaCoverBaralla.top_level = true
	add_child(cartaCover)
	add_child(cartaCoverBaralla)
	

func _ready() -> void:

	musica_fons.play()	
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
	if scoreJugador == 21:
		fiPartida = true
		fiJugador = true
	
	if fiJugador:
		
		#Llevam el cover de l'ordinador
		cartaCover.visible = false
		# No deixam cap botó disponible
		$collir.disabled = true
		$passar.disabled = true
		$doblar.disabled = true
		
		if scoreOrdinador > 16:
			fiPartida = true
			
		if (scoreJugador > 22 or fiJugador) and !fiPartida:
			tornOrdinador()
		
		if fiPartida:
			Global.blackJackHist.push_back("0")
			if scoreJugador == 21: 
				$nouJoc.text = "BlackJack"
				credits += aposta
				Global.numBlackJacks += 1
				Global.numJugadesGuanyades += 1
				Global.blackJackHist.pop_back()
				Global.blackJackHist.push_back("1")
			elif scoreOrdinador > 21:
				# Guanya el jugador
				$nouJoc.text = "Guanyes!"
				credits += aposta
				Global.numJugadesGuanyades += 1
			elif (scoreJugador == scoreOrdinador) and scoreJugador < 22:
				# Empats. Se tornen els dobers de l'aposta, per tant no feim res
				$nouJoc.text = "Empats"
				Global.numJugadesEmpats += 1
			elif (scoreJugador > scoreOrdinador) and scoreJugador < 22:
				# Guanya el jugador
				$nouJoc.text = "Guanyes!"
				credits += aposta
				Global.numJugadesGuanyades += 1
			else:
				# Guanya l'ordinador
				$nouJoc.text = "Perds..."
				credits -= aposta
				if credits < 1:
					$nouJoc.text = "Game Over"
					
					
			Global.scoreJugador = scoreJugador
			Global.scoreOrdinador = scoreOrdinador
			
			Global.credits = credits
			
			Global.creditsHist.push_back(credits)
			
			Global.jugades += 1
			
			aposta = apostaInicial
			Global.aposta = apostaInicial

			$nouJoc.disabled = false
			$nouJoc.visible = true
			
			# Guardam els màxims guanys
			if credits > Global.maxim:
				Global.maxim = credits
			
			fiPartida = false
				
			set_process(false)

func tornOrdinador() -> void:
	if numCartes > 1:
		if scoreJugador < 22:
			collirCartaOrdinador()
		else:
			fiPartida = true
	else:
		# Hem de collir els descarts, escapçar-los i tornar-los a ficar a la baralla
		collirCartaOrdinador()
		referBaralla()
		
func tapaCartaOrdinador() -> void:
		# Cream una carta per a què tapi les altres de la ma de l'ordinador
	add_child(cartaCover)
	cartaCover.visible = true

#func eliminarCoverOrdinador() -> void:
	#cartaCover.visible = false


#############################################################
#							BARALLA							#
#############################################################

func creaBaralla() -> void:

	baralla = Baralla.new(numBaralles)	
	# Mostram la baralla
	add_child(baralla)
	# Posam la carta per cobrir la baralla
	cartaCoverBaralla.visible = true

func referBaralla() -> void:
		# Eliminam la cover de la baralla
		cartaCoverBaralla.visible = false
		
		$escapsa.visible = true
		$escapsa.disabled = false
		$collir.disabled = true
		$passar.disabled = true
		$doblar.disabled = true
		set_process(false)
		#await get_tree().create_timer(1).timeout
		# Guardam quantes cartes hi ha als descarts
		numCartes = maDescarts.size()
		# Llevam tots els ASE que hem posat
		revisaASE()
		#Cream la baralla amb les cartes descartades
		baralla.renovarCartes(maDescarts)
		# Escapçam totes les cartes
		baralla.barallar()
		#Feim visibles totes les cartes
		for c in baralla.get_cartes():
			c.visible = true
		
		#Netejam les cartes descartades
		maDescarts.clear()
		
func revisaASE() -> void:
	for c:Carta in maDescarts:
		if c.get_numero() == "ASE":
			c.set_numero("ACE")	
	
#############################################################
#						COLLIR CARTES						#
#############################################################

func collirCartaJugador() -> void:
	var cartaTMP: Carta
	cartaTMP = baralla.collir()
	cartaTMP.visible = true
	add_child(cartaTMP)
	
	var offset = Vector2(30, 0)  # Distància entre les cartes
	
	cartaTMP.position = posicioJugador + offset * maJugador.size()
	
	maJugador.push_back(cartaTMP)
	var numStr: String = cartaTMP.get_numero()
	var num: int = valors.find(numStr)
	var pes: int = pesos[num]
	
	# Si toca un AS i ens passam de 21 amb un 11, el posam a 1
	if pes == 11:
		if scoreJugador + pes > 21:
			cartaTMP.set_numero("ASE")
			pes = 1
			
	# Si fins ara hem emprat l'As com 11, però ens passam, el canviam per un 1
	if scoreJugador + pes > 21:
		for c:Carta in maJugador:			
			if c.get_numero() == "ACE":
				scoreJugador -= 10
				c.set_numero("ASE")
	
	scoreJugador += pes
	Global.scoreJugador = scoreJugador
	#$scoreJugador.text = "Jugador: " + str(scoreJugador)
	
	numCartes -= 1
		
	if scoreJugador > 21:
		_on_passar_pressed()
	
func collirCartaOrdinador() -> void:
	var cartaTMP: Carta
	cartaTMP = baralla.collir()
	cartaTMP.visible = true
	add_child(cartaTMP)
	
	var offset = Vector2(30, 0)  # Distància entre les cartes
	
	cartaTMP.position = posicioOrdinador + offset * maOrdinador.size()
	
	maOrdinador.push_back(cartaTMP)
	var numStr: String = cartaTMP.get_numero()
	var num: int = valors.find(numStr)
	var pes: int = pesos[num]
	
	#Si toca un AS i ens passam de 21 amb un 11, el posam a 1
	if pes == 11:
		if scoreOrdinador + pes > 21:
			cartaTMP.set_numero("ASE")
			pes = 1
	
	# Si fins ara hem emprat l'As com 11, però ens passam, el canviam per un 1	
	if scoreOrdinador + pes > 21:
		for c:Carta in maOrdinador:
			if c.get_numero() == "ACE":
				scoreOrdinador -= 10
				c.set_numero("ASE")
				
	scoreOrdinador += pes
	Global.scoreOrdinador = scoreOrdinador
	
	numCartes -= 1
	
func repartir() -> void:
	#Primer collim una carta pel jugador
	collirCartaJugador()
	
func borrarCartes() -> void:
	for c: Carta in maJugador:
		c.visible = false
		remove_child(c)
	
	for c in maOrdinador:
		c.visible = false
		remove_child(c)
		
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
			cartaCover.visible = true
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
				
					referBaralla()
				3:
					collirCartaJugador()
					collirCartaOrdinador()
					collirCartaJugador()

					referBaralla()					
					collirCartaOrdinador()
				2:
					collirCartaJugador()
					collirCartaOrdinador()

					referBaralla()
					collirCartaJugador()
					collirCartaOrdinador()
				1:
					collirCartaJugador()

					referBaralla()
					collirCartaOrdinador()
					collirCartaJugador()
					collirCartaOrdinador()
					
			cartaCover.visible = true
		elif numCartes == 1:
			collirCartaJugador()

			referBaralla()
		else:
			collirCartaJugador()
			
func _on_passar_pressed() -> void:
	fiJugador = true
	aposta = Global.aposta
	Global.fiJugador = true
	$passar.disabled = true

func _on_doblar_pressed():
	if credits - (2*aposta) > 0:
		aposta = 2 * aposta
		collirCartaJugador()
		fiJugador = true
		Global.fiJugador = true
		Global.aposta = aposta
	else:
		print("No té prou crèdit")
	
func _on_nou_joc_pressed():
	
	scoreJugador = 0
	scoreOrdinador = 0
	aposta = apostaInicial
	Global.scoreJugador = 0
	Global.scoreOrdinador = 0
	Global.aposta = apostaInicial

	Global.numCartes = numCartes
	
	#Guardam totes les cartes jugades
	maDescarts.append_array(maJugador)
	maDescarts.append_array(maOrdinador)
	
	borrarCartes()
	
	maJugador = []
	maOrdinador = []
	
	fiJugador = false
	Global.fiJugador = false
	fiPartida = false
	
	$collir.disabled = false
	$passar.disabled = false
	$doblar.disabled = false
	$nouJoc.disabled = true
	$nouJoc.visible = false
		
	set_process(true)
	
	if credits < 1:
		get_tree().change_scene_to_file("res://scenes/pantalles/game_over.tscn")

func _on_escapsa_pressed():
	$escapsa.visible = false
	$collir.disabled = false
	$passar.disabled = false
	$doblar.disabled = false
	if !cartaCoverBaralla.visible:
		cartaCoverBaralla.visible = true
	set_process(true)

func _on_sortir_pressed():
	credits = 0 
	_on_nou_joc_pressed()
