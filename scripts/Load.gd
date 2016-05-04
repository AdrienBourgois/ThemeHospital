
extends Node

onready var game = get_node("/root/Game")
var gamescn setget setGamescn
onready var save = get_node("/root/Save")
onready var dir = game.dir
onready var saves_path = "res://saves/"
onready var filename
onready var folder_path

func _ready():
	pass

func loadPlayer(save_number):
	if gamescn:
		if (!checkPlayerFolder()):
			print("Player not found")
			return false
		else:
			setFilename(save_number)
			loadPlayerData()
			print("Player founded and loaded")
			return true
	return false

func loadPlayerData():
	game.file.open(folder_path + filename, game.file.READ)
	while (!game.file.eof_reached()):
		gamescn.player.stats.parse_json(game.file.get_line())
	game.file.close()

func setFilename(save_number):
	if (save_number == 0):
		filename = "Quicksave"
	else:
		filename = "save_" + str(save_number)

func checkPlayerFolder():
	folder_path = saves_path + gamescn.player.name + '/'
	if (game.dir.dir_exists(folder_path)):
		return true
	return false

func loadInit():
	save.checkSaves()
	if (!game.file.file_exists(game.init_path)):
		print("Init file not found, create a new one")
		save.setDefaultInit()
		game.config = game.default_config
	else:
		game.file.open(game.init_path, game.file.READ)
		while (!game.file.eof_reached()):
			game.config.parse_json(game.file.get_line())
		game.file.close()
	applyConfig()

func applyConfig():
	OS.set_window_size(Vector2(game.config.res_x, game.config.res_y))
	OS.set_window_fullscreen(game.config.fullscreen)

func setGamescn(scene):
	gamescn = scene