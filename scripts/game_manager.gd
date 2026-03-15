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
	TransitionPlayer.change_scene("res://scenes/main.tscn")
