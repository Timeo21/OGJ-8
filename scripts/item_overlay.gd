extends Control

@export var item_container_scene: PackedScene
@export var item_stacker: HBoxContainer

func _ready() -> void:
	SignalBus.items_updated.connect(load_overlay)
	load_overlay()
	
func load_overlay() -> void:
	for n in item_stacker.get_children():
		item_stacker.remove_child(n)
		n.queue_free() 

	var db: Dictionary[Utils.ItemId, GameItem] = GameState.item_db
	for id in GameState.owned_items:
		var game_item: GameItem = db[id]
		var new_container: ItemContainer = item_container_scene.instantiate() as ItemContainer
		item_stacker.add_child(new_container)
		new_container.get_texture().texture = game_item.image
		new_container.get_texture().tooltip_text = game_item.tooltip
