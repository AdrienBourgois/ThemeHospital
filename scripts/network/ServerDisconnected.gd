
extends Control

func _ready():
	get_node("warning_dialog_box").set_hidden(false)

func _on_AcceptDialog_confirmed():
	get_node("/root/GlobalClient").disconnectFromServer()
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")
