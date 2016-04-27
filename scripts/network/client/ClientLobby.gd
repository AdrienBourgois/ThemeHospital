
extends Control

onready var message_line_edit = get_node("./panel/chat_box/message_line_edit")

func _ready():
	pass


func _on_send_button_pressed():
	print("j'envoie le message la ouais: ", message_line_edit.get_text())
	get_node("/root/GlobalClient").send_packet(message_line_edit.get_text())
	pass # replace with function body
