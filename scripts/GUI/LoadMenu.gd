
extends Control

func _ready():
	pass

func _on_Back_to_menu_pressed():
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn")