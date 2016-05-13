
extends Control

onready var save_location = get_node("SaveLocation")
onready var saver = get_node("/root/Save")

func _ready():
	for idx in save_location.get_children():
		idx.connect("mouse_enter", self, "_on_mouse_enter")
		idx.connect("mouse_exit", self, "_on_mouse_exit")

func _on_SaveButton_pressed():
	save_location.set_hidden(not save_location.is_hidden())

func save(idx):
	saver.savePlayer(idx)
	save_location.hide()

func _on_Save1_pressed():
	save(1)

func _on_Save2_pressed():
	save(2)

func _on_Save3_pressed():
	save(3)

func _on_Save4_pressed():
	save(4)

func _on_Save5_pressed():
	save(5)

func _on_Save6_pressed():
	save(6)

func _on_Save7_pressed():
	save(7)

func _on_Save8_pressed():
	save(8)

func _on_mouse_enter():
	save_location.show()

func _on_mouse_exit():
	save_location.hide()
