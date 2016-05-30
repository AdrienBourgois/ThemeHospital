
extends Control

onready var game = get_node("/root/Game")
onready var hud = null
onready var heat_manager = game.scene.heat_manager
onready var money_box = get_node("./Panel/MoneyBox")
onready var increase_heat_button = get_node("./Panel/HospitalManager/IncreaseHeatButton")
onready var decrease_heat_button = get_node("./Panel/HospitalManager/DecreaseHeatButton")
onready var heat_level_progress_bar = get_node("./Panel/HospitalManager/HeatLevelProgressBar")
onready var heating_bill_label = get_node("./Panel/HospitalManager/HeatingBillLabel")
onready var plot_manager = get_node("./Panel/PlotManager/")
var file_map = File.new()
var node2d = null

var test_x = 10
var test_y = 10
var tiles = []

class Tile:
	var type = "Decoration"
	var x = -1
	var y = -1

func _ready ():
	node2d = Node2D.new()
	checkFile()
#	for y in range ( test_y ):
#		for x in range ( test_x ):
#			var tile = Tile.new()
#			tile.x = x
#			tile.y = y
#			tiles.append(tile)
#	
	
#	node2d.connect("draw", self, "drawMap")
#	
#	plot_manager.add_child(node2d)

func checkFile():
	file_map.open("res://Maps/map1.lvl", 1)
	
	var x = 0
	var y = 0 
	
	if(!file_map.is_open()):
		return
	else:
		test_x = file_map.get_line().to_int()
		test_y = file_map.get_line().to_int()
		while( !file_map.eof_reached() ):
			var line_data = file_map.get_line()
			
			for car in range ( line_data.length() ):
				var tile = Tile.new()
				tile.x = car
				tile.y = y
				if (line_data[car] == "1"):
					tile.type = "Lobby"
				tiles.append(tile)
			x = 0
			y += 1
	
	file_map.close()
	
	node2d.connect("draw", self, "drawMap")
	
	plot_manager.add_child(node2d)

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
	
	set_hidden(true)
	hud.set_hidden(false)


func _on_TownMap_visibility_changed():
	money_box.updateMoney()


func _on_HScrollBar_value_changed( value ):
	node2d.set_scale(Vector2(value, value))


func _on_PlotManager_input_event( ev ):
	var pos = node2d.get_pos()
	var size = Vector2(test_x * node2d.get_scale().x, test_y * node2d.get_scale().y)
	
	
	if ( Input.is_action_pressed("left_click") ):
		var width = size.x / test_x
		var height = size.y / test_y
		
		for tile in tiles:
			if ( tile.x * width < ev.pos.x && (tile.x * width) + width > ev.pos.x):
				if ( tile.y * height < ev.pos.y && (tile.y * height) + height > ev.pos.y):
					if (tile.type == "Lobby"):
						print("corridor found")
						return
