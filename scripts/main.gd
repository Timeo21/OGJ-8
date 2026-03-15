class_name Main
extends Node

@export var time_label: Label
@export var camera_2d: Camera2D
@export var menu_ui: Control
@export var game_ui: Control
@export var fish_root: Node
@export var cursor: Cursor
@export var hook_fade_time: float =  1.0
@export var level_list: LevelList
@export var fish_spawners: Node

var time_left: float
@export var time: float = 40
var fishing: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_2d.on_reach_game_pos.connect(func(): start_timer())
	camera_2d.on_reach_menu_pos.connect(func(): open_summary())
	var fishes: Node = level_list.levels[GameState.day_counter].instantiate() as Node
	for f in fishes.get_children():
		var fish: Fish = f as Fish
		fishes.remove_child(fish)
		fish_root.add_child(fish)
		fish.position = (fish_spawners.get_children().pick_random() as Marker2D).position
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not fishing:
		return
	update_timer(time_left)
	time_left -= delta
	if time_left <= 0:
		time_left = 0
		days_end()
	pass

func open_summary() -> void:
	print("should transtition")
	TransitionPlayer.change_scene("res://scenes/shop.tscn")
	
func _on_back_to_menu() -> void:
	menu_ui.visible = true
	game_ui.visible = false

func _on_fishing_button_pressed() -> void:
	menu_ui.visible = false
	update_timer(time)
	pass

func start_timer() -> void:
	game_ui.visible = true
	fishing = true
	cursor.show()
	cursor.modulate = Color.TRANSPARENT
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(cursor, "modulate", Color.WHITE, hook_fade_time)
	time_left = time
	
func days_end() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(cursor, "modulate", Color.TRANSPARENT, hook_fade_time)
	tween.tween_callback(cursor.hide)
	fishing = false
	camera_2d.move_to(0,3)
	

func update_timer(time: float) -> void:
	var sec: int = floori(time)%60
	var min: int = floori(floori(time)/60)
	var min_txt:String = str(min)+":"
	var sec_txt:String = "0"+str(sec) if sec < 10 else str(sec)
	time_label.text = min_txt+sec_txt
