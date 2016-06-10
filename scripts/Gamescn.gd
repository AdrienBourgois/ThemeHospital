
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var camera = get_node("Camera")
onready var player = get_node("Player")
onready var objectives = get_node("Objectives")
onready var calendar = get_node("Calendar")
onready var in_game_gui_res = preload("res://scenes/GUI/InGameGui.scn")
onready var map = get_node("Map")
onready var entity_manager = get_node("EntityManager")
onready var diseases = get_node("Diseases")
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
var temp_objects_nodes_array = [] setget, getTempObjectsNodesArray
var have_object = false setget setHaveObject, getHaveObject

var staff_nodes_array = [] setget, getStaffNodesArray
var staff_data_array = [] setget, getStaffDataArray
var staff_dict  = {}

export var map_size = Vector2(0, 0)

func _ready():
	loader.gamescn = self
	saver.gamescn = self
	object_ressources.setTempArray(temp_objects_nodes_array)
	loader.loadInit()
	init()
	set_process_input(true)

func createObjectsDict():
	objects = {
	OBJECTS = objects_array
	}
	return objects

func createStaffDict():
	staff_dict = {
	STAFF = staff_data_array
	}
	return staff_dict

func loadObjects():
	for current in objects.OBJECTS: 
		var node = object_ressources.createObject(current.NAME)
		if (!node):
			return 
		self.add_child(node)
		node.can_selected = false
		node.set_process_input(false)
		node.set_translation(Vector3(current.X, current.Y, current.Z))
		node.set_rotation(Vector3(0, current.ROTATION, 0))
		node.addToArray()
		for tile in map.tiles:
			if (tile.x == node.get_translation().x and tile.y == node.get_translation().z):
				node.setAvailableTile(true)

func loadStaff():
	for current in staff_dict.STAFF:
		pass

func updateStaffDataArray():
	staff_data_array.clear()
	for current in staff_nodes_array:
		current.addToArray()

func updateObjectsArray():
	objects_array.clear()
	for current in objects_nodes_array:
		current.addToArray()

func getStaffDataArray():
	return staff_data_array

func getStaffNodesArray():
	return staff_nodes_array

func setHaveObject(boolean):
	have_object = boolean

func getHaveObject():
	return have_object

func getTempObjectsNodesArray():
	return temp_objects_nodes_array

func getObjectsNodesArray():
	return objects_nodes_array

func getObjectArray():
	return objects_array

func getObjectResources():
	return object_ressources

func _input(event):
	if (event.is_action_released("save") and !game.getMultiplayer()):
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
	game.feedback.display("TUTO_MOVE_CAM")

func initObjectives():
	objectives.linkToGui()
	player.initObjectives()

func initInGameChat():
	in_game_chat = in_game_chat.instance()
	add_child(in_game_chat)

func setNameFirstItemTempArray( item_name ):
	temp_objects_nodes_array[0].set_name( item_name )

func setUpFirstItemTempArray():
	var node = temp_objects_nodes_array[0]
	
	node.setUpNetworkItem()
	node.nextObject()

func moveItem(item_name, rotation, position):
	for item in range ( get_child_count() ):
		var node = get_child(item)
		if ( node.get_name() == item_name ):
			node.setObjectStats(item_name, rotation, position.x, position.z)
			node.setUpNetworkItem()