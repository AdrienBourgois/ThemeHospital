
extends Control

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var saver = get_node("/root/Save")

func _on_Retry_pressed():
	loader.gamescn = null
	saver.gamescn = null
	game.goToScene("res://scenes/gamescn.scn")

func _on_Back_pressed():
	loader.gamescn = null
	saver.gamescn = null
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")
