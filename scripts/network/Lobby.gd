
extends Control

onready var message_line_edit = get_node("./panel/chat_box/message_line_edit")
onready var global_client = get_node("/root/GlobalClient")
onready var global_server = get_node("/root/GlobalServer")
onready var connected_clients_label = get_node("./panel/clients_information_box/connected_clients_list")
onready var ready_players_label = get_node("./panel/clients_information_box/ready_players_label")
onready var kick_list = get_node("./panel/clients_information_box/kick_list_box")
var last_messages_list_size = 0


func _ready():
	checkHostClient()
	setScrollFollow()
	message_line_edit.grab_focus()
	set_process(true)


func _process(delta):
	update_chat()


func _on_send_message_button_pressed():
	var message = message_line_edit.get_text()
	
	if (!checkForEmptyMessage(message)):
		var new_message = "/chat " + parseSpaces(message) + "\n"
		global_client.sendPacket(new_message)
		message_line_edit.clear()


func update_chat():
	var messagesListLabel = get_node("panel/chat_box/messages_list_label")
	var messagesList = global_client.getMessagesList()
	
	if (last_messages_list_size != messagesList.size()):
		last_messages_list_size = messagesList.size()
		messagesListLabel.clear()
		for message in range (messagesList.size()):
			messagesListLabel.add_text(messagesList[message])


func checkHostClient():
	if (global_client.getClientStates().is_host):
		get_node("panel/combo_box").set_hidden(true)
	else:
		get_node("panel/clients_information_box").set_hidden(true)
	pass


func setScrollFollow():
	get_node("panel/chat_box/messages_list_label").set_scroll_follow(true)


func _on_message_line_edit_input_event( ev ):
	if (ev.is_action_pressed("accept")):
		_on_send_message_button_pressed()


func _on_disconnect_button_pressed():
	global_client.disconnectFromServer()
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")


func checkForEmptyMessage(message):
	if (message.empty()):
		return true
	
	for character in range (message.length()):
		if (message[character] != ' '):
			return false
	
	return true


func clearConnectedClientsLabel():
	connected_clients_label.clear()

func addConnectedClient(client_nickname):
	connected_clients_label.add_text(client_nickname)


func clearReadyPlayersLabel():
	ready_players_label.clear()

func addReadyPlayer(player_nickname):
	ready_players_label.add_text(player_nickname)


func clearKickList():
	kick_list.clear()

func addPlayerKickList(player_nickname, player_id):
	kick_list.add_item(player_nickname, player_id)


func parseSpaces(message):
	for character in range (message.length()):
		if (message[character] != ' '):
			return message.substr(character, message.length())


func _on_ready_button_toggled( pressed ):
	global_client.addPacket("/game 1 " + str(int(pressed)))


func _on_start_game_button_pressed():
	global_server.addPacket("/game 2")


func _on_kick_button_pressed():
	var kick_list_node = get_node("panel/clients_information_box/kick_list_box")
	
	if (kick_list_node.get_item_count() > 0):
		global_server.kickPlayer(kick_list_node.get_selected_ID())
