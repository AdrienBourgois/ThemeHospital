
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")
onready var calendar = get_node("Calendar")
onready var in_game_gui = get_node("In_game_gui")
onready var mapscn = preload("res://scenes/Map/Map.scn")
onready var map

export var map_size = Vector2(28, 28)

func _ready(): 
	loader.gamescn = self
	saver.gamescn = self
	loader.loadInit()
	saver.savePlayer(0)
	#loader.quickload()
	init()
	in_game_gui.init()
	map = mapscn.instance()
	add_child(map)

func init():
	if !game.new_game:
		loader.loadPlayer(game.save_to_load)
		game.new_game = true