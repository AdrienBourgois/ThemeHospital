
extends Control

onready var port_node = get_node("./panel/combo_box/port_spin_box")
onready var ip_address_node = get_node("./panel/combo_box/ip_address_line_edit")
onready var nickname_node = get_node("./panel/combo_box/nickname_line_edit")
onready var global_client = get_node("/root/GlobalClient")
onready var invalid_server = get_node("panel/invalid_server")
onready var invalid_nickname = get_node("panel/invalid_nickname")

func _on_join_server_button_pressed():
	if (port_node == null || ip_address_node == null):
		return
	
	if ( !checkValidIpAddress() || !checkValidNickname()):
		return
	
	if (global_client.connectToServer(ip_address_node.get_text(), port_node.get_value())):
		global_client.addPacket("/nickname " + nickname_node.get_text())
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/network/Lobby.scn")


func _on_back_to_main_menu_button_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")


func checkInputEvent( ev ):
	if (ev.is_action_pressed("accept")):
		_on_join_server_button_pressed()


func checkValidIpAddress():
	var count = 0
	
	if ( ip_address_node.get_text().empty() ):
		invalid_server.set_hidden(false)
		return false
	
	for character in range ( ip_address_node.get_text().length() ):
		if (ip_address_node.get_text()[character] == '.' ):
			count += 1
	
	if (count != 3):
		invalid_server.set_hidden(false)
		return false
	
	return true


func checkValidNickname():
	var nickname = nickname_node.get_text()
	
	if (nickname.empty()):
		invalid_nickname.set_hidden(false)
		return false
	
	for character in range ( nickname.length() ):
		if (nickname[character] != ' '):
			return true
	
	invalid_nickname.set_hidden(false)
	return false

func _on_invalid_server_visibility_changed():
	invalid_server.get_ok().grab_focus()


func _on_invalid_nickname_visibility_changed():
	invalid_nickname.get_ok().grab_focus()
