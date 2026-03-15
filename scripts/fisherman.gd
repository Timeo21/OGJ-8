extends AnimatedSprite2D

@onready var line: AnimatedSprite2D = $Line

@export var title: bool = false 

func _ready() -> void:
	line.visible = false
	if title: 
		play("Title_Animation")
	else: 
		play("default")


func _process(delta: float) -> void:
	if frame == 19:
		line.visible = true
		line.play("default")
	pass
