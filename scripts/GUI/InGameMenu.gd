
extends Control

onready var game = get_node("/root/Game")

func _ready():
	pass

func _on_BackToGame_pressed():
	self.hide()

func _on_BackToMenu_pressed():
	game.goToScene("res://scenes/GUI/MainMenu.scn")
