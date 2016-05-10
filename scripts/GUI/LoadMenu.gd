
extends Control

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var buttons = get_node("Panel/Buttons")

func _ready():
	if loader.checkPlayerFolder():
		var count = 0
		for idx in buttons.get_children():
			if loader.checkPlayerFile(count):
				idx.set_disabled(false)
				loader.setFilename(count)
				idx.set_text(loader.getSavename())
			count += 1

func _on_Back_to_menu_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")

func setLoad(idx):
	game.save_to_load = idx
	game.new_game = false
	loader.loadPlayer(idx)
	game.goToScene("res://scenes/gamescn.scn")

func _on_Quicksave_pressed():
	setLoad(0)

func _on_Save1_pressed():
	setLoad(1)

func _on_Save2_pressed():
	setLoad(2)

func _on_Save3_pressed():
	setLoad(3)

func _on_Save4_pressed():
	setLoad(4)

func _on_Save5_pressed():
	setLoad(5)

func _on_Save6_pressed():
	setLoad(6)

func _on_Save7_pressed():
	setLoad(7)
