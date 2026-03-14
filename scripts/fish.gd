extends Node2D

@export var speed = 10
var point = Vector2.ZERO
var dir = Vector2.RIGHT
var found_point = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!point or !dir or found_point == 1):
		#print("generated a new point.")
		#dir = Vector2.from_angle(randi_range(0,360))
		point = Vector2(((-1)^randi_range(0,1))*randi()%340,((-1)^randi_range(0,1))*randi()%180)
		found_point =0;
		#print(point)
	var t = point - position
	if abs(dir.angle_to(t)) > 0.5:
		dir = dir.rotated(randf_range(-360,360)/(180*PI))
		position += dir.normalized() 
	else:
		print("Found point")
		found_point =1
		
	pass
