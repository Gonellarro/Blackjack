extends Control

@onready var musica_fons = $MusicaFons

# Called when the node enters the scene tree for the first time.
func _ready():	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_iniciar_pressed():
	get_tree().change_scene_to_file("res://scenes/joc/joc.tscn")


func _on_configurar_pressed():
	get_tree().change_scene_to_file("res://scenes/pantalles/configuracio.tscn")
