
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")
onready var calendar = get_node("Calendar")

func _ready(): 
	loader.gamescn = self
	saver.gamescn = self
	loader.loadInit()
	#saver.savePlayer(0)
	#loader.quickload()
	init()
	pass

func init():
	if !game.new_game:
		loader.loadPlayer(game.save_to_load)
		game.new_game = true