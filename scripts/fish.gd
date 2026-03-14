class_name Fish extends Node2D

@onready var area: Area2D = $Area2D
@onready var bar: ProgressBar = $ProgressBar

@export var capture_speed:float = 0.1
@export var decay_speed:float = -0.075

var capture_progress:float


func _ready() -> void:
	pass

func _process(delta: float) -> void:
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

func capture() -> void:
	queue_free()
	pass
