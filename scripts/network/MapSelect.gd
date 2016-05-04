
extends Control

onready var client_states = get_node("/root/GlobalClient").getClientStates()
onready var map_list = get_node("panel_server/map_list_array")

func _ready():
	checkClientHost()


func _on_VButtonArray_button_selected( button ):
	var map_selected = map_list.get_selected()
	print("Map selected: ", map_selected)

func checkClientHost():
	if (client_states.is_host):
		get_node("panel_server/").set_hidden(false)
	else:
		get_node("panel_client").set_hidden(false)

func _on_panel_client_visibility_changed():
	get_node("panel_client/information_box").set_hidden(false)

func _on_panel_server_visibility_changed():
	map_list.set_hidden(false)
