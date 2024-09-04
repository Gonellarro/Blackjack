extends TextureRect

class_name Carta

var numero: String
var pal: String
var imatge: Texture2D
var escala: Vector2

func _init(n: String, p: String) -> void:
	numero = n
	pal = p
	imatge = load("res://assets/KINCards/" + p + "_" + numero + ".png")
	escala = Vector2 (2.5,2.5)
	
func _ready() -> void:
	texture = imatge
	scale = escala
			
func get_imatge() -> Texture2D:
	return imatge
	
func get_numero() -> String:
	return numero
	
func get_pal() -> String:
	return pal
	
func set_escala(s: Vector2) -> void:
	self.scale = s
	
func set_imatge(img: String) -> void:
	self.imatge = load(img)

