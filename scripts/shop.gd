extends Control

func _ready() -> void:
	$BuyPanel.hide()
	$DaySummaryPanel.show()

func _on_day_summary_panel_day_summary_next() -> void:
	$DaySummaryPanel.hide()
	$BuyPanel.show()

func _on_buy_panel_buy_panel_next() -> void:
	TransitionPlayer.change_scene("res://scenes/tester.tscn")
