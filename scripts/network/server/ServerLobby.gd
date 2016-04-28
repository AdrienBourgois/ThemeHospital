
extends Control

onready var message_line_edit = get_node("./panel/chat_box/message_line_edit")
onready var global_client = get_node("/root/GlobalClient")
var last_messages_list_size = 0

func _ready():
	set_process(true)
	pass

func _process(delta):
	update_chat()


func _on_send_message_button_pressed():
	global_client.sendPacket(message_line_edit.get_text())
	message_line_edit.clear()
	pass # replace with function body

func update_chat():
	var messagesListLabel = get_node("panel/chat_box/messages_list_label")
	var messagesList = global_client.getMessagesList()
	
	if (last_messages_list_size != messagesList.size()):
		last_messages_list_size = messagesList.size()
		messagesListLabel.clear()
		for message in range (messagesList.size()):
			messagesListLabel.add_text(messagesList[message])
	
	pass
