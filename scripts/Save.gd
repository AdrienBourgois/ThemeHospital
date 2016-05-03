
extends Node

onready var game = get_node("/root/Game")
onready var gamescn = game.scene
onready var dir = game.dir
onready var saves_path = "res://saves/"
onready var path = "res://saves/"
onready var filename
onready var file_path
onready var save_dict = {}

func _ready():
	pass

func setInit():
	game.file.open(game.init_path, game.file.WRITE)
	game.file.store_string(game.default_config.to_json())
	game.file.close()

func savePlayer(ID):
	checkSaves()
	checkPlayerFolder()
	if (ID == 0):
		filename = "Quicksave.json"
	else:
		filename = "save_" + str(ID) + ".json"
	file_path = saves_path + gamescn.player.name + '/' + filename
	storeData()

func storeData():
	createSaveDict()
	game.file.open(file_path, game.file.WRITE)
	game.file.store_string(save_dict.to_json())
	game.file.close()
	gamescn.player.resetStatsDict()

func createSaveDict():
	gamescn.player.createStatsDict()
	save_dict = {
	PLAYER = gamescn.player.stats
	}

func checkSaves():
	if (!dir.dir_exists("res://saves")):
		dir.make_dir("res://saves")

func checkPlayerFolder():
	path += gamescn.player.name
	if (!dir.dir_exists(path)):
		dir.make_dir(path)