class_name Fish extends Node2D

@onready var area: Area2D = $Area2D
@onready var bar: ProgressBar = $ProgressBar
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D

var top_left_pos: Vector2
var bot_right_pos: Vector2
var dir: Vector2 = Vector2.RIGHT

@export var capture_speed:float = 0.1
@export var decay_speed:float = -0.075
@export var fish_type: Utils.FishType

var capture_progress:float


func _ready() -> void:
	var dir: Directory = get_tree().get_root().get_node("Main/Directory")
	dir.fishes.push_back(self)
	var marker: Marker2D = dir.top_left_maker
	top_left_pos = marker.position
	marker = dir.bot_right_maker
	bot_right_pos = marker.position
	pass

func _process(delta: float) -> void:
	#print(capture_progress)
	if (area.has_overlapping_areas()):
		progress_bar(capture_speed*delta)
	else:
		progress_bar(decay_speed*delta)
	pass
	
func progress_bar(progress_unit: float) -> void:
	capture_progress += progress_unit
	if capture_progress >= 1:
		capture()
	capture_progress = clamp(capture_progress,0,1)
	bar.value = capture_progress
	position.x = clamp(position.x,top_left_pos.x, bot_right_pos.x)
	position.y = clamp(position.y,top_left_pos.y, bot_right_pos.y)
	
	if (position.x < top_left_pos.x +collision_shape.shape.get_rect().size.x/2):
		dir = (dir.normalized() + Vector2.RIGHT).normalized() 
	elif (position.x > bot_right_pos.x - collision_shape.shape.get_rect().size.x/2):
		dir = (dir.normalized() + Vector2.LEFT).normalized()
	elif (position.y > bot_right_pos.y- collision_shape.shape.get_rect().size.y/2):
		dir = (dir.normalized() + Vector2.UP).normalized()
	elif (position.y < top_left_pos.y+ collision_shape.shape.get_rect().size.y/2):
		dir = (dir.normalized() + Vector2.DOWN).normalized()

func capture() -> void:
	print("fish emitting capture")
	SignalBus.fish_caugth.emit(fish_type)
	queue_free()
	pass
	
