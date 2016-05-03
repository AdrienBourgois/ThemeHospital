
extends Node

onready var game = get_node("/root/Game")
onready var saver = get_node("/root/Save")
onready var loader = get_node("/root/Load")
onready var player = get_node("Player")
onready var calendar = get_node("Calendar")

func _ready():
	loader.loadInit()
	#saver.savePlayer(0)
	#loader.quickload()
	pass