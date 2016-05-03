
extends Node

onready var game = get_node("/root/Game")
onready var save = get_node("/root/Save")

func _ready():
	pass

func load_init():
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

