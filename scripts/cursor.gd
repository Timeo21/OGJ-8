class_name Cursor
extends Area2D

enum Mode {MASH, KEEP}

var top_left_pos: Vector2
var bot_right_pos: Vector2

var closest_position = Vector2.DOWN *100000
var lowest_dist =100000.0
var time_spent =0
var aimbot_factor = 4.0


@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var dir: Directory = get_tree().get_root().get_node("Main/Directory")

@export var decel: float = 200
@export var boost_mash: float = 200
@export var boost_keep: float = 400
@onready var max_speed: float = get_max_speed()
@export var base_max_speed: float = 400
@export var fast_multiplier: float = 2
@export var speed: Vector2 = Vector2.ZERO
@export var mode: Mode = Mode.KEEP
@export var border_offset: float = 0



func _ready() -> void:
	
	var marker: Marker2D = %TopLeftMarker
	top_left_pos = marker.position
	marker = %BotRightMarker
	bot_right_pos = marker.position
	hook_bigger()
	mash()
	pass

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
	#print(collision_shape.shape.get_rect().size.x/2)
	position.x = clamp(position.x, top_left_pos.x + collision_shape.shape.get_rect().size.x/2,bot_right_pos.x - collision_shape.shape.get_rect().size.x/2)
	position.y = clamp(position.y, top_left_pos.y + collision_shape.shape.get_rect().size.y/2,bot_right_pos.y - collision_shape.shape.get_rect().size.y/2)
	
	# so that speed at botom is 0
	if ((position - prev_pos) / delta < Vector2(max_speed,max_speed)):
		speed = (position - prev_pos) / delta 
	
	time_spent +=delta
	if (time_spent >= 5):
		tp_to_closest()
		time_spent =0
	aimbot()
func get_max_speed() -> float:
	if GameState.isItemOwned(Utils.ItemId.FAST):
		return fast_multiplier*base_max_speed
	return base_max_speed
	
func tp_to_closest() -> void:
	if GameState.isItemOwned(Utils.ItemId.TP):
		for fishes in dir.fishes:
			if position.distance_to(fishes.position) < lowest_dist:
				closest_position = fishes.position
				lowest_dist =position.distance_to(fishes.position)
		position = closest_position
		speed = Vector2.ZERO
		closest_position = Vector2.DOWN *100000
		lowest_dist = 1000000.0
	pass
	
func hook_bigger() -> void:
	if GameState.isItemOwned(Utils.ItemId.BIGGER):
		scale*=2
		
func mash() -> void :
	if GameState.isItemOwned(Utils.ItemId.MASH):
			mode = Mode.MASH
	
func aimbot() -> void:
	if GameState.isItemOwned(Utils.ItemId.AIM):
		for fish in dir.fishes:
			if position.distance_to(fish.position) < lowest_dist:
				closest_position = fish.position
				lowest_dist =position.distance_to(fish.position)
		lowest_dist = 10000.0
		speed.x += position.direction_to(closest_position).x * aimbot_factor
		speed.y += position.direction_to(closest_position).y * aimbot_factor
		closest_position = Vector2.DOWN *100000
		
