extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$scoreJugador.text = str(Global.scoreJugador)
	$scoreOrdinador.text =  str(Global.scoreOrdinador)
	$credit.text = str(Global.credits)
	$aposta.text = str(Global.aposta)
	$jugades.text = str(Global.jugades)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$scoreJugador.text = str(Global.scoreJugador)
	if Global.fiJugador:
		$scoreOrdinador.text = str(Global.scoreOrdinador)
	else: 
		$scoreOrdinador.text = "0"
	$credit.text = str(Global.credits)
	$aposta.text = str(Global.aposta)
	$jugades.text = str(Global.jugades)



