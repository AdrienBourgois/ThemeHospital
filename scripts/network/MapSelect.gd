
extends Control

onready var game = get_node("/root/Game")
onready var client_states = get_node("/root/GlobalClient").getClientStates()
onready var map_list = get_node("panel_server/map_list_array")
onready var global_server = get_node("/root/GlobalServer")

func _ready():
	checkClientHost()

func checkClientHost():
	if (client_states.is_host):
		get_node("panel_server/").set_hidden(false)
	else:
		get_node("panel_client").set_hidden(false)

func _on_panel_server_visibility_changed():
	map_list.set_hidden(false)
	map_list.grab_focus()

func _on_panel_client_visibility_changed():
	get_node("panel_client/information_box").set_hidden(false)


func _on_map_list_array_input_event( ev ):
	if (ev.is_action_pressed("accept")):
		var map_selected = map_list.get_selected()
		global_server.addPacket("/game 2 1 " + str(map_selected))
		game.multiplayer = true