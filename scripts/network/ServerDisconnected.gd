
extends Control

func displayUnavailableServer():
	get_node("warning_dialog_box").set_hidden(false)

func displayKickedFromServer():
	get_node("kicked_from_server_box").set_hidden(false)

func _on_AcceptDialog_confirmed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")