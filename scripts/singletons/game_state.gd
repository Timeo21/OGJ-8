extends Node

var day_counter: int = 0
var owned_items: Array[Utils.ItemId] = []
var bank_money: int = 0 
var summary: DaySummary = DaySummary.new(0, 0, 0)
@onready var item_pool: Array[Utils.ItemId] = load_item_pool()
@onready var item_db: Dictionary[Utils.ItemId, GameItem] = load_resources_indexed_by_property("res://ressources/items/")

func _ready() -> void:
	SignalBus.fish_caugth.connect(update_summary)
	
func update_summary(type: Utils.FishType) -> void:
	summary = summary.increment_specific(type)

func load_item_pool() -> Array[Utils.ItemId]:
	var pool: Array[Utils.ItemId] = []

	for v in Utils.ItemId.values():
		if v != Utils.ItemId.NOTHING_LEFT and v != Utils.ItemId.FREEZE:
			pool.append(v)
	return pool

func load_resources_indexed_by_property(path: String) -> Dictionary[Utils.ItemId, GameItem]:
	var result: Dictionary[Utils.ItemId, GameItem] = {}
	var dir := DirAccess.open(path)
	
	if dir == null:
		push_error("Cannot open directory: " + path)
		return result
	
	dir.list_dir_begin()
	var file_name := dir.get_next()
	
	while file_name != "":
		if not dir.current_is_dir():
			if file_name.ends_with(".tres") or file_name.ends_with(".res"):
				var res: GameItem = load(path + "/" + file_name)
				if res != null:
					var key = res.id
					if key != Utils.ItemId.NOTHING_LEFT:
						result[key] = res
		
		file_name = dir.get_next()
	
	dir.list_dir_end()
	return result

func isItemOwned(id: Utils.ItemId) -> bool:
	return owned_items.has(id)
