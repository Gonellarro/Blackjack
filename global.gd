extends Node

var numBaralles: int 
var credits: int
var creditsInicials: int
var scoreJugador: int
var scoreOrdinador: int
var numCartes: int
var aposta: int
var jugades: int
var fiJugador: bool
var numBlackJacks: int
var numJugadesGuanyades: int
var numJugadesEmpats: int
var maxim: int


func _ready():
	numBaralles = 1
	credits = 20
	creditsInicials = 20
	aposta = 2
	scoreJugador = 0
	scoreOrdinador = 0
	jugades = 0
	numCartes = 52 * numBaralles
	fiJugador = false
	numBlackJacks = 0
	numJugadesGuanyades = 0
	numJugadesEmpats = 0
	maxim = 0

