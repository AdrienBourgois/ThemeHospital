
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")

func _ready():
	loader.gamescn = self
	saver.gamescn = self
	pass