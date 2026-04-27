# InputMapSaver.gd (autoload singleton)
extends Node

const SAVE_PATH = "user://input_map.cfg"

var input_actions = {
	"up" : "Move Up",
	"right" : "Move Right",
	"accept" : "Accept",
	"skip" : "Skip"
}

func save_input_map():
	var config = ConfigFile.new()
	for action in input_actions:
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			var event = events[0]
			if event is InputEventKey:
				config.set_value(action, "type", "key")
				config.set_value(action, "keycode", event.keycode)
				config.set_value(action, "physical_keycode", event.physical_keycode)
			elif event is InputEventMouseButton:
				config.set_value(action, "type", "mouse")
				config.set_value(action, "button_index", event.button_index)
	config.save(SAVE_PATH)

func load_input_map():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return
	for action in input_actions:
		if not config.has_section(action):
			continue
		var type = config.get_value(action, "type", "")
		var event: InputEvent
		if type == "key":
			var key_event = InputEventKey.new()
			key_event.keycode = config.get_value(action, "keycode", 0)
			key_event.physical_keycode = config.get_value(action, "physical_keycode", 0)
			event = key_event
		elif type == "mouse":
			var mouse_event = InputEventMouseButton.new()
			mouse_event.button_index = config.get_value(action, "button_index", 0)
			mouse_event.pressed = true
			event = mouse_event
		if event:
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
