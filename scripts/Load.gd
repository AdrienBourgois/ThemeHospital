
extends Node

onready var game = get_node("/root/Game")
onready var gamescn = game.get_scene()
onready var save = get_node("/root/Save")
onready var dir = game.dir
onready var saves_path = "res://saves/"
onready var filename
onready var folder_path

func _ready():
	pass

func loadPlayer(save_number):
	if (!checkPlayerFolder()):
		print("Player not found")
		return false
	else:
		setFilename(save_number)
		loadPlayerData()
		print("Player founded and loaded")
		return true

func loadPlayerData():
	gamescn.player.resetStatsDict()
	game.file.open(folder_path + filename, game.file.READ)
	while (!game.file.eof_reached()):
		gamescn.player.stats.parse_json(game.file.get_line())
	game.file.close()
	gamescn.player.name = gamescn.player.stats.NAME
	gamescn.player.money = gamescn.player.stats.MONEY
	gamescn.player.expense = gamescn.player.stats.EXPENSE
	gamescn.player.heal_patients = gamescn.player.stats.HEAL_PATIENTS
	gamescn.player.total_patients = gamescn.player.stats.TOTAL_PATIENTS
	gamescn.player.heal_patients_percent = gamescn.player.stats.HEAL_PATIENTS_PERCENT
	gamescn.player.reputation = gamescn.player.stats.REPUTATION
	gamescn.player.hospital_value = gamescn.player.stats.HOSPITAL_VALUE
	gamescn.player.resetStatsDict()

func setFilename(save_number):
	if (save_number == 0):
		filename = "Quicksave"
	else:
		filename = "save_" + str(save_number)

func checkPlayerFolder():
	gamescn.player.createStatsDict()
	folder_path = saves_path + gamescn.player.stats.NAME + '/'
	gamescn.player.resetStatsDict()
	if (game.dir.dir_exists(folder_path)):
		return true
	return false

func loadInit():
	save.checkSaves()
	if (!game.file.file_exists(game.init_path)):
		print("Init file not found, create a new one")
		save.setInit()
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

