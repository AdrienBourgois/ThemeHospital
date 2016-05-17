
extends Control

onready var global_client = get_node("/root/GlobalClient")
onready var global_server = get_node("/root/GlobalServer")
onready var game = get_node("/root/Game")
onready var messages_list_label = get_node("./chat_box/messages_list_label")
onready var message_line_edit = get_node("./chat_box/message_line_edit")
var never_show_chat = false
var last_messages_list_size = 0

func _ready():
	checkMultiplayer()
	toggleVisibility()

func _process(delta):
	updateChat()

func checkMultiplayer():
	if ( !game.getMultiplayer() ):
		never_show_chat = true
	else:
		messages_list_label.set_scroll_follow(true)
		set_process(true)

func toggleVisibility():
	if ( !never_show_chat ):
		set_hidden(is_visible())

func updateChat():
	var messages_list = global_client.getMessagesList()
	
	if ( last_messages_list_size != messages_list.size() ):
		last_messages_list_size = messages_list.size()
		messages_list_label.clear()
		for message in range (messages_list.size()):
			messages_list_label.add_text(messages_list[message])

func checkForEmptyMessage(message):
	if ( message.empty() ):
		return true
	
	for character in range ( message.length() ):
		if ( message[character] != ' ' ):
			return false
	
	return true

func parseSpaces(message):
	for character in range (message.length()):
		if (message[character] != ' '):
			return message.substr(character, message.length())

func _on_message_line_edit_input_event( event ):
	if ( event.is_action_pressed("accept") ):
		_on_send_message_button_pressed()


func _on_send_message_button_pressed():
	var message = message_line_edit.get_text()
	
	if ( !checkForEmptyMessage(message) ):
		var new_message = "/chat " + parseSpaces(message) + "\n"
		global_client.sendPacket(new_message)
		message_line_edit.clear()
