extends Fish

@export var speed_angular = 50.0
@export var speed = 100.0
var time_elapsed =0
@onready var animation : AnimatedSprite2D = $Area2D/AnimatedSprite2D
var future_position = Vector2.ZERO
var future_dir = Vector2.ZERO

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D




@onready var HEIGHT = get_viewport().get_visible_rect().size.y
@onready var WIDTH = get_viewport().get_visible_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	dir = dir.rotated(randf_range(-180,180)/(180*PI) * speed_angular)
	animation.play("default");
	future_position = position
	animation.animation_looped.connect(func ():
		#dir = dir.rotated(randf_range(-360,360)/(180*PI) * speed_angular * delta)
		dir = future_dir
		queue_redraw()
		position = future_position
		time_elapsed =0)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
		#dir = Vector2.from_angle(randi_range(0,360))
		#print(point)
	#dwprint(speed)
	time_elapsed += delta
	
	#if (time_elapsed > 3.0):
		#dir = dir.rotated(randf_range(-360,360)/(180*PI) * speed_angular * delta)
		#position = future_position
		##print(position)
		#time_elapsed =0
	future_dir = dir.rotated(randf_range(-360,360)/(180*PI) * speed_angular * delta)	
	
	
	if (future_position.x < top_left_pos.x +collision_shape_2d.shape.get_rect().size.x/2):
		future_dir = (future_dir.normalized() + Vector2.RIGHT).normalized() 
		#queue_redraw()
	elif (future_position.x>bot_right_pos.x - collision_shape_2d.shape.get_rect().size.x/2):
		future_dir = (future_dir.normalized() + Vector2.LEFT).normalized()
		#queue_redraw()
	elif (future_position.y >bot_right_pos.y- collision_shape_2d.shape.get_rect().size.y/2):
		future_dir = (future_dir.normalized() + Vector2.UP).normalized()
		#queue_redraw()
	elif (future_position.y < top_left_pos.y+ collision_shape_2d.shape.get_rect().size.y/2):
		future_dir = (future_dir.normalized() + Vector2.DOWN).normalized()
		#queue_redraw()
	future_position += future_dir.normalized() *speed *delta
	queue_redraw()
	pass
		
func _draw() -> void:
	if GameState.isItemOwned(Utils.ItemId.PREDICTION):
		#draw_line(Vector2.ZERO,  (future_dir.normalized() *100), Color.RED, 1.0)
		draw_circle(future_position-position, 5, Color.RED)
