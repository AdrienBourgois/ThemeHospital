
extends Node

onready var game = get_node("/root/Game")
onready var gamescn = game.get_scene()
onready var dir = game.dir
onready var saves_path = "res://saves/"
onready var path = "res://saves/"
onready var filename
onready var file_path

func _ready():
	pass

func set_init():
	game.file.open(game.init_path, game.file.WRITE)
	game.file.store_string(game.default_config.to_json())
	game.file.close()

func save_player(ID):
	check_saves()
	check_player_folder()
	if (ID == 0):
		filename = "Quicksave"
	else:
		filename = "save_" + str(ID)
	file_path = saves_path + gamescn.player.name + '/' + filename
	store_data()

func store_data():
	game.file.open(file_path, game.file.WRITE)
	game.file.store_string(gamescn.player.stats.to_json())
	game.file.close()

func check_saves():
	if (!dir.dir_exists("res://saves")):
		dir.make_dir("res://saves")

func check_player_folder():
	path += gamescn.player.name
	if (!dir.dir_exists(path)):
		dir.make_dir(path)