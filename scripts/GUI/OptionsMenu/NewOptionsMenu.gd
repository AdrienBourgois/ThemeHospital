
extends Control

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var save = get_node("/root/Save")
onready var apply_button = get_node("./Panel/ApplyButton")
onready var language_node = get_node("./Panel/General/LanguageOptionsBox/LanguageOptionButton")

var has_changed = false
onready var menu_button = get_node("Panel/BackToMenuButton")
onready var game_button = get_node("Panel/BackToGameButton")

onready var general_options = get_node("Panel/General")
onready var general_button = get_node("Panel/GeneralButton")
onready var commands_options = get_node("Panel/CommandsMenu")
onready var commands_button = get_node("Panel/CommandButton")

var in_game = false


func _on_ApplyButton_pressed():
	commands_options.setAllNewInput()
	save.setInit()
	loader.applyConfig()
	apply_button.set_disabled(true)
	applyQuit()


func applyLanguage():
	var language_id = language_node.get_selected_ID()
	
	if (language_id == 0):
		TranslationServer.set_locale("fr")
	elif (language_id == 1):
		TranslationServer.set_locale("en")


func setInGame():
	menu_button.hide()
	game_button.show()
	language_node.set_disabled(true)
	in_game = true


func _on_BackToMenuButton_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")


func _on_BackToGameButton_pressed():
	if game && game.scene :
		queue_free()
		game.scene.remove_child(self)


func applyQuit():
	if !in_game:
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/GUI/OptionsMenu.scn")
	else:
		if game && game.scene :
			queue_free()
			game.scene.remove_child(self)


func setGeneral(state):
	general_options.set_hidden(!state)
	general_button.set_disabled(state)


func setCommands(state):
	commands_options.set_hidden(!state)
	commands_button.set_disabled(state)


func _on_GeneralButton_pressed():
	setGeneral(true)
	setCommands(false)


func _on_CommandButton_pressed():
	setGeneral(false)
	setCommands(true)