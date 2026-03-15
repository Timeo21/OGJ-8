class_name GameManager
extends Node

var main_scene: Resource = load("res://scenes/main.tscn")
@onready var button: Button = $VBoxContainer/Button

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_quit_game_pressed():
	get_tree().quit()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
