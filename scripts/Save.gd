
extends Node

onready var game = get_node("/root/Game")
onready var dir = game.dir

func _ready():
	pass

func set_init():
	game.file.open(game.init_path, game.file.WRITE)
	game.file.store_string(game.default_config.to_json())
	game.file.close()

func save_player():
	pass

func check_saves():
	if (!dir.dir_exists("res://saves")):
		dir.make_dir("res://saves")