extends Node

var wave = preload("res://scenes/wave.tscn")

@export var max_time: float = 5
@export var min_time: float = 3
@export var enabled: bool = true

var timer: float = randf_range(min_time,max_time)
var waves: Array[Node2D]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not enabled:
		return
	timer -= delta
	if timer < 0:
		var new_wave = wave.instantiate()
		waves.append(new_wave)
	pass

func stop() -> void:
	enabled = false
	waves.all(queue_free)

func start() -> void:
	enabled = true
