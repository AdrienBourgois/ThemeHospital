
extends Control

onready var game = get_node("/root/Game")
onready var load_location = get_node("LoadLocation")
onready var loader = get_node("/root/Load")
onready var saver = get_node("/root/Save")
onready var load_button = get_node("LoadButton")

func _ready():
	if !game.multiplayer:
		createButtons()
		enableButtons()

func enableButtons():
	var count = 1
	if loader.checkPlayerFolder():
		load_button.set_disabled(false)
		for idx in load_location.get_children():
			if loader.checkPlayerFile(count):
				idx.set_disabled(false)
			count += 1

func loadGame(idx):
	loader.gamescn = null
	saver.gamescn = null
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

func createButtons():
	for index in range ( 9 ):
		var button = Button.new()
		button.set_h_size_flags(SIZE_EXPAND_FILL)
		
		button.connect("mouse_enter", self, "_on_mouse_enter")
		button.connect("mouse_exit", self, "_on_mouse_exit")
		button.connect("pressed", self, "_on_Load_pressed")
		
		if (index != 8):
			button.set_text(tr("BTN_LOAD") + str(index + 1))
		else:
			button.set_text(tr("BTN_AUTOLOAD"))
		
		button.set_disabled(true)
		load_location.add_child(button)
