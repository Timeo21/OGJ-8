class_name BuyPanel
extends Panel

func setup_shop() -> void:
	pass

func process_buy_press(pos: Utils.BuyButtonPostion) -> void:
	pass

func _on_button_left_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.LEFT)

func _on_button_middle_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.MIDDLE)


func _on_button_right_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.RIGHT)
