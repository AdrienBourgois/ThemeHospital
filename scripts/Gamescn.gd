
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")
onready var objectives = get_node("Objectives")
onready var calendar = get_node("Calendar")
onready var in_game_gui = get_node("In_game_gui")
onready var map = get_node("Map")
onready var menu = in_game_gui.menu

export var map_size = Vector2(0, 0)

func _ready():
	menu.hide()
	loader.gamescn = self
	saver.gamescn = self
	loader.loadInit()
	init()
	set_process_input(true)
	set_process(true)

func _input(event):
	if (event.is_action_released("ui_accept")):
		saver.quicksave()
	#elif (event.is_action_released("ui_cancel")):
		#menu.set_hidden(not menu.is_hidden()) 
 
func init():
	if !game.new_game:
		loader.loadPlayer(game.save_to_load)
		map.init(int(map.size_x), int(map.size_y))
		game.new_game = true
	else:
		map.init(int(map_size.x), int(map_size.y))
	
	in_game_gui.init()