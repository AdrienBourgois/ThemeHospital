
extends Node

onready var game = get_node("/root/Game")

func _ready():
	pass

func set_init():
	game.file.open(game.init_path, game.file.WRITE)
	game.file.store_string(game.default_config.to_json())
	game.file.close()