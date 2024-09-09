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
		#Calculam quin és el salt en X
		var currentStep: int = 0
		var xstep: int = int((MAXX-MINX)/Global.creditsHist.size())
		var maximCredit: int = 0
		for cr:int in Global.creditsHist:
			if cr > maximCredit:
				maximCredit = cr
		
		var ystep: int = int((MAXY-MINY)/int(maximCredit))
		
		var vectorAnterior: Vector2 = Vector2(MINX, MAXY - (int(Global.creditsInicials) * ystep))
	
		draw_line(Vector2(MINX, MAXY), Vector2(MAXX, MAXY), Color.GREEN, 1.5 )
		draw_line(Vector2(MINX, MAXY), Vector2(MINX, MINY), Color.GREEN, 1.5)
	
		draw_circle(vectorAnterior, 2.0, Color.BLUE)
		
		for y in range(MINY, MAXY, ystep*2):
			# Pintam les passes en y
			draw_line(Vector2(MINX - 10, y), Vector2(MINX + 10 , y), Color.GREEN, 1.5)
		
		for cr in Global.creditsHist:
			currentStep += 1
			# Pintam les passes en x
			draw_line(Vector2(MINX + (currentStep * xstep), MAXY + 10), Vector2(MINX + (currentStep * xstep), MAXY -10), Color.GREEN, 1.5)
			
			# Pintam els crèdits
			draw_line(vectorAnterior, Vector2(MINX + (currentStep * xstep), MAXY - (cr * ystep)), Color.RED, 3.0)
			draw_circle(Vector2(MINX + (currentStep * xstep), MAXY - (cr * ystep)), 2.0, Color.BLUE)
			vectorAnterior = Vector2(MINX + (currentStep * xstep), MAXY - (cr * ystep))
			
			# Pintam els BJ: TODO
			#if currentStep < Global.blackJackHist.size() :
				#if Global.blackJackHist[currentStep-1] == "1":
					#draw_line(Vector2(MINX + (currentStep * xstep), MAXY - 10), Vector2(MINX + (currentStep * xstep), MINY - 20), Color.BLUE_VIOLET, 3)				
	else:
		_on_tornar_pressed()
		
	
	$jugades.text = "Partides: " + str(Global.jugades)
	$jugadesGuanyades.text = "Guanyades: " + str(Global.numJugadesGuanyades)
	$jugadesEmpatades.text = "Empatades: " + str(Global.numJugadesEmpats)
	var perdudes: int = Global.jugades - Global.numJugadesEmpats - Global.numJugadesGuanyades
	$JugadesPerdudes.text = "Perdudes: " + str(perdudes)
	$blackjack.text = "BlackJacks: " + str(Global.numBlackJacks)
	$guanys.text = "Màx creds: " + str(Global.maxim)

func _on_tornar_pressed():
	Global.jugades = 0
	Global.numJugadesGuanyades = 0
	Global.numJugadesEmpats = 0
	Global.numBlackJacks = 0 
	Global.maxim = 0
	
	Global.creditsHist = []
	get_tree().change_scene_to_file("res://scenes/pantalles/menu.tscn")
