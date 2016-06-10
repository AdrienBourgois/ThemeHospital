
extends Control

onready var shop = get_tree().get_current_scene()
onready var counter_item_label = get_node("./CounterItemLabel")
onready var item_description_button = get_node("./ItemDescriptionButton")
onready var items_list = load("res://scripts/Entities/Objects/ShopItemsInfo.gd")

export var item_cost = -1 setget ,getItemCost
export var item_id = -1

var count = 0 setget ,getCount
var left_click_pressed = false
var right_click_pressed = false
var item_info = null

func _ready():
	setItemInfo()

func setItemInfo():
	items_list = items_list.new()
	item_info = items_list.getItemFromId( item_id )
	
	if (item_info == null):
		return
	
	if ( item_cost == -1):
		item_cost = item_info.item_price
	
	item_description_button.set_text( tr(item_info.item_name) )

func updateCount():
	if ( left_click_pressed ):
		increaseCount()
	elif ( right_click_pressed ):
		decreaseCount()
	
	updateLabel()

func increaseCount():
	if ( count < 99 ):
		count += 1
		updateLabel()
		shop.updateTotalPrice()

func decreaseCount():
	if ( count > 0 ):
		count -= 1
		updateLabel()
		shop.updateTotalPrice()

func updateLabel():
	counter_item_label.set_text( str(count) )

func getCount():
	return count

func _on_ItemDescriptionButton_input_event( ev ):
	if ( ev.type != 3):
		return
	
	if ( Input.is_mouse_button_pressed(2) ):
		decreaseCount()


func resetCount():
	count = 0


func getItemCost():
	return item_cost

func updatePriceLabel():
	shop.updatePriceLabel(item_cost)

func getTotalCost():
	return (item_cost*count)
