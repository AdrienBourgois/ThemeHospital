
extends Button

onready var port_node = get_tree().get_current_scene().get_node("./panel/combo_box/port_spin_box")
onready var ip_address_node = get_tree().get_current_scene().get_node("./panel/combo_box/ip_address_line_edit")
onready var nickname_node = get_tree().get_current_scene().get_node("./panel/combo_box/nickname_line_edit")

func _ready():
	pass


func _on_join_server_button_pressed():
	if (port_node == null || ip_address_node == null):
		return
	
	get_node("/root/GlobalClient").connect_to_server(ip_address_node.get_text(), port_node.get_value())
	
	pass # replace with function body
