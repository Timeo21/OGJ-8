class_name BuyPanel
extends Panel

@export var image1: TextureRect
@export var image2: TextureRect
@export var image3: TextureRect

func setup_shop() -> void:
	var to_offer := GameState.item_pool
	to_offer.shuffle()
	var db: Dictionary[Utils.ItemId, GameItem] = GameState.item_db
	image1.texture = db[to_offer[0]].image
	image2.texture = db[to_offer[1]].image
	image3.texture = db[to_offer[2]].image

func process_buy_press(pos: Utils.BuyButtonPostion) -> void:
	pass

func _on_button_left_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.LEFT)

func _on_button_middle_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.MIDDLE)

func _on_button_right_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.RIGHT)
