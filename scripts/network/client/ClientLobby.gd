
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
	global_client.sendPacket(message_line_edit.get_text())
	message_line_edit.clear()

func update_chat():
	var messagesListLabel = get_node("panel/chat_box/messages_list_label")
	var messagesList = global_client.getMessagesList()
	
	if (last_messages_list_size != messagesList.size()):
		last_messages_list_size = messagesList.size()
		messagesListLabel.clear()
		for message in range (messagesList.size()):
			messagesListLabel.add_text(messagesList[message])
	
	pass

func checkHostClient():
	if (global_client.getClientStates().is_host):
		get_node("panel/combo_box").set_hidden(true)
	else:
		get_node("panel/clients_information_box").set_hidden(true)
	pass

func setScrollFollow():
	get_node("panel/chat_box/messages_list_label").set_scroll_follow(true)

func _on_message_line_edit_input_event( ev ):
	if (ev.is_action_pressed("send_message")):
		_on_send_message_button_pressed()
