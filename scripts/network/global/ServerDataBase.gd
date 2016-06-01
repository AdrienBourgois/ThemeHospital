
extends Node

onready var global_server = get_node("/root/GlobalServer")
var players_array = Array() setget addPlayer,getPlayerArray
var employee_data = Array() setget addEmployee,getEmployeeArray
var map_objectives = Array() setget setMapObjectives,getMapObjectives
var auction_sale = Array() setget setAuctionSale,getAuctionSale
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

func addEmployee():
	pass

func getEmployeeArray():
	return employee_data

func setMapObjectives():
	pass

func getMapObjectives():
	return map_objectives


func addMoney( money_value, player_id ):
	for player in range ( players_array.size() ):
		if ( players_array[player][0] == player_id ):
			players_array[player][2] += money_value
			sendPacketMoney()


func removeMoney( money_value, player_id ):
	for player in range ( players_array.size() ):
		if ( players_array[player][0] == player_id ):
			players_array[player][2] -= money_value
			sendPacketMoney()

func setAuctionSale( plot_value ):
	auction_sale.clear()
	auction_sale.push_back(plot_value)
	auction_sale.push_back(plot_value)
	auction_sale.push_back(null)
	auction_sale.push_back(0)
	
	get_auction_menu_timer()
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


func get_auction_menu_timer():
	if (timer == null):
		var root = get_tree().get_current_scene()
		
		if ( root != null && root.get_name() == "GameScene"):
			timer = root.get_node("In_game_gui/TownMap/AuctionMenu/Timer")

func sendPacketMoney():
	for player in range ( players_array.size() ):
		var packet = "/game 12 " + str(players_array[player][2])
		global_server.sendTargetedPacket(players_array[player][0], packet)