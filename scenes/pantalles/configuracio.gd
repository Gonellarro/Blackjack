extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$B1.toggle_mode = true
	$B2.toggle_mode = true
	$B3.toggle_mode = true
	$B4.toggle_mode = true
	
	if Global.numBaralles == 1:		
		$B1.button_pressed = true
	elif Global.numBaralles == 2:
		$B2.button_pressed = true
	elif Global.numBaralles == 3:
		$B3.button_pressed = true
	else:
		$B4.button_pressed = true

	$C10.toggle_mode = true
	$C20.toggle_mode = true
	$C30.toggle_mode = true
	
	if Global.creditsInicials == 10:
		$C10.button_pressed = true
	elif Global.creditsInicials == 20:
		$C20.button_pressed = true
	else:
		$C30.button_pressed = true
	
	$A2.toggle_mode = true
	$A4.toggle_mode = true
	$A8.toggle_mode = true
	
	if Global.aposta == 2:
		$A2.button_pressed = true
	elif Global.aposta == 4:
		$A4.button_pressed = true
	else:
		$A8.button_pressed = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_tornar_pressed():
	get_tree().change_scene_to_file("res://scenes/pantalles/menu.tscn")

func resetBotons(i: int) -> void:
	match i:
		1:
			$B1.button_pressed = false
			$B2.button_pressed = false
			$B3.button_pressed = false
			$B4.button_pressed = false
		
		2:
			$C10.button_pressed = false
			$C20.button_pressed = false
			$C30.button_pressed = false
			
		3:
			$A2.button_pressed = false
			$A4.button_pressed = false
			$A8.button_pressed = false

func _on_b_1_pressed():
	resetBotons(1)
	Global.numBaralles = 1
	$B1.button_pressed = true
	
func _on_b_2_pressed():
	resetBotons(1)
	Global.numBaralles = 2
	$B2.button_pressed = true

func _on_b_3_pressed():
	resetBotons(1)
	Global.numBaralles = 3
	$B3.button_pressed = true
	

func _on_b_4_pressed():
	resetBotons(1)
	Global.numBaralles = 4
	$B4.button_pressed = true

func _on_c_10_pressed():
	resetBotons(2)	
	Global.creditsInicials = 10
	$C10.button_pressed = true

func _on_c_20_pressed():
	resetBotons(2)
	Global.creditsInicials = 20
	$C20.button_pressed = true

func _on_c_30_pressed():
	resetBotons(2)
	Global.creditsInicials = 30
	$C30.button_pressed = true

func _on_a_2_pressed():
	resetBotons(3)	
	Global.aposta = 2
	$A2.button_pressed = true


func _on_a_4_pressed():
	resetBotons(3)
	Global.aposta = 4
	$A4.button_pressed = true
	
func _on_a_8_pressed():
	resetBotons(3)
	Global.aposta = 8
	$A8.button_pressed = true
