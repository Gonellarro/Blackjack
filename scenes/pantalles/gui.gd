extends CanvasLayer

var controlApostes: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$scoreJugador.text = str(Global.scoreJugador)
	$scoreOrdinador.text =  str(Global.scoreOrdinador)
	$credit.text = str(Global.credits)
	$aposta.text = str(Global.aposta)
	$jugades.text = str(Global.jugades)
	$numBJ.text = str(Global.numBlackJacks)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$scoreJugador.text = str(Global.scoreJugador)
	if Global.fiJugador:
		$scoreOrdinador.text = str(Global.scoreOrdinador)
	else: 
		$scoreOrdinador.text = "0"
	$credit.text = str(Global.credits)
	$aposta.text = str(Global.aposta)
	$jugades.text = str(Global.jugades)
	$numBJ.text = str(Global.numBlackJacks)
	
	if Global.scoreJugador != 0:
		controlApostes = true
	else:
		controlApostes = false
	
func _on_aposta_pressed():
	if !controlApostes:
		var apostes = [2,4,8]
		var index: int
		index = apostes.find(Global.aposta)
		if index + 1 < apostes.size():
			Global.aposta = apostes[index+1]
		else:
			Global.aposta = apostes[0]




