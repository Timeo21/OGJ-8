extends Node

@export var test_number: int = 1
@export var buy_panel: BuyPanel
@export var summary_panel: DaySummaryPanel


func _ready() -> void:
	print("in tester")
	if test_number == 1:
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
