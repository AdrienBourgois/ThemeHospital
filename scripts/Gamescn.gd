
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")
onready var objectives = get_node("Objectives")
onready var calendar = get_node("Calendar")
onready var in_game_gui_res = preload("res://scenes/GUI/InGameGui.scn")
onready var map = get_node("Map")
onready var entity_manager = get_node("EntityManager")
onready var hire_manager = get_node("HireManager")
onready var saving_game = get_node("SavingGameGUI")
onready var in_game_chat = preload("res://scenes/network/InGameChat.scn")
onready var global_server = get_node("/root/GlobalServer")
var in_game_gui

export var map_size = Vector2(0, 0)

func _ready():
	loader.gamescn = self
	saver.gamescn = self
	loader.loadInit()
	init()
	set_process_input(true)
	set_process(true)

func _input(event):
	if (event.is_action_released("save")):
		saving_game.show()
		saver.quicksave()
		saving_game.showComplete()
	if ( game.getMultiplayer() && event.is_action_pressed("show_chat") ):
		in_game_chat.toggleVisibility()
 
func init():
	if !game.new_game:
		loader.loadPlayer(game.save_to_load)
		game.new_game = true
	
	hire_manager.setStaffArray(entity_manager.staff_array)
	
	if ( game.getMultiplayer() ):
		initInGameChat()
	
	initInGameGui()
	game.feedback.display("TUTO_MOVE_CAM")
	global_server.sendMutablePlayers()

func initInGameGui():
	in_game_gui = in_game_gui_res.instance()
	add_child(in_game_gui)
	initObjectives()

func initObjectives():
	objectives.linkToGui()
	player.initObjectives()

func initInGameChat():
	in_game_chat = in_game_chat.instance()
	add_child(in_game_chat)