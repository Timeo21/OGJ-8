extends AnimatedSprite2D

@export var min_time: float = 6.0
@export var max_time: float = 20.0

var timer = randf_range(min_time, max_time)
var enabled = true
	
func _process(delta: float) -> void:
	if not enabled:
		return
	timer -= delta
	if timer < 0:
		play()
		timer = randf_range(min_time, max_time)
	pass
