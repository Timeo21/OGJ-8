class_name Cursor
extends Area2D

enum Mode {MASH, KEEP}

@onready var HEIGHT = get_viewport().get_visible_rect().size.y
@onready var WIDTH = get_viewport().get_visible_rect().size.x

@export var mul: float = 2
@export var decel: float = 200
@export var boost_mash: float = 200
@export var boost_keep: float = 400
@export var max_speed: float = 400
@export var speed: Vector2 = Vector2.ZERO
@export var mode: Mode = Mode.KEEP
@export var border_offset: float = 0

func _input(event: InputEvent) -> void:
	if mode == Mode.MASH:
		if event.is_action_pressed("right"):
			speed.x += boost_mash
		if event.is_action_pressed("up"):
			speed.y -= boost_mash

func _physics_process(delta: float) -> void:
	if mode == Mode.KEEP:
		if Input.is_action_pressed("right"):
			speed.x += boost_keep*delta
		if Input.is_action_pressed("up"):
			speed.y -= boost_keep*delta
			
	
	speed.x -= decel*delta
	speed.y += decel*delta
	speed.x = clamp(speed.x, -max_speed, max_speed)
	speed.y = clamp(speed.y, -max_speed, max_speed)
	
	var prev_pos: Vector2 = position
	position += speed*delta
	position.x = clamp(position.x, -WIDTH/2 - border_offset, WIDTH/2 - border_offset)
	position.y = clamp(position.y, -HEIGHT/2 - border_offset, HEIGHT/2 - border_offset)
	
	# so that speed at botom is 0
	speed = (position - prev_pos) / delta 
