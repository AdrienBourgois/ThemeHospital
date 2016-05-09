
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")
onready var calendar = get_node("Calendar")
onready var in_game_gui = get_node("In_game_gui")
onready var map = get_node("Map")

export var map_size = Vector2(5, 5)

func _ready():
	loader.gamescn = self
	saver.gamescn = self
	loader.loadInit()
	init()
	in_game_gui.init()
	map.init(int(map_size.x), int(map_size.y))
	set_process_input(true)
	loader.loadPlayer(0)
	print(map.size_x)

func _input(event):
	if (event.is_action_released("ui_accept")):
		saver.quicksave()
 
func init():
	if !game.new_game:
		loader.loadPlayer(game.save_to_load)
		game.new_game = true