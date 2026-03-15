extends AnimatedSprite2D

@onready var line: AnimatedSprite2D = $Line

func _ready() -> void:
	line.visible = false
	play("default")
	pass # Replace with function body.


func _process(delta: float) -> void:
	if frame == 19:
		line.visible = true
		line.play("default")
	pass
