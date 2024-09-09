extends Node2D

var coords_mouth= [
	[ 22.817, 81.100 ], [ 38.522, 82.740 ],
	[ 39.001, 90.887 ], [ 54.465, 92.204 ],
	[ 55.641, 84.260 ], [ 72.418, 84.177 ],
	[ 73.629, 92.158 ], [ 88.895, 90.923 ],
	[ 89.556, 82.673 ], [ 105.005, 81.100 ]
	]
var mouth : PackedVector2Array
var _mouth_width : float = 4.4

# Called when the node enters the scene tree for the first time.
func _ready():
	mouth = PackedVector2Array(coords_mouth);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _draw():
	var white : Color = Color.WHITE
	draw_polyline(mouth, white, _mouth_width)
