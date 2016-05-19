
extends Node

onready var game = get_node("/root/Game")
var gamescn setget setGamescn
onready var dir = game.dir
onready var map
onready var saves_path = "res://saves/"
onready var path = "res://saves/"
onready var filename
onready var file_path
onready var save_dict = {}
#onready var inputs_dict = {}
var config

func _ready():
	initConfig()

func setDefaultInit():
	game.file.open(game.init_path, game.file.WRITE)
	game.file.store_string(game.default_config.to_json())
	game.file.close()

func setInit():
	game.file.open(game.init_path, game.file.WRITE)
	game.file.store_string(game.config.to_json())
	game.file.close()

func quicksave():
	savePlayer(0)

func autosave():
	savePlayer(10)

func savePlayer(ID):
	checkSaves()
	checkPlayerFolder()
	if (ID == 0):
		filename = "Quicksave.json"
	elif (ID == 10):
		filename = "Autosave.json"
	else:
		filename = "save_" + str(ID) + ".json"
	file_path = saves_path + game.username + '/' + filename
	storeData()

func storeData():
	createSaveDict()
	if (game.file.is_open()):
		game.file.close()
	game.file.open(file_path, game.file.WRITE)
	game.file.store_string(save_dict.to_json())
	game.file.close()
	gamescn.player.resetStatsDict()

func createSaveDict():
	if (!map):
		map = gamescn.map
	save_dict = {
	PLAYER = gamescn.player.createStatsDict(),
	CALENDAR = gamescn.calendar.createStatsDict(),
	OBJECTS = gamescn.createObjectsDict()
#	MAP = map.createStatsDict()
	}
	return save_dict

func checkSaves():
	if (!dir.dir_exists("res://saves")):
		dir.make_dir("res://saves")

func checkPlayerFolder():
	file_path = saves_path + game.username
	if (!dir.dir_exists(file_path)):
		dir.make_dir(file_path)

func setGamescn(scene):
	gamescn = scene

#func saveInputs():
#	checkSaves()
#	checkPlayerFolder()
#	file_path = saves_path + game.username + '/Input.json'
#	createinputsDict()
#	storeInputsData()
#
#
#func createinputsDict():
#	inputs_dict = {
#	game.action_list[0] : InputMap.get_action_list(game.action_list[0]),
#	game.action_list[1] : InputMap.get_action_list(game.action_list[1]),
#	game.action_list[2] : InputMap.get_action_list(game.action_list[2]),
#	game.action_list[3] : InputMap.get_action_list(game.action_list[3])}
#
#
#func storeInputsData():
#	if (game.file.is_open()):
#		game.file.close()
#	game.file.open(file_path, game.file.WRITE)
#	game.file.store_string(inputs_dict.to_json())
#	game.file.close()
#	inputs_dict.clear()


func initConfig():
	config = ConfigFile.new()
	config.load("res://engine.cfg")

func saveInputs():
	print(config.has_section_key("input", "show_chat"))
	for idx in game.action_list:
		print(idx)
		config.set_value("input", "show_chat", InputMap.get_action_list(idx))
		print(config.get_value("input", "show_chat"))