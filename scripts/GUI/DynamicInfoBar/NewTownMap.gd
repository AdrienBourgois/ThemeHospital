
extends Control

onready var game = get_node("/root/Game")
onready var camera = game.scene.camera
onready var global_client = get_node("/root/GlobalClient")
onready var hud = null
onready var heat_manager = game.scene.heat_manager
onready var money_container = get_node("./Panel/MoneyBox/DynamicMoney/MoneyBox/MoneyContainer")
onready var increase_heat_button = get_node("./Panel/HospitalManager/IncreaseHeatButton")
onready var decrease_heat_button = get_node("./Panel/HospitalManager/DecreaseHeatButton")
onready var heat_level_progress_bar = get_node("./Panel/HospitalManager/HeatLevelProgressBar")
onready var heating_bill_label = get_node("./Panel/HospitalManager/HeatingBillLabel")
onready var auction_menu = get_node("./AuctionMenu")
onready var plot_manager = get_node("./Panel/PlotManager/")
var file_map = File.new()
var node2d = Node2D.new()

var test_x = 0
var test_y = 0
var tiles = []

class Tile:
	var type = "Decoration"
	var x = -1
	var y = -1

func _ready ():
	checkFile()
	node2d.connect("draw", self, "drawMap")
	plot_manager.add_child(node2d)
	optimizeMapSize()

func checkFile():
	file_map.open("res://Maps/map1.lvl", 1)
	
	if(!file_map.is_open()):
		return
	else:
		createMapFromFile()
	
	file_map.close()


func createMapFromFile():
	test_x = file_map.get_line().to_int()
	test_y = file_map.get_line().to_int()
	
	var x = 0
	var y = 0 
	var line_data
	
	while( !file_map.eof_reached() ):
		line_data = file_map.get_line()
		
		for car in range ( line_data.length() ):
			var tile = Tile.new()
			tile.x = car
			tile.y = y
			if (line_data[car] == "1"):
				tile.type = "Lobby"
			tiles.append(tile)
		x = 0
		y += 1

func drawMap():
	for tile in tiles:
		if(tile.type == "Decoration"):
			node2d.draw_rect(Rect2(tile.x,tile.y, 1,1), Color(0.153, 0.682, 0.384))
		if(tile.type == "Lobby"):
			node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(0.498, 0.549, 0.553))

func _on_IncreaseHeatButton_pressed():
	if heat_manager.heat_ray < 10:
		heat_manager.heat_ray += 1
		heat_level_progress_bar.set_val(heat_manager.heat_ray * 10)
		heat_manager.increaseHeatCost()
		heating_bill_label.set_text(str(heat_manager.heat_cost))


func _on_DecreaseHeatButton_pressed():
	if heat_manager.heat_ray > 1:
		heat_manager.heat_ray -= 1
		heat_level_progress_bar.set_value(heat_manager.heat_ray * 10)
		heat_manager.decreaseHeatCost()
		heating_bill_label.set_text(str(heat_manager.heat_cost))


func _on_QuitButton_pressed():
	if (hud == null):
		hud = get_tree().get_current_scene().get_node("./In_game_gui/HUD")
	camera.pause = false
	
	set_hidden(true)
	hud.set_hidden(false)


func _on_TownMap_visibility_changed():
	money_container.updateMoney()


func optimizeMapSize():
	var scale = 1
	var new_size = 0 
	
	while ( scale != 20 ):
		new_size = Vector2(test_x * scale, test_y * scale)
		
		if (plot_manager.get_size().x < new_size.x || plot_manager.get_size().y < new_size.y):
			node2d.set_scale(Vector2(scale - 1, scale - 1))
			return
		
		scale += 1

func _on_PlotManager_input_event( ev ):
	if ( Input.is_action_pressed("left_click") ):
		checkMousePos( ev.pos )

func checkMousePos( pos ):
	var size = Vector2(test_x * node2d.get_scale().x, test_y * node2d.get_scale().y)
	var width = size.x / test_x
	var height = size.y / test_y
	
	for tile in tiles:
		if ( tile.x * width < pos.x && (tile.x * width) + width > pos.x):
			if ( tile.y * height < pos.y && (tile.y * height) + height > pos.y):
				buyPlot(tile)
				return


func buyPlot( tile ):
	if ( tile.type == "Lobby" ):
		if ( game.getMultiplayer() ):
			global_client.addPacket("/game 10")

func toggleAuctionMenuVisibility( value ):
	auction_menu.set_hidden(get_node("AuctionMenu").is_visible())
	auction_menu.setPlotValue( value )
	
