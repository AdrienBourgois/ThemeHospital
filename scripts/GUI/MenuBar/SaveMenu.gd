
extends Control

onready var game = get_node("/root/Game")
onready var save_location = get_node("SaveLocation")
onready var saver = get_node("/root/Save")
onready var saving_game = get_node("SavingGameGUI")
onready var save_button = get_node("SaveButton")

func _ready():
	if !game.multiplayer:
		save_button.set_disabled(false)
		for idx in save_location.get_children():
			idx.connect("mouse_enter", self, "_on_mouse_enter")
			idx.connect("mouse_exit", self, "_on_mouse_exit")

func _on_SaveButton_pressed():
	save_location.show()

func save(idx):
	saving_game.show()
	saving_game.showSaving()
	saver.savePlayer(idx)
	save_location.hide()
	saving_game.showComplete()

func _on_Save_pressed():
	var count = 1
	for idx in save_location.get_children():
		if idx.is_pressed():
			save(count)
			return
		count += 1

func _on_mouse_enter():
	save_location.show()

func _on_mouse_exit():
	save_location.hide()
