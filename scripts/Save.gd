
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

func _ready():
	pass

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