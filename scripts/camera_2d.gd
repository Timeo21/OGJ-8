extends Camera2D

@onready var menu_pos: Vector2
@onready var game_pos: Vector2

var target: Vector2
var time: float
var timer: float
var current: Vector2

signal on_reach_game_pos
signal on_reach_menu_pos

func _ready() -> void:
	var marker: Marker2D = %CameraMenu
	menu_pos = marker.position
	marker = %CameraGame
	game_pos = marker.position
	current = menu_pos
	position = menu_pos
	pass
	
func _process(delta: float) -> void:
	if time == 0:
		return
	elif timer >= time:
		timer = time
		position = lerp(current, target, timer/time)
		current = position
		if target == game_pos:
			on_reach_game_pos.emit()
		elif target == menu_pos:
			on_reach_menu_pos.emit()
		time = 0
	else:
		position = lerp(current, target, timer/time)
		
	timer += delta
	pass

func move_to(pos: int, time: float) -> void:
	self.time = time
	timer = 0
	match pos:
		0: target = menu_pos
		1: target = game_pos
		_: target = menu_pos
	pass

func _on_button_pressed() -> void:
	move_to(1,3)
	pass
