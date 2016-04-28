
extends Control

func _ready():

	pass




func _on_host_game_button_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/ServerSettings.scn")


func _on_join_server_button_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/network/ClientSettings.scn")
