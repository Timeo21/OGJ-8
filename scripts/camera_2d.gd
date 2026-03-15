extends Camera2D

@onready var menu_pos: Vector2
@onready var game_pos: Vector2

var target: Vector2
var time: float
var timer: float
var current: Vector2

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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right"):
		move_to(1,3)
	if event.is_action_pressed("up"):
		move_to(0,3)
