
extends Control
onready var port_label_node = get_tree().get_current_scene().get_node("./panel/combo_box/port_line_edit")
onready var nickname_line_edit_node = get_tree().get_current_scene().get_node("./panel/combo_box/nickname_line_edit")
onready var global_server = get_node("/root/GlobalServer")
onready var global_client = get_node("/root/GlobalClient")

func _on_launch_server_button_pressed():
	if (port_label_node != null):
		if (global_server.startServer(port_label_node.get_text().to_int())):
			global_client.addPacket("/nickname " + nickname_line_edit_node.get_text())
			get_tree().get_current_scene().queue_free()
			get_tree().change_scene("res://scenes/network/Lobby.scn")


func _on_back_to_main_menu_button_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")

func checkInputEvent( ev ):
	if (ev.is_action_pressed("accept")):
		_on_launch_server_button_pressed()
