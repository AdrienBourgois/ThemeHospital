
extends Control
onready var port_label_node = get_tree().get_current_scene().get_node("./panel/combo_box/port_line_edit")
onready var nickname_line_edit_node = get_tree().get_current_scene().get_node("./panel/combo_box/nickname_line_edit")


func _on_launch_server_button_pressed():
	if (port_label_node != null):
		if (get_node("/root/GlobalServer").startServer(port_label_node.get_text().to_int())):
			get_tree().get_current_scene().queue_free()
			get_tree().change_scene("res://scenes/network/Lobby.scn")


func _on_back_to_main_menu_button_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")

func checkInputEvent( ev ):
	if (ev.is_action_pressed("ui_accept")):
		_on_launch_server_button_pressed()
