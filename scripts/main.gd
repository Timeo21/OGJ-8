class_name Main
extends Node

@onready var time_label: Label = $"UI/Game UI/Label"
@onready var money_label: Label = $"UI/Menu UI/MoneyLabel"
@onready var camera_2d: Camera2D = $Gameplay/Camera2D
@onready var menu_ui: Control = $"UI/Menu UI"
@onready var game_ui: Control = $"UI/Game UI"

var time_left: float
@export var time: float = 40
var fishing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_2d.on_reach_game_pos.connect(func(): start_timer())
	camera_2d.on_reach_menu_pos.connect(func(): open_summary())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_labels()
	if not fishing:
		return
	update_timer(time_left)
	time_left -= delta
	if time_left <= 0:
		time_left = 0
		fishing = false
		camera_2d.move_to(0,3)
	pass

func open_summary() -> void:
	TransitionPlayer.change_scene("res://scenes/shop.tscn")
	
func _on_back_to_menu() -> void:
	menu_ui.visible = true
	game_ui.visible = false

func _on_fishing_button_pressed() -> void:
	menu_ui.visible = false
	game_ui.visible = true
	update_timer(time)
	pass

func start_timer() -> void:
	fishing = true
	time_left = time
	
func days_end() -> void:
	fishing = false

func update_labels() -> void:
	money_label.text = "Money: "+str(GameState.bank_money)

func update_timer(time: float) -> void:
	var sec: int = floori(time)%60
	var min: int = floori(floori(time)/60)
	var min_txt:String = str(min)+":"
	var sec_txt:String = "0"+str(sec) if sec < 10 else str(sec)
	time_label.text = "Time left: " + min_txt+sec_txt
