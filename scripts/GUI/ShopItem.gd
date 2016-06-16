
extends Control

onready var shop = get_tree().get_current_scene().get_node("./Shop")
onready var counter_item_label = get_node("./CounterItemLabel")
onready var item_description_button = get_node("./ItemDescriptionButton")
onready var items_list = load("res://scripts/Entities/Objects/ShopItemsInfo.gd")

export var item_cost = -1 setget ,getItemCost
export var item_id = -1
export var item_picture_path = "res://"

var count = 0 setget ,getCount
var left_click_pressed = false
var right_click_pressed = false
var item_info = null setget ,getItemInfo
var image_texture = null


func _ready():
	setItemInfo()
	setImageTexture()

func setItemInfo():
	items_list = items_list.new()
	get_tree().get_current_scene().add_child(items_list)
	item_info = items_list.getItemFromId( item_id )
	
	if (item_info == null):
		return
	
	if ( item_cost == -1):
		item_cost = item_info.item_price
	
	item_description_button.set_text( tr(item_info.display_name) )


func setImageTexture():
	image_texture = ImageTexture.new()
	image_texture.load(item_picture_path)


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


func _on_ItemDescriptionButton_input_event( ev ):
	if ( ev.type != 3):
		return
	
	if ( Input.is_mouse_button_pressed(2) ):
		decreaseCount()


func getCount():
	return count

func resetCount():
	count = 0

func getItemCost():
	return item_cost

func getTotalCost():
	return (item_cost*count)

func getItemInfo():
	return item_info


func updatePriceLabel():
	shop.updatePriceLabel(item_cost)
	shop.updateTextureFrame(image_texture)


func freeMemory():
	items_list.queue_free()