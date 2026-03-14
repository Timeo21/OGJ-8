extends Node

@export var test_number: int = 1

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
		$DaySummaryPanel.show()
		$DaySummaryPanel.display_day_summary(DaySummary.new(2,3,4))
		
	if test_number == 3:
		randomize()
		print("trying to update buy panel")
		GameState.bank_money = 10
		$BuyPanel.show()
		$BuyPanel.setup_shop()
