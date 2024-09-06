extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$scoreJugador.text = "Jugador: " + str(Global.scoreJugador)
	$scoreOrdinador.text =  "Ordinador: " + str(Global.scoreOrdinador)
	$credit.text = str(Global.credits)
	$aposta.text = "Aposta: " + str(Global.aposta)
	$ncartes.text = "Cartes: " + str(Global.numCartes)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$scoreJugador.text = "Jugador: " + str(Global.scoreJugador)
	if Global.fiJugador:
		$scoreOrdinador.text =  "Ordinador: " + str(Global.scoreOrdinador)
	else: 
		$scoreOrdinador.text =  "Ordinador: 0"
	$credit.text = str(Global.credits)
	$aposta.text = "Aposta: " + str(Global.aposta)
	$ncartes.text = "Cartes: " + str(Global.numCartes)



