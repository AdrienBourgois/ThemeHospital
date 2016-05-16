
extends Panel

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var saver = get_node("/root/Save")

onready var global_client = get_node("/root/GlobalClient")

func _ready():
	pass


func _on_Options_pressed():
	pass


func _on_Back_pressed():
	loader.gamescn = null
	saver.gamescn = null
	checkForMultiplayerGame()
	game.goToScene("res://scenes/GUI/MainMenu.scn")

func checkForMultiplayerGame():
	if (game.multiplayer):
		global_client.disconnectFromServer()