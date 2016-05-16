
extends Control

onready var game = get_node("/root/Game")
onready var load_location = get_node("LoadLocation")
onready var loader = get_node("/root/Load")

func _ready():
	if !game.multiplayer:
		for idx in load_location.get_children():
			idx.connect("mouse_enter", self, "_on_mouse_enter")
			idx.connect("mouse_exit", self, "_on_mouse_exit")
	else:
		hide()

func _on_SaveButton_pressed():
	load_location.show()

func _on_mouse_enter():
	load_location.show()

func _on_mouse_exit():
	load_location.hide()