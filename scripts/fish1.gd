extends Node2D

@export var min_speed = 80
@export var max_speed = 120
@export var min_angular_speed = 0.75
@export var max_angular_speed = 1.0

var direction: Vector2 = Vector2.UP
var targetP: Vector2 = Vector2.ZERO
var targetV: Vector2 = Vector2.ZERO
var angle: float = 0
var angular_speed: float = 0
var speed: float = 0
var timer: float = 0

@onready var HEIGHT = get_viewport().get_visible_rect().size.y
@onready var WIDTH = get_viewport().get_visible_rect().size.x

func _ready() -> void:
	direction = Vector2.from_angle(randf() * 2 * PI).normalized()
func _process(delta: float) -> void:
	queue_redraw()
	angular_speed = randf_range(min_angular_speed, max_angular_speed)
	speed = randf_range(min_speed, max_speed)
	targetV = (targetP - position).normalized()
	angle = direction.angle_to(targetV)

	if abs((position-targetP).length()) < 3:
		timer = randf_range(3.0, 6.0)
		targetP = Vector2(randi_range(-320, 320), randi_range(-180, 180))
		print("new target point reached")
	elif abs(angle) > 0.05 and timer > 0:
		# Rotate toward target, preserving sign so it turns the right way
		direction = direction.rotated(sign(angle) * angular_speed * delta)
	elif timer < 0:
		timer = randf_range(3.0, 6.0)
		targetP = Vector2(randi_range(-320, 320), randi_range(-180, 180))
		print("new target time out")

	timer -= delta
	position += direction.normalized() * speed * delta
	position.x = clamp(position.x, -WIDTH/2, WIDTH/2)
	position.y = clamp(position.y, -HEIGHT/2, HEIGHT/2)

func _draw() -> void:
	draw_line(Vector2.ZERO, direction.normalized() * 100, Color.RED, 1.0)
	draw_circle(targetP - position, 5, Color.RED)
