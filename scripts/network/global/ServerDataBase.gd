
extends Node

onready var global_server = get_node("/root/GlobalServer")
onready var entity_manager = ResourceLoader.load("res://scripts/Entities/EntityManager.gd")

var players_array = Array() setget addPlayer,getPlayerArray
var employee_data = Array() setget addEmployee,getEmployeeArray
var map_objectives = Array() setget setMapObjectives,getMapObjectives
var auction_sale = Array() setget setAuctionSale,getAuctionSale
var items_list = Array() setget addItemInList,getItemsList
var current_item_id = 0
var is_auction_active = false
var auction_sale_beginning = 0
var timer = null


func _process(delta):
	checkForAuctionEnding()

func addPlayer( player_name, player_id ):
	var player = Array()
	player.push_back(player_id)
	player.push_back(player_name)
	player.push_back(40000)
	player.push_back(500)
	player.push_back(0)
	player.push_back(0)
	player.push_back(0)
	player.push_back(0)
	player.push_back(Array())
	
	players_array.push_back(player)

func getPlayerArray():
	return players_array

func getEmployeeArray():
	return employee_data

func getMapObjectives():
	return map_objectives


func addItemInList( item_name, player_id, rotation, position ):
	var item_info = Array()
	item_info.push_back( getItemNameWithId(item_name) )
	item_info.push_back( player_id )
	item_info.push_back( rotation )
	item_info.push_back( position )
	
	items_list.push_back(item_info)


func moveItem( item_name, player_id, new_rotation, new_position):
	for item in range ( items_list.size() ):
		if ( items_list[item][0] == item_name && items_list[item][1] == player_id):
			items_list[item][2] = new_rotation
			items_list[item][3] = new_position
			return true
	
	return false


func getItemsList():
	return items_list


func addMoney( money_value, player_id ):
	for player in range ( players_array.size() ):
		if ( players_array[player][0] == player_id ):
			players_array[player][2] += money_value
			sendPacketMoney()


func removeMoney( money_value, player_id ):
	for player in range ( players_array.size() ):
		if ( players_array[player][0] == player_id ):
			if ( (players_array[player][2] - money_value) > 0):
				players_array[player][2] -= money_value
				sendPacketMoney()
				return true
			else:
				return false
	return false

func setAuctionSale( plot_value ):
	auction_sale.clear()
	auction_sale.push_back(plot_value)
	auction_sale.push_back(plot_value)
	auction_sale.push_back(null)
	auction_sale.push_back(0)
	
	getAuctionMenuTimer()
	is_auction_active = true
	set_process(true)


func acceptPlayerBid( player_id ):
	for player in range ( players_array.size() ):
		if ( players_array[player][0] == player_id ):
			if ( players_array[player][2] > auction_sale[1]):
				auction_sale[2] = player_id
				auction_sale[3] = auction_sale[1]
				updateNextBid()
				return true
	
	return false


func updateNextBid():
	auction_sale[1] = auction_sale[1] + (auction_sale[0] * 10)/100


func getAuctionSale():
	return auction_sale


func checkForAuctionEnding():
	if ( timer != null && !timer.is_active() ):
		is_auction_active = false
		
		removeMoney(auction_sale[3], auction_sale[2])
		
		set_process(false)


func getAuctionMenuTimer():
	if (timer == null):
		var root = get_tree().get_current_scene()
		
		if ( root != null && root.get_name() == "GameScene"):
			timer = root.get_node("In_game_gui/TownMap/AuctionMenu/Timer")

func sendPacketMoney():
	for player in range ( players_array.size() ):
		var packet = "/game 12 " + str(players_array[player][2])
		global_server.sendTargetedPacket(players_array[player][0], packet)


func getItemNameWithId( item_name ):
	var new_name = item_name + "_" + str(current_item_id)
	current_item_id += 1
	
	return new_name


func getLastItemName():
	return items_list[items_list.size()-1][0]

func createStaff():
	entity_manager = entity_manager.new()
	entity_manager._ready()
	employee_data = entity_manager.getStaffArray()