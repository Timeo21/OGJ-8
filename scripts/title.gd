extends Node

var main_scene: Resource = load("res://scenes/main.tscn")
@onready var button: Button = $VBoxContainer/Button

func _ready() -> void:
	button.pressed.connect(func() -> void:
		add_child(main_scene.instantiate())
	)
	pass

func _process(delta: float) -> void:
	pass
