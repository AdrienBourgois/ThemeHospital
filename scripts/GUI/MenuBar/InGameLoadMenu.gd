
extends Control

onready var game = get_node("/root/Game")
onready var load_location = get_node("LoadLocation")
onready var loader = get_node("/root/Load")
onready var load_button = get_node("LoadButton")

func _ready():
	if !game.multiplayer:
		enableButtons()
		for idx in load_location.get_children():
			idx.connect("mouse_enter", self, "_on_mouse_enter")
			idx.connect("mouse_exit", self, "_on_mouse_exit")

func enableButtons():
	var count = 1
	if loader.checkPlayerFolder():
		load_button.set_disabled(false)
		for idx in load_location.get_children():
			if loader.checkPlayerFile(count):
				idx.set_disabled(false)
			count += 1

func loadGame(idx):
	game.save_to_load = idx
	game.new_game = false
	loader.loadPlayer(idx)
	game.goToScene("res://scenes/gamescn.scn")

func _on_LoadButton_pressed():
	load_location.show()

func _on_mouse_enter():
	load_location.show()

func _on_mouse_exit():
	load_location.hide()

func _on_Load_pressed():
	var count = 1
	for idx in load_location.get_children():
		if idx.is_pressed():
			loadGame(count)
			return
		count += 1

func _on_Load_auto_pressed():
	loadGame(10)