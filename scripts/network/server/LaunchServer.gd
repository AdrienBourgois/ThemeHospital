
extends Button

onready var port_label_node = get_tree().get_current_scene().get_node("./panel/combo_box/port_line_edit")
onready var nickname_line_edit_node = get_tree().get_current_scene().get_node("./panel/combo_box/nickname_line_edit")

func _on_launch_server_button_pressed():
	if (port_label_node != null):
		get_node("/root/GlobalServer").startServer(port_label_node.get_text().to_int())
		get_node("/root/GlobalServer").setHostName(nickname_line_edit_node.get_text())
	
	pass
