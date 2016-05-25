
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

onready var object_ressources = preload("res://scripts/Entities/Objects/ObjectResources.gd").new() setget, getObjectResources
onready var objects_array = [] setget getObjectArray
onready var objects = {}

var in_game_gui
var objects_nodes_array = [] setget, getObjectsNodesArray

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
		objects_nodes_array.append(node)
		node.can_selected = false
		node.set_process_input(false)
		node.set_translation(Vector3(current.X, current.Y, current.Z))
		node.set_rotation(Vector3(0, current.ROTATION, 0))
		node.addToArray()

func updateObjectsArray():
	objects_array.clear()
	for current in objects_nodes_array:
		current.addToArray()

func getObjectsNodesArray():
	return objects_nodes_array

func getObjectArray():
	return objects_array

func getObjectResources():
	return object_ressources

func _input(event):
	if (event.is_action_released("save")):
		saving_game.show()
		saver.quicksave()
		saving_game.showComplete()
	if (event.is_action_released("info")):
		print(map.columns[map.tile_on_cursor.x][map.tile_on_cursor.y].room_type)
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