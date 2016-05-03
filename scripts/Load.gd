
extends Node

onready var game = get_node("/root/Game")
onready var gamescn = game.scene
onready var save = get_node("/root/Save")
onready var dir = game.dir
onready var saves_path = "res://saves/"
onready var filename
onready var folder_path

func _ready():
	pass

func load_player(save_number):
	if (!check_player_folder()):
		print("Player not found")
		return false
	else:
		set_filename(save_number)
		load_player_data()
		print("Player founded and loaded")
		return true

func load_player_data():
	game.file.open(folder_path + filename, game.file.READ)
	while (!game.file.eof_reached()):
		gamescn.player.stats.parse_json(game.file.get_line())
	game.file.close()

func set_filename(save_number):
	if (save_number == 0):
		filename = "Quicksave"
	else:
		filename = "save_" + str(save_number)

func check_player_folder():
	folder_path = saves_path + gamescn.player.stats.NAME + '/'
	if (game.dir.dir_exists(folder_path)):
		return true
	return false

func load_init():
	save.check_saves()
	if (!game.file.file_exists(game.init_path)):
		print("Init file not found, create a new one")
		save.set_init()
		game.config = game.default_config
	else:
		game.file.open(game.init_path, game.file.READ)
		while (!game.file.eof_reached()):
			game.config.parse_json(game.file.get_line())
		game.file.close()
	apply_config()

func apply_config():
	OS.set_window_size(Vector2(game.config.res_x, game.config.res_y))
	OS.set_window_fullscreen(game.config.fullscreen)

