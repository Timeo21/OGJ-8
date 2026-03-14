extends Node2D

@export var speed_angular = 1.0
@export var speed = 2.0
var dir = Vector2.RIGHT
var time_elapsed =0
@onready var animation : AnimatedSprite2D = $Area2D/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir = dir.rotated(randf_range(-180,180)/(180*PI) * speed_angular)
	animation.play();
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_sprite()
		#print("generated a new point.")
		#dir = Vector2.from_angle(randi_range(0,360))
		#print(point)
	#dwprint(speed)
	time_elapsed += delta
	if (time_elapsed > 0.5):
		dir = dir.rotated(randf_range(-360,360)/(180*PI) * speed_angular * delta)
		time_elapsed =0
	position += dir.normalized() *speed *delta
	if (position.x < -320):
		dir = (dir.normalized() + Vector2.RIGHT).normalized() 
	elif (position.x>320):
		dir = (dir.normalized() + Vector2.LEFT).normalized()
	elif (position.y >180):
		dir = (dir.normalized() + Vector2.UP).normalized()
	elif (position.y < -180):
		dir = (dir.normalized() + Vector2.DOWN).normalized()
	pass
func handle_sprite() -> void:
	if (dir.x < 0.2):
		animation.flip_h = true
	elif (dir.x > 0.2):
		animation.flip_h = false
		
	
