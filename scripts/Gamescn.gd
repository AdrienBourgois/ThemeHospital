
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")
onready var calendar = get_node("Calendar")
onready var in_game_gui = get_node("In_game_gui")
var test = true

func _ready(): 
	loader.gamescn = self
	saver.gamescn = self
	loader.loadInit()
	#saver.savePlayer(0)
	#loader.quickload()
	init()
	in_game_gui.init()

func _process(delta):
	if test:
		in_game_gui.init()
		test = false

func init():
	if !game.new_game:
		loader.loadPlayer(game.save_to_load)
		game.new_game = true