extends Node

@export var test_number: int = 1
@export var buy_panel: BuyPanel
@export var summary_panel: DaySummaryPanel


func _ready() -> void:
	print("in tester")
	if test_number == 1:
		print("looking at db")
		var db := GameState.item_db
		for i in db:
			print(db[i].name)
			
		var pool := GameState.item_pool
		for v in pool:
			print(v)
	
	if test_number == 2:
		print("trying to update summary")
		summary_panel.show()
		summary_panel.display_day_summary(DaySummary.new(2,3,4))
		
	if test_number == 3:
		randomize()
		print("trying to update buy panel")
		GameState.bank_money = 10
		buy_panel.show()
		buy_panel.setup_shop()
		
	if test_number == 4:
		randomize()
		print("trying to update buy panel")
		GameState.bank_money = 10
		GameState.item_pool = GameState.item_pool.slice(0, 1)
		buy_panel.show()
		buy_panel.setup_shop()
		
	if test_number == 5:
		randomize()
		GameState.owned_items.push_back(Utils.ItemId.SLOW)
		var i: int = GameState.item_pool.find(Utils.ItemId.SLOW)
		GameState.item_pool.remove_at(i)
		TransitionPlayer.change_scene("res://scenes/main.tscn")
		
	if test_number == 6:
		randomize()
		GameState.owned_items.push_back(Utils.ItemId.FAST)
		var i: int = GameState.item_pool.find(Utils.ItemId.FAST)
		GameState.item_pool.remove_at(i)
		TransitionPlayer.change_scene("res://scenes/main.tscn")	
		
	if test_number == 7:
		randomize()
		GameState.owned_items.push_back(Utils.ItemId.PREDICTION)
		var i: int = GameState.item_pool.find(Utils.ItemId.PREDICTION)
		GameState.item_pool.remove_at(i)
		TransitionPlayer.change_scene("res://scenes/main.tscn")	
