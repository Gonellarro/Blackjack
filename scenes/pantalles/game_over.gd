extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#$jugades.text = "Partides: " + str(Global.jugades)
	#$jugadesGuanyades.text = "Guanyades: " + str(Global.numJugadesGuanyades)
	#$jugadesEmpatades.text = "Empatades: " + str(Global.numJugadesEmpats)
	#var perdudes: int = Global.jugades - Global.numJugadesEmpats - Global.numJugadesGuanyades
	#$JugadesPerdudes.text = "Perdudes: " + str(perdudes)
	#$blackjack.text = "BlackJacks: " + str(Global.numBlackJacks)
	#$guanys.text = "Màx creds: " + str(Global.maxim)	
	pass
	
func _on_reiniciar_pressed():
	Global.jugades = 0
	Global.numJugadesGuanyades = 0
	Global.numJugadesEmpats = 0
	Global.numBlackJacks = 0 
	Global.maxim = 0
	
	get_tree().change_scene_to_file("res://scenes/joc/joc.tscn")

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/pantalles/menu.tscn")
	
func _on_grafiques_pressed():
	get_tree().change_scene_to_file("res://scenes/pantalles/grafica.tscn")
