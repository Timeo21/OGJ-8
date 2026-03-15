extends Fish

@export var speed_angular = 50.0
@onready var speed = get_speed()
@export var slow_multiplier: float = 0.5
@export var base_speed: float = 100.0
var time_elapsed =0
@onready var animation : AnimatedSprite2D = $Area2D/AnimatedSprite2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D




@onready var HEIGHT = get_viewport().get_visible_rect().size.y
@onready var WIDTH = get_viewport().get_visible_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	dir = dir.rotated(randf_range(-180,180)/(180*PI) * speed_angular)
	animation.play();
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	handle_sprite()
		#print("generated a new point.")
		#dir = Vector2.from_angle(randi_range(0,360))
		#print(point)
	#dwprint(speed)
	time_elapsed += delta
	if (time_elapsed > 2.0):
		dir = dir.rotated(randf_range(-360,360)/(180*PI) * speed_angular * delta)
		time_elapsed =0
	position += dir.normalized() *speed *delta
	pass
func handle_sprite() -> void:
	if (dir.x < 0.2):
		animation.flip_h = false
	elif (dir.x > 0.2):
		animation.flip_h = true
		
func get_speed() -> float:
	if GameState.isItemOwned(Utils.ItemId.SLOW):
		return slow_multiplier*base_speed
	return base_speed
