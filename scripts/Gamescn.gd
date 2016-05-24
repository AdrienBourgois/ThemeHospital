
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
onready var heat_manager = get_node("HeatManager")
onready var saving_game = get_node("SavingGameGUI")
onready var in_game_chat = preload("res://scenes/network/InGameChat.scn")
onready var global_server = get_node("/root/GlobalServer")

onready var object_ressources = preload("res://scripts/Entities/Objects/ObjectResources.gd").new() setget, getResources
onready var objectscn = preload("res://scenes/Entities/Objects/Object.scn")
onready var benchscn = preload("res://scenes/Entities/Objects/Bench.scn")
onready var plantscn = preload("res://scenes/Entities/Objects/Plant.scn")
onready var radiatorscn = preload("res://scenes/Entities/Objects/Radiator.scn")
onready var drinkscn = preload("res://scenes/Entities/Objects/DrinkMachine.scn") 
onready var firescn = preload("res://scenes/Entities/Objects/Fire.scn")
onready var objects_array = [] setget getObjectArray
onready var objects = {}

var in_game_gui

export var map_size = Vector2(0, 0)

func _ready():
	loader.gamescn = self
	saver.gamescn = self
	loader.loadInit()
	init()
	set_process_input(true)

func createObjectsDict():
	objects = {
	OBJECTS = objects_array
	}
	return objects

func loadObjects():
	for current in objects.OBJECTS: 
		var node = object_ressources.createObject(current.NAME)
		if (!node):
			return
		self.add_child(node)
		node.can_selected = false
		node.set_process_input(false)
		node.set_translation(Vector3(current.X, current.Y, current.Z)) 
		node.addToArray()

func getObjectArray():
	return objects_array

func getResources():
	return object_ressources

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
		global_server.sendMutablePlayers()
	
	initInGameGui()

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