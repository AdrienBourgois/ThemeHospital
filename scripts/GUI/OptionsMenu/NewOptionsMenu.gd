
extends Control

onready var loader = get_node("/root/Load")
onready var save = get_node("/root/Save")
onready var apply_button = get_node("./Panel/ApplyButton")
onready var language_node = get_node("./Panel/LanguageOptionsBox/LanguageOptionButton")

var has_changed = false

func _on_ApplyButton_pressed():
	save.setInit()
	loader.applyConfig()
	apply_button.set_disabled(true)
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/OptionsMenu.scn")


func _on_BackButton_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")


func applyLanguage():
	var language_id = language_node.get_selected_ID()
	
	if (language_id == 0):
		TranslationServer.set_locale("fr")
	elif (language_id == 1):
		TranslationServer.set_locale("en")