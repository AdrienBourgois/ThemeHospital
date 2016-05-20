extends Node

onready var game = get_node("/root/Game")
var gamescn setget setGamescn
onready var save = get_node("/root/Save")
onready var dir = game.dir
onready var saves_path = "res://saves/"
onready var filename
onready var savename setget, getSavename
onready var folder_path
onready var file_path setget ,getPath
onready var load_dict = {}

func quickload():
	loadPlayer(0)

func autoload():
	loadPlayer(10)

func loadPlayer(save_number):
	if !gamescn:
		return false
	if (!checkPlayerFolder()):
		return false
	if (!checkPlayerFile(save_number)):
		return false
	else:
		setFilename(save_number)
		loadPlayerData()
		return true
	return false

func loadPlayerData():
	gamescn.player.resetStatsDict()
	game.file.open(folder_path + filename, game.file.READ)
	while (!game.file.eof_reached()):
		load_dict.parse_json(game.file.get_line())

	gamescn.player.stats = load_dict.PLAYER
	gamescn.calendar.stats = load_dict.CALENDAR
	gamescn.objects = load_dict.OBJECTS
	
	gamescn.player.loadData()
	gamescn.calendar.loadData()
	gamescn.loadObjects()
	resetStatsDict()
	game.file.close()

func resetStatsDict():
	load_dict.clear()

func setFilename(save_number):
	if (save_number == 0):
		filename = "Quicksave.json"
		savename = "QuickSave"
	elif (save_number == 10):
		filename = "Autosave.json"
		savename = "AutoSave"
	else:
		filename = "save_" + str(save_number) + ".json"
		savename = "Save " + str(save_number)

func checkPlayerFolder():
	if gamescn:
		gamescn.player.createStatsDict()
		folder_path = saves_path + game.username + '/'
		gamescn.player.resetStatsDict()
	else:
		folder_path = saves_path + game.username + '/'
	
	if (game.dir.dir_exists(folder_path)):
		return true
	return false

func checkPlayerFile(save_number):
	if save_number == 0:
		file_path = folder_path + "Quicksave.json"
	else:
		file_path = folder_path + "save_" + str(save_number) + ".json"
	
	if (game.file.file_exists(file_path)):
		return true
	else:
		return false

func loadInit():
	save.checkSaves()
	if (!game.file.file_exists(game.init_path)):
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
	TranslationServer.set_locale(game.config.langage)

func getSavename():
	return savename

func setGamescn(scene):
	gamescn = scene

func getPath():
	return file_path