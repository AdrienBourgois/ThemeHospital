
onready var game = get_node("/root/Game")
onready var control_panel = game.scene.get_node("./In_game_gui/HUD/Control_panel/Build_hire_controls")
onready var object_resources = game.scene.getObjectResources()
onready var shop_info = get_node("./Panel/ShopInfo")
onready var available_items = get_node("./Panel/Shop/AvailableItems")
onready var price_label = shop_info.get_node("./PriceLabel")
onready var total_label = shop_info.get_node("./TotalLabel")
onready var temp_array = game.scene.getTempObjectsNodesArray()
onready var texture_frame = get_node("./Panel/ItemPreview/TextureFrame")

var total_price = 0

func _ready():
	resetTotalPrice()

func resetTotalPrice():
	total_label.set_text( tr("TXT_TOTAL") + "0" )

func updatePriceLabel(item_price):
	price_label.set_text( tr("TXT_PRICE") + str(item_price) )

func updateTotalPrice():
	total_price = 0
	
	for item in range ( available_items.get_child_count() ):
		total_price += available_items.get_child(item).getTotalCost()
	
	total_label.set_text( tr("TXT_TOTAL") + str(total_price) )

func _on_QuitButton_pressed():
	control_panel.hideCurrentWindow()


func _on_BuyButton_pressed():
	if ( game.scene.player.money < total_price ):
		return
	
	game.scene.player.money -= total_price
	var temp_array = game.scene.getTempObjectsNodesArray()
	
	for index_panel in range ( available_items.get_child_count() ):
		for count in range ( available_items.get_child(index_panel).getCount() ):
			var item_name = available_items.get_child(index_panel).getItemInfo().item_name
			
			addItemNameToArray(item_name)
	
	if (!temp_array.empty()):
		game.scene.setHaveObject(true)
	
	control_panel.hideCurrentWindow()

func addItemNameToArray(item_name):
	if (temp_array.size() == 0 ):
		var node = object_resources.createObject(item_name)
		
		game.scene.add_child(node)
		
		temp_array.push_back(node)
		node.available.on()
		node.is_selected = true
		node.can_selected = true
	else:
		temp_array.push_back(item_name)


func updateTextureFrame(texture):
	texture_frame.set_texture(texture)


func freeScene():
	for index in range ( available_items.get_child_count() ):
		available_items.get_child(index).freeMemory()
	
	queue_free()