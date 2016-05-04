
extends Control

onready var loader = get_node("/root/Load")
onready var save = get_node("/root/Save")
onready var apply_button = get_node("ApplyButton")

var has_changed = false

func _ready():
	pass


func _on_ApplyButton_pressed():
	save.setInit()
	loader.applyConfig()
	apply_button.set_disabled(true)


func _on_Back_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")