
extends Control

onready var game = get_node("/root/Game")


func _on_Retry_pressed():
	game.goToScene("res://scenes/gamescn.scn")

func _on_Back_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")
