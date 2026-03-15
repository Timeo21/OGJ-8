class_name BuyPanel
extends Panel

signal buy_panel_next

@export var image1: TextureRect
@export var image2: TextureRect
@export var image3: TextureRect
@export var buy1: Button
@export var buy2: Button
@export var buy3: Button
@export var out_of_stock_img: Texture2D
@export var money_label: Label
@export var nothing_left: GameItem

@onready var images: Array[TextureRect] = [image1, image2, image3]
@onready var buy_buttons: Array[Button] = [buy1, buy2, buy3]

var to_offer: Array[Utils.ItemId]

func setup_shop() -> void:
	to_offer = GameState.item_pool
	to_offer.shuffle()
	to_offer = to_offer.slice(0, 3)
	
	while to_offer.size() < 3:
		to_offer.push_back(Utils.ItemId.NOTHING_LEFT)
	money_label.text = "%d🪙" % GameState.bank_money
	
	var db: Dictionary[Utils.ItemId, GameItem] = GameState.item_db
	for i in range(3):
		if  to_offer[i] == Utils.ItemId.NOTHING_LEFT:
			images[i].texture = nothing_left.image
			buy_buttons[i].text =  ""
			buy_buttons[i].disabled =  true
		else:
			var item: GameItem = db[to_offer[i]]
			images[i].texture = item.image
			buy_buttons[i].text =  "%d🪙" % item.price

func process_buy_press(pos: Utils.BuyButtonPostion) -> void:
	SignalBus.button_clicked.emit()
	var db: Dictionary[Utils.ItemId, GameItem] = GameState.item_db
	var item: GameItem = db[to_offer[pos]]
	if GameState.bank_money < item.price:
		return
	GameState.bank_money -= item.price
	money_label.text = "%d🪙" % GameState.bank_money
	
	var selected: Utils.ItemId = to_offer[pos]
	var idx: int = GameState.item_pool.find(selected)
	GameState.item_pool.remove_at(idx)
	GameState.owned_items.push_back(selected)
	SignalBus.items_updated.emit()
	
	images[pos].texture = out_of_stock_img
	buy_buttons[pos].text =  ""
	buy_buttons[pos].disabled = true
	

func _on_button_left_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.LEFT)

func _on_button_middle_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.MIDDLE)

func _on_button_right_pressed() -> void:
	process_buy_press(Utils.BuyButtonPostion.RIGHT)


func _on_button_pressed() -> void:
	SignalBus.button_clicked.emit()
	buy_panel_next.emit()
