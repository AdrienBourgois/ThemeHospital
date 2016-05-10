
extends Control

onready var game = get_node("/root/Game")
onready var global_client = get_node("/root/GlobalClient")

func _ready():
	pass

func _on_BackToGame_pressed():
	self.hide()

func _on_BackToMenu_pressed():
	checkForMultiplayerGame()
	game.goToScene("res://scenes/GUI/MainMenu.scn")

func checkForMultiplayerGame():
	if (game.multiplayer):
		global_client.disconnectFromServer()