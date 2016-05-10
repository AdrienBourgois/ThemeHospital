
extends Control

onready var game = get_node("/root/Game")
onready var client_states = get_node("/root/GlobalClient").getClientStates()
onready var map_list = get_node("panel_server/")
onready var global_server = get_node("/root/GlobalServer")
onready var controle_validation = get_node("./panel_server/controle_validation")
onready var map_confirmation = get_node("./panel_server/controle_validation/map_confirmation")
var selected_map = null

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

func selectMap( map_id, map_name ):
	selected_map = map_id
	
	controle_validation.set_hidden(false)
	map_confirmation.set_hidden(false)
	map_confirmation.get_node("ok_button").grab_focus()
	
	map_confirmation.get_node("map_name_label").set_text(tr("TXT_MAP_SELECTED") + map_name)

func _on_map_confirmation_confirmed():
	global_server.addPacket("/game 2 1 " + str(selected_map))


func _on_map_confirmation_hide():
	map_confirmation.set_hidden(true)
	controle_validation.set_hidden(true)
