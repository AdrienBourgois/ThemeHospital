
extends Control

onready var global_client = get_node("/root/GlobalClient")

export var plot_value = 0
var next_bid_value = 0


func _on_Timer_timeout():
	toggleAuctionMenuVisibility()


func _on_AuctionMenu_draw():
	get_node("AuctionMenu/Timer").start()

func _on_AcceptBidButton_pressed():
	pass # replace with function body
