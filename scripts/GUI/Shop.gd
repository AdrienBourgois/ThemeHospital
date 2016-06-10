
onready var game = get_node("/root/Game")
onready var shop_info = get_node("./Panel/ShopInfo")
onready var available_items = get_node("./Panel/Shop/AvailableItems")
onready var price_label = shop_info.get_node("./PriceLabel")
onready var total_label = shop_info.get_node("./TotalLabel")

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