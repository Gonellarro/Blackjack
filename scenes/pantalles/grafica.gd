extends Node2D

const MAXX = 380
const MINX = 100
const MINY = 150
const MAXY = 350

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	pass
	
func _draw():
	
	if (Global.creditsHist.size() > 0):
		
		# Pintam els eixos	
		draw_line(Vector2(MINX, MAXY), Vector2(MAXX, MAXY), Color.GREEN, 1.5 )
		draw_line(Vector2(MINX, MAXY), Vector2(MINX, MINY), Color.GREEN, 1.5)
		
		# Nombre de Jugada
		var currentStep: int = 0
		
		# Distància entre jugades
		var xstep: int = int((MAXX-MINX)/Global.creditsHist.size())
		
		# Calculam el màxim de crèdits guanyats per normalitzar la gràfica
		var maximCredit: int = 0
		for cr:int in Global.creditsHist:
			if cr > maximCredit:
				maximCredit = cr
				
		if maximCredit < Global.creditsInicials:
			maximCredit = Global.creditsInicials
		
		# Feim sempre que només hi hagi 10 divisions en vertical
		var ystep: int = int(int(maximCredit)/10)
		
		# Alçada real de la gràfica
		var relacioAltura: int = MAXY-MINY
		
		# Posició del primer valor, que sempre són els crèdits inicials
		var relacioValor: float = float(Global.creditsInicials)/maximCredit
		# Càlcul de la posició en X i Y
		var vectorAnterior: Vector2 = Vector2(MINX,MAXY-(int(float(relacioAltura*relacioValor))))
		# Pintam un cercle al lloc
		draw_circle(vectorAnterior, 2.0, Color.BLUE)
		
		# Pintam les divisions de l'eix y
		for y in range(MINY, MAXY, (MAXY - MINY)/10):
			# Pintam les passes en y
			draw_line(Vector2(MINX - 10, y), Vector2(MINX + 10 , y), Color.GREEN, 1.5)
		
		# Començam a iterar per totes les jugades
		for cr in Global.creditsHist:
			currentStep += 1
			# Pintam les divisions en x
			draw_line(Vector2(MINX + (currentStep * xstep), MAXY + 10), Vector2(MINX + (currentStep * xstep), MAXY -10), Color.GREEN, 1.5)
			
			# Pintam els crèdits
			
			# Calculam el valor relatiu del punt
			relacioValor = float(cr)/maximCredit
			# Dibuixam la línea del punt anterior a l'actual dins la gràfica
			draw_line(vectorAnterior, Vector2(MINX + (currentStep * xstep), MAXY- (int(relacioAltura*relacioValor))), Color.RED, 3.0)
			# Dibuixam el circle del punt
			draw_circle(Vector2(MINX + (currentStep * xstep), MAXY-(int(relacioAltura*relacioValor))), 2.0, Color.BLUE)
			# Assignam al valor anterior el valor actual per la propera iteració
			vectorAnterior = Vector2(MINX + (currentStep * xstep), MAXY-(int(relacioAltura*relacioValor)))
			
			# Pintam els BJ: TODO
			#if currentStep < Global.blackJackHist.size() :
				#if Global.blackJackHist[currentStep-1] == "1":
					#draw_line(Vector2(MINX + (currentStep * xstep), MAXY - 10), Vector2(MINX + (currentStep * xstep), MINY - 20), Color.BLUE_VIOLET, 3)				
	else:
		_on_tornar_pressed()
		
	# Pintam els valors 
	$jugades.text = str(Global.jugades)
	$jugadesGuanyades.text = str(Global.numJugadesGuanyades)
	$jugadesEmpatades.text = str(Global.numJugadesEmpats)
	var perdudes: int = Global.jugades - Global.numJugadesEmpats - Global.numJugadesGuanyades
	$JugadesPerdudes.text = str(perdudes)
	$blackjack.text = str(Global.numBlackJacks)
	$guanys.text = str(Global.maxim)

func _on_tornar_pressed():
	# Reiniciam els valors generals
	Global.jugades = 0
	Global.numJugadesGuanyades = 0
	Global.numJugadesEmpats = 0
	Global.numBlackJacks = 0 
	Global.maxim = 0
	
	Global.creditsHist = []
	get_tree().change_scene_to_file("res://scenes/pantalles/menu.tscn")
