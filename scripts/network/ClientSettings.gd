
extends Control

onready var port_node = get_node("./panel/combo_box/port_spin_box")
onready var ip_address_node = get_node("./panel/combo_box/ip_address_line_edit")
onready var nickname_node = get_node("./panel/combo_box/nickname_line_edit")

func _on_join_server_button_pressed():
	if (port_node == null || ip_address_node == null):
		return
	
	if (get_node("/root/GlobalClient").connectToServer(ip_address_node.get_text(), port_node.get_value())):
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/network/Lobby.scn")


func _on_back_to_main_menu_button_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")


func checkInputEvent( ev ):
	if (ev.is_action_pressed("accept")):
		_on_join_server_button_pressed()
	pass # replace with function body
