
extends Control

onready var game = get_node("/root/Game")
onready var options_menu = get_parent()
onready var enable_button = get_node("EnableButton")
onready var disable_button = get_node("DisableButton")

var config

func _ready():
	if game.config.fullscreen:
		enable_button.set_pressed(true)
		enable_button.set_disabled(true)
	else:
		disable_button.set_pressed(true)
		disable_button.set_disabled(true)

func _on_Enable_pressed():
	disable_button.set_pressed(false)
	disable_button.set_disabled(false)
	enable_button.set_disabled(true)
	game.config.fullscreen = true
	options_menu.apply_button.set_disabled(false)


func _on_Disable_pressed():
	enable_button.set_pressed(false)
	enable_button.set_disabled(false)
	disable_button.set_disabled(true)
	game.config.fullscreen = false
	options_menu.apply_button.set_disabled(false)