
extends Control

onready var game = get_node("/root/Game")
onready var message_line_edit = get_node("./panel/chat_box/message_line_edit")
onready var global_client = get_node("/root/GlobalClient")
onready var global_server = get_node("/root/GlobalServer")
onready var connected_clients_label = get_node("./panel/information_box/connected_clients_list")
onready var ready_players_label = get_node("./panel/information_box/ready_players_label")
onready var kick_list = get_node("./panel/information_box/server_commands_box/kick_list_box")
onready var messages_list_label = get_node("panel/chat_box/messages_list_label")
onready var nickname_line_edit = get_node("panel/control/nickname_information_box/nickname_line_edit")
var last_messages_list_size = 0


func _ready():
	checkHostClient()
	setScrollFollow()
	message_line_edit.grab_focus()
	set_process(true)
	setUsername()


func _process(delta):
	updateChat()


func _on_send_message_button_pressed():
	var message = message_line_edit.get_text()
	
	if (!checkForEmptyMessage(message)):
		var new_message = "/chat " + parseSpaces(message) + "\n"
		global_client.sendPacket(new_message)
		message_line_edit.clear()


func updateChat():
	var messages_list = global_client.getMessagesList()
	
	if (last_messages_list_size != messages_list.size()):
		last_messages_list_size = messages_list.size()
		messages_list_label.clear()
		for message in range (messages_list.size()):
			messages_list_label.add_text(messages_list[message])


func checkHostClient():
	if (global_client.getClientStates().is_host):
		get_node("panel/combo_box").set_hidden(true)
	else:
		get_node("panel/information_box/server_commands_box").set_hidden(true)


func setScrollFollow():
	messages_list_label.set_scroll_follow(true)


func _on_message_line_edit_input_event( ev ):
	if (ev.is_action_pressed("accept")):
		_on_send_message_button_pressed()


func _on_disconnect_button_pressed():
	global_client.disconnectFromServer()
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/MultiplayerSelectMenu.scn")


func checkForEmptyMessage(message):
	if ( message.empty() ):
		return true
	
	for character in range ( message.length() ):
		if ( message[character] != ' ' ):
			return false
	
	return true

func checkValidNickname(nickname):
	if (nickname.empty()):
		return false
	
	for character in range ( nickname.length() ):
		if (nickname[character] != ' '):
			return true
	
	return false


func parseSpaces(message):
	for character in range (message.length()):
		if (message[character] != ' '):
			return message.substr(character, message.length())


func _on_ready_button_toggled( pressed ):
	global_client.addPacket("/game 1 " + str(int(pressed)))


func _on_start_game_button_pressed():
	global_server.sendGameStartedWithPlayerData()


func _on_kick_button_pressed():
	var kick_list_node = get_node("panel/information_box/server_commands_box/kick_list_box")
	
	if (kick_list_node.get_item_count() > 0):
		global_server.kickPlayer(kick_list_node.get_selected_ID())

func displayNicknameMenu(boolean):
	get_node("panel/control").set_hidden(boolean)


func _on_control_visibility_changed():
	if (is_visible()):
		get_node("panel/control/nickname_information_box/send_nickname_button").grab_focus()


func _on_send_nickname_button_pressed():
	var nickname = nickname_line_edit.get_text()
	
	if ( !checkValidNickname(nickname) ):
		var node = ResourceLoader.load("res://scenes/network/InvalidNickname.scn").instance()
		get_tree().get_current_scene().add_child(node)
		return
	
	global_client.addPacket("/nickname " + nickname) 
	

func _on_nickname_line_edit_input_event( ev ):
	if (ev.is_action_pressed("accept")):
		_on_send_nickname_button_pressed()

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
	checkKickListItemCount()

func addPlayerKickList(player_nickname, player_id):
	if (kick_list.get_item_count() > 0):
		kick_list.add_separator()
	
	kick_list.add_item(player_nickname, player_id)
	
	checkKickListItemCount()

func checkKickListItemCount():
	if ( kick_list.get_item_count() > 0):
		kick_list.set_ignore_mouse(false)
	else:
		kick_list.set_ignore_mouse(true)


func setUsername():
	nickname_line_edit.set_text(game.getUsername() + "_2")
