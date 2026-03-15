extends Sprite2D

@onready var sprite_2d_2: Sprite2D = $"../Sprite2D2"

@onready var panel: Panel = $Panel
@onready var panel_2: Panel = $Panel2
@onready var panel_3: Panel = $Panel3
@onready var panel_4: Panel = $Panel4
@onready var panel_5: Panel = $Panel5
@onready var panel_6: Panel = $Panel6
@onready var panel_7: Panel = $Panel7
@onready var panel_8: Panel = $Panel8
@onready var panel_9: Panel = $Panel9
@onready var panel_10: Panel = $Panel10
@onready var panel_11: Panel = $Panel11

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
					TransitionPlayer.change_scene("res://scenes/main.tscn")
	if GameState.day_counter == 1:
		panel_4.visible = true
		timer = delta + timer 
		if timer >= 4:
			timer1 = delta + timer1
			panel_4.visible = false
			panel_5.visible = true
			if timer1 >= 4:
				TransitionPlayer.change_scene("res://scenes/main.tscn")
	if GameState.day_counter == 2:
		timer = delta + timer
		panel_6.visible = true
		if timer >= 5:
			panel_6.visible = false
			panel_7.visible = true
			timer1 = delta + timer 
			if timer >= 9:
				TransitionPlayer.change_scene("res://scenes/main.tscn")
	if GameState.day_counter == 3:
		timer = delta + timer 
		panel_8.visible = true 
		if timer >= 4:
			panel_8.visible = false
			panel_9.visible = true
			timer = delta + timer
			sprite_2d_2.visible = true
			if timer >= 9:
				panel_9.visible = false
				panel_10.visible = true
				timer = delta + timer
				if timer >= 13:
					panel_10.visible = false
					panel_11.visible = true
					timer = delta + timer
				if timer >= 17:
					TransitionPlayer.change_scene("res://scenes/main.tscn")
	pass
