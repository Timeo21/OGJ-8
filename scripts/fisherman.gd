class_name Fisherman
extends AnimatedSprite2D

@onready var line: AnimatedSprite2D = $Line

@export var title: bool = false 

func _ready() -> void:
	line.visible = false
	if title: 
		play("Title_Animation")


func _process(delta: float) -> void:
	if frame == 19:
		line.visible = true
		line.play("default")
	pass

func throw_line() -> void:
	play("default")


func _on_button_pressed() -> void:
	throw_line()
	pass
