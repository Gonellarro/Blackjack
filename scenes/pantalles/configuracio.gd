extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_tornar_pressed():
	get_tree().change_scene_to_file("res://scenes/pantalles/menu.tscn")

func _on_b_1_pressed():
	Global.numBaralles = 1

func _on_b_2_pressed():
	Global.numBaralles = 2

func _on_b_3_pressed():
	Global.numBaralles = 3

func _on_b_4_pressed():
	Global.numBaralles = 4

func _on_c_10_pressed():
	Global.creditsInicials = 10

func _on_c_20_pressed():
	Global.creditsInicials = 20

func _on_c_30_pressed():
	Global.creditsInicials = 30
