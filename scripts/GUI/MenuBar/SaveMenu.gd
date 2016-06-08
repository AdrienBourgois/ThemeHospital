
extends Control

onready var game = get_node("/root/Game")
onready var save_location = get_node("SaveLocation")
onready var saver = get_node("/root/Save")
onready var save_button = get_node("SaveButton")
onready var load_menu = get_node("../Load_control")

var saving_game = null


func _ready():
	if !game.multiplayer:
		createButtons()
		save_button.set_disabled(false)

func _on_SaveButton_pressed():
	save_location.show()

func save(idx):
	saver.savePlayer(idx)
	save_location.hide()
	saving_game.showComplete()
	load_menu.enableButtons()

func _on_Save_pressed():
	getSavingGui()
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


func createButtons():
	for index in range ( 8 ):
		var button = Button.new()
		button.set_h_size_flags(SIZE_EXPAND_FILL)
		
		button.connect("mouse_enter", self, "_on_mouse_enter")
		button.connect("mouse_exit", self, "_on_mouse_exit")
		button.connect("pressed", self, "_on_Save_pressed")
		
		if (index != 8):
			button.set_text(tr("BTN_SAVE") + str(index + 1))
		
		save_location.add_child(button)


func getSavingGui():
	if ( game != null):
		saving_game = game.scene.get_node("SavingGameGUI")