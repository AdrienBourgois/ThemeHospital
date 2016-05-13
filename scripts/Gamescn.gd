
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
	if (event.is_action_released("ui_accept")):
		saver.quicksave()
 
func init():
	if !game.new_game:
		loader.loadPlayer(game.save_to_load)
		game.new_game = true
	hire_manager.setStaffArray(entity_manager.staff_array)
	initInGameGui()

func initInGameGui():
	in_game_gui = in_game_gui_res.instance()
	add_child(in_game_gui)
	initObjectives()

func initObjectives():
	objectives.linkToGui()
	player.initObjectives()