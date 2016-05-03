
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")

func _ready():
	loader.load_init()
	saver.save_player()