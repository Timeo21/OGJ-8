extends Control

@export var buy_panel: BuyPanel
@export var day_summary_panel: DaySummaryPanel

func _ready() -> void:
	buy_panel.hide()
	day_summary_panel.display_day_summary(GameState.summary)
	GameState.summary = DaySummary.new(0, 0, 0)
	day_summary_panel.show()

func _on_day_summary_panel_day_summary_next() -> void:
	day_summary_panel.hide()
	buy_panel.setup_shop()
	buy_panel.show()

func _on_buy_panel_buy_panel_next() -> void:
	TransitionPlayer.change_scene("res://scenes/main.tscn")
