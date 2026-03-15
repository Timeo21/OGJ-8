extends Fish

@export var speed_angular = 50.0
@export var speed = 100.0
var dir = Vector2.RIGHT
var time_elapsed =0
@onready var animation : AnimatedSprite2D = $Area2D/AnimatedSprite2D
var future_position = Vector2.ZERO

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D




@onready var HEIGHT = get_viewport().get_visible_rect().size.y
@onready var WIDTH = get_viewport().get_visible_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	dir = dir.rotated(randf_range(-180,180)/(180*PI) * speed_angular)
	animation.play();
	future_position = position
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
	if (time_elapsed > 3.0):
		dir = dir.rotated(randf_range(-360,360)/(180*PI) * speed_angular * delta)
		position = future_position
		#print(position)
		time_elapsed =0
	future_position += dir.normalized() *speed *delta
	if (future_position.x < 640 +collision_shape_2d.shape.get_rect().size.x/2):
		dir = (dir.normalized() + Vector2.RIGHT).normalized() 
	elif (future_position.x>640*2 - collision_shape_2d.shape.get_rect().size.x/2):
		dir = (dir.normalized() + Vector2.LEFT).normalized()
	elif (future_position.y >360*2- collision_shape_2d.shape.get_rect().size.y/2):
		dir = (dir.normalized() + Vector2.UP).normalized()
	elif (future_position.y < 360+ collision_shape_2d.shape.get_rect().size.y/2):
		dir = (dir.normalized() + Vector2.DOWN).normalized()
	pass
func handle_sprite() -> void:
	if (dir.x < 0.2):
		animation.flip_h = true
	elif (dir.x > 0.2):
		animation.flip_h = false
		
	
