
extends Control

onready var global_client = get_node("/root/GlobalClient")

onready var next_bid_label = get_node("./BidBox/NextBidPanel/NextBidLabel")
onready var time_left_label = get_node("./BidBox/TimeLeftBar")
onready var best_offer_panel = get_node("./LastBidBox/BestOfferPanel")
onready var player_container = get_node("./PlayerListBox/PlayerContainer")
onready var timer = get_node("./Timer")

export var plot_value = 0 setget setPlotValue,getPlotValue
var next_bid_value = 0
var player_bid_data = Array()

func _ready():
	setPlayerBidArray()

func _process(delta):
	updateTimeLeft()

func _on_Timer_timeout():
	set_process(false)
	timer.set_active(false)
	plot_value = 0
	next_bid_value = 0
	next_bid_label.set_text("")
	clearPlayersBid()
	set_hidden(true)

func updateTimeLeft():
	var time_left = (timer.get_time_left() * 100)/timer.get_wait_time()
	
	if (time_left > 10):
		time_left_label.set_value(time_left)
	else:
		time_left_label.set_value(0)


func _on_AuctionMenu_draw():
	setLabels()
	timer.start()
	timer.set_active(true)
	set_process(true)

func _on_AcceptBidButton_pressed():
	global_client.addPacket("/game 11")


func updateNextBid( player_id ):
	for player in range ( player_bid_data.size() ):
		if ( player_bid_data[player][1] == player_id):
			player_bid_data[player][2] = next_bid_value
			best_offer_panel.get_node("PlayerNameLabel").set_text(player_bid_data[player][0])
			best_offer_panel.get_node("PlayerBidLabel").set_text(str(next_bid_value))
	
	setLabels()
	timer.stop()
	timer.start()
	next_bid_value = next_bid_value + ( plot_value * 10 )/100
	next_bid_label.set_text(str(next_bid_value))


func setPlotValue( value ):
	if ( plot_value == 0 ):
		plot_value = value
		next_bid_value = value
	
	if ( next_bid_label != null ):
		next_bid_label.set_text(str(next_bid_value))

func getPlotValue():
	return plot_value

func setLabels():
	for player in range ( player_bid_data.size() ):
		player_container.get_child(player).get_node("./PlayerNameLabel").set_text(player_bid_data[player][0])
		player_container.get_child(player).get_node("./PlayerBidLabel").set_text(str(player_bid_data[player][2]))

func setPlayerBidArray():
	var player_array = global_client.getPlayersList()
	
	for player in range ( player_array.size() ):
		var player_data = Array()
		
		player_data.push_back(player_array[player][0])
		player_data.push_back(player_array[player][1])
		player_data.push_back(0)
		
		player_bid_data.push_back(player_data)
	
	setLabels()

func clearPlayersBid():
	for player in range ( player_bid_data.size() ):
		player_bid_data[player][2] = 0