# InputMapSaver.gd (autoload singleton)
extends Node

const SAVE_PATH: String = "user://input_map.cfg"

var input_actions: Dictionary[String,String] = {
	"up" : "Move Up",
	"right" : "Move Right",
	"accept" : "Accept",
	"skip" : "Skip"
}

var joypad_index: Dictionary[int,String] = {
	0 : "A", # Cross
	1 : "B", # Circle
	2 : "X", # Sqare
	3 : "Y", # Triangle
	4 : "Back", # Select
	5 : "Home", # PS
	6 : "Menu", # Start
	7 : "L3", # Left joystick
	8 : "R3", # Right joystick
	9 : "LB", # L1
	10 : "RB", # R1
	11 : "D-pad Up",
	12 : "D-pad Down",
	13 : "D-pad Left",
	14 : "D-pad Right",
	15 : "Share", # Micro
	20 : "Touchpad", #PS4/5 only
}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		var focused = get_viewport().gui_get_focus_owner()
		if focused is Button and not focused.disabled:
			focused.pressed.emit()

func save_input_map() -> void:
	var config = ConfigFile.new()
	for action in input_actions:
		var events = InputMap.action_get_events(action)
		var event_data = []
		for event in events:
			if event is InputEventKey:
				event_data.append({"type": "key", "keycode": event.keycode, "physical_keycode": event.physical_keycode})
			elif event is InputEventMouseButton:
				event_data.append({"type": "mouse", "button_index": event.button_index})
			elif event is InputEventJoypadButton:
				event_data.append({"type": "joypad_button", "button_index": event.button_index})
			elif event is InputEventJoypadMotion:
				event_data.append({"type": "joypad_motion", "axis": event.axis, "axis_value": event.axis_value})
		config.set_value(action, "events", event_data)
	config.save(SAVE_PATH)

func load_input_map() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return
	for action in input_actions:
		if not config.has_section(action):
			continue
		var event_data = config.get_value(action, "events", [])
		if event_data.is_empty():
			continue
		InputMap.action_erase_events(action)
		for data in event_data:
			var event: InputEvent
			match data.get("type", ""):
				"key":
					var e = InputEventKey.new()
					e.keycode = data.get("keycode", 0)
					e.physical_keycode = data.get("physical_keycode", 0)
					event = e
				"mouse":
					var e = InputEventMouseButton.new()
					e.button_index = data.get("button_index", 0)
					e.pressed = true
					event = e
				"joypad_button":
					var e = InputEventJoypadButton.new()
					e.button_index = data.get("button_index", 0)
					event = e
				"joypad_motion":
					var e = InputEventJoypadMotion.new()
					e.axis = data.get("axis", 0)
					e.axis_value = data.get("axis_value", 0.0)
					event = e
			if event:
				InputMap.action_add_event(action, event)
