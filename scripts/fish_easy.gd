extends Fish

@export var min_speed = 80.0
@export var max_speed = 120.0
@export var min_angular_speed = 0.75
@export var max_angular_speed = 1.0

var targetP: Vector2 = Vector2.ZERO
var targetV: Vector2 = Vector2.ZERO
var angle: float = 0
var angular_speed: float = 0
var speed: float = 0
var timer: float = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $Area2D/AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D


var sprite_height
var sprite_width

func _ready() -> void:
	super._ready()
	dir = Vector2.from_angle(randf() * 2 * PI).normalized()
	animated_sprite_2d.play()
	sprite_height = collision_shape_2d.shape.get_rect().size.y
	sprite_width = collision_shape_2d.shape.get_rect().size.x
	
func _process(delta: float) -> void:
	super._process(delta)
	angular_speed = randf_range(min_angular_speed, max_angular_speed)
	speed = randf_range(min_speed, max_speed)
	targetV = (targetP - position).normalized()
	angle = dir.angle_to(targetV)
	
	if dir.x > 0:
		animated_sprite_2d.flip_h = false
	elif dir.x < 0:
		animated_sprite_2d.flip_h = true
	

	if abs((position-targetP).length()) < 3:
		timer = randf_range(3.0, 6.0)
		targetP = Vector2(randi_range(top_left_pos.x, bot_right_pos.x), randi_range(top_left_pos.y, bot_right_pos.y))
	elif abs(angle) > 0.05 and timer > 0:
		# Rotate toward target, preserving sign so it turns the right way
		dir = dir.rotated(sign(angle) * angular_speed * delta)
	elif timer < 0:
		timer = randf_range(3.0, 6.0)
		targetP = Vector2(randi_range(top_left_pos.x, bot_right_pos.x), randi_range(top_left_pos.y, bot_right_pos.y))

	timer -= delta
	position += dir.normalized() * speed * delta
#
#func _draw() -> void:
	#draw_line(Vector2.ZERO, direction.normalized() * 100, Color.RED, 1.0)
	#draw_circle(targetP - position, 5, Color.RED)
