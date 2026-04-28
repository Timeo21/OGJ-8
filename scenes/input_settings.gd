extends Control

@onready var input_button_scene = preload("res://scenes/input_button.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null

func _ready():
	_create_action_list()

func _get_bindings_text(action: String) -> String:
	var events = InputMap.action_get_events(action)
	var parts = []
	for event in events:
		if event is InputEventJoypadButton:
			parts.append(InputMapSaver.joypad_index[event.button_index])
		else:
			var text = event.as_text().trim_suffix(" (Physical)").trim_suffix(" - Physical")
			if not text.is_empty():
					parts.append(text)
	return " / ".join(parts) if parts.size() > 0 else ""

func _create_action_list():
	for item in action_list.get_children():
		item.queue_free()

	for action in InputMapSaver.input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")

		action_label.text = InputMapSaver.input_actions[action]
		input_label.text = _get_bindings_text(action)

		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("LabelInput").text = "Press key or button..."

func _input(event: InputEvent) -> void:
	if is_remapping:
		var is_joypad = event is InputEventJoypadButton or event is InputEventJoypadMotion
		var is_valid = (
			event is InputEventKey or
			(event is InputEventMouseButton and event.pressed) or
			(event is InputEventJoypadButton and event.pressed) or
			(event is InputEventJoypadMotion and abs(event.axis_value) > 0.5)
		)

		if is_valid:
			# Replace only events of the same category (keyboard/mouse vs controller)
			var keep_events = []
			for existing in InputMap.action_get_events(action_to_remap):
				var existing_is_joypad = existing is InputEventJoypadButton or existing is InputEventJoypadMotion
				if existing_is_joypad != is_joypad:
					keep_events.append(existing)

			InputMap.action_erase_events(action_to_remap)
			for kept in keep_events:
				InputMap.action_add_event(action_to_remap, kept)
			InputMap.action_add_event(action_to_remap, event)

			remapping_button.find_child("LabelInput").text = _get_bindings_text(action_to_remap)
			InputMapSaver.save_input_map()

			is_remapping = false
			action_to_remap = null
			remapping_button = null

			accept_event()
	else:
		if event.is_action_pressed("settings"):
			TransitionPlayer.change_scene("res://scenes/title.tscn")

func _update_action_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)").trim_suffix(" - Physical")
