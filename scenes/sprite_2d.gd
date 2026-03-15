extends Sprite2D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

@onready var panel: Panel = $Panel
@onready var panel_2: Panel = $Panel2
@onready var panel_3: Panel = $Panel3
@onready var panel_4: Panel = $Panel4
@onready var panel_5: Panel = $Panel5
@onready var panel_6: Panel = $Panel6
@onready var panel_7: Panel = $Panel7

var timer: float
var timer1: float

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if GameState.day_counter == 0:
		panel.visible = true 
		timer = delta + timer
		print(timer)
		if timer >= 4:
			timer1 = delta + timer1
			panel.visible = false
			panel_2.visible = true
			if timer1 >= 5 :
				panel_2.visible = false
				panel_3.visible = true
				if timer1 >= 9 :
					get_tree().change_scene_to_file("res://scenes/main.tscn")
	if GameState.day_counter == 1:
		panel_4.visible = true
		timer = delta + timer 
		if timer >= 4:
			timer1 = delta + timer1
			panel_4.visible = false
			panel_5.visible = true
			if timer1 >= 4:
				get_tree().change_scene_to_file("res://scenes/main.tscn")
	if GameState.day_counter == 2:
		timer = delta + timer
		panel_6.visible = true
		if timer >= 5:
			panel_6.visible = false
			panel_7.visible = true
			timer1 = delta + timer 
			if timer >= 9:
				get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass
