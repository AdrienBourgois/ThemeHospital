
extends Control

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")


func _ready():
	pass

func _on_BackToGame_pressed():
	self.hide()

func _on_BackToMenu_pressed():
	loader.gamescn = null
	saver.gamescn = null
	game.goToScene("res://scenes/GUI/MainMenu.scn")