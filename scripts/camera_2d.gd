extends Camera2D

@onready var menu_pos: Vector2
@onready var game_pos: Vector2

var target: Vector2
var time: float

func _ready() -> void:
	var marker: Marker2D = %CameraMenu
	menu_pos = marker.position
	marker = %CameraGame
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
