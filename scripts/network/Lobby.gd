
extends Control

onready var message_line_edit = get_node("./panel/chat_box/message_line_edit")
onready var global_client = get_node("/root/GlobalClient")
var last_messages_list_size = 0


func _ready():
	checkHostClient()
	setScrollFollow()
	set_process(true)


func _process(delta):
	update_chat()


func _on_send_message_button_pressed():
	var message = "/chat " + message_line_edit.get_text() + "\n"
	
	if (!checkForEmptyMessage(message)):
		global_client.sendPacket(parseSpaces(message))
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
	pass # replace with function body


func checkForEmptyMessage(message):
	if (message.empty()):
		return true
	
	for character in range (message.length()):
		if (message[character] != ' '):
			return false
	
	return true


func parseSpaces(message):
	for character in range (message.length()):
		if (message[character] != ' '):
			return message.substr(character, message.length())


func _on_ready_button_toggled( pressed ):
	global_client.addPacket("/game 1 " + str(int(pressed)))
	pass # replace with function body
