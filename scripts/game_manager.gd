class_name GameManager
extends Node

var main_scene: Resource = load("res://scenes/main.tscn")
@onready var button: Button = $VBoxContainer/Button

func _ready() -> void:
	InputMapSaver.load_input_map()
	button.grab_focus()
	pass

func _process(delta: float) -> void:
	pass

func _on_quit_game_pressed():
	get_tree().quit()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("settings")):
		TransitionPlayer.change_scene("res://scenes/settings.tscn")

func _on_button_pressed() -> void:
	TransitionPlayer.change_scene("res://scenes/maison.tscn")
