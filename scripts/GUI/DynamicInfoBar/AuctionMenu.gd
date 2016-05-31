
extends Control


func toggleAuctionMenuVisibility():
	set_hidden(is_visible())

func _on_Control_draw():
	get_node("AuctionMenu/Timer").start()


func _on_Timer_timeout():
	toggleAuctionMenuVisibility()
