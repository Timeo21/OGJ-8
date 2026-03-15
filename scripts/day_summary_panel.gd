class_name DaySummaryPanel
extends PanelContainer

signal day_summary_next

@export var easy_num: Label
@export var normal_num: Label
@export var hard_num: Label
@export var easy_money: Label
@export var normal_money: Label
@export var hard_money: Label
@export var total_money: Label
@export var bank_money: Label

func display_day_summary(day_summary: DaySummary) -> void:
	print("in update day summary")
	var n1 := day_summary.easy_fish_number
	var n2 := day_summary.normal_fish_number
	var n3 := day_summary.hard_fish_number
	easy_num.text = "Easy fish number: %d" % n1
	normal_num.text = "Normal fish number: %d" % n2
	hard_num.text = "Hard fish number: %d" % n3
	
	var v1 := n1*Utils.EASY_FISH_WORTH
	var v2 := n2*Utils.NORMAL_FISH_WORTH
	var v3 := n3*Utils.HARD_FISH_WORTH
	easy_money.text = "→%d🪙" % v1
	normal_money.text = "→%d🪙" % v2
	hard_money.text = "→%d🪙" % v3
	
	bank_money.text = "%d🪙" % GameState.bank_money
	
	var tot := v1+v2+v3+GameState.bank_money
	total_money.text = "%d🪙" % tot
	GameState.bank_money = tot


func _on_button_pressed() -> void:
	SignalBus.button_clicked.emit()
	day_summary_next.emit()
