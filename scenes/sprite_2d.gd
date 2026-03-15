extends Sprite2D

@onready var panel: Panel = $Panel
@onready var panel_2: Panel = $Panel2
@onready var panel_3: Panel = $Panel3

var timer: float
var timer1: float

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	timer = delta + timer
	if timer >= 4:
		timer1 = delta + timer1
		panel.visible = false
		panel_2.visible = true
		if timer1 >= 5 :
			panel_2.visible = false
			panel_3.visible = true
			if timer1 >= 9 :
				get_tree().change_scene_to_file("res://scenes/main.tscn")
	pass
