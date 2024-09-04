extends TextureRect

class_name Baralla

var cartes: Array = []
const NUM_CARTES = 13
const NUM_PALS = 4
var valors = ["2","3","4","5","6","7","8","9","10","J","Q","K","ACE"]
var pals = ["Clubs","Diamonds","Hearts","Spades"]

func _init() -> void:
	var carta: Carta
	for p in range(NUM_PALS):
		for c in range(NUM_CARTES):
			carta = Carta.new(valors[c],pals[p])
			cartes.push_back(carta)
			
func _ready() -> void:
	mostrar()
	#pass
	
func barallar() -> void:
	print("Barallam")
	cartes.shuffle()

func borrar() -> void:
	for i in range(cartes.size()):
		var carta = cartes[i]
		remove_child(carta)  # Eliminam la carta de l'escena 
		carta.free()	# Eliminam la carta com a objecte
	
	cartes = []
		
func mostrar() -> void:
	for i in range(cartes.size()):
		var carta = cartes[i]
		add_child(carta)  # Agregar la carta a la escena como un nodo hijo

	# Cream una carta per a què tapi les altres
	#var cartaCover: Carta = Carta.new("ACE","Clubs")
	#cartaCover.set_imatge("res://assets/KINCards/Back_1.png")
	#add_child(cartaCover)
		
func collir() -> Carta:
	var cartaTMP: Carta = cartes.pop_front()
	return cartaTMP
	
func get_numCartes() -> int:
	return cartes.size()
	
func afegirCartes(cartesArray: Array) -> void:
	cartes.clear()
	cartes.append_array(cartesArray)
	
func get_cartes() -> Array:
	return cartes
	
		
	
	
