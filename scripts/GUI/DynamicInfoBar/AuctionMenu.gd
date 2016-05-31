
extends Control

onready var global_client = get_node("/root/GlobalClient")

onready var next_bid_label = get_node("./BidBox/NextBidLabel")
onready var time_left_label = get_node("./BidBox/TimeLeftBar")
onready var player_container = get_node("./PlayerListBox/PlayerContainer")
onready var timer = get_node("./Timer")

export var plot_value = 0 setget setPlotValue,getPlotValue
var next_bid_value = 0

func _process(delta):
	updateTimeLeft()

func _on_Timer_timeout():
	set_process(false)
	plot_value = 0
	next_bid_value = 0
	next_bid_label.set_text("")
	set_hidden(true)

func updateTimeLeft():
	var time_left = (timer.get_time_left() * 100)/3
	
	if (time_left > 10):
		time_left_label.set_value(time_left)


func _on_AuctionMenu_draw():
	setLabels()
	timer.start()
	set_process(true)

func _on_AcceptBidButton_pressed():
	global_client.addPacket("/game 11")


func updateNextBid():
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
	var player_array = global_client.getPlayersList()
	
	for player in range ( player_array.size() ):
		player_container.get_child(player).get_node("./PlayerNameLabel").set_text(player_array[player][0])
		player_container.get_child(player).get_node("./PlayerBidLabel").set_text("0")