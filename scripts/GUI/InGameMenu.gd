
extends Control

func _ready():
	pass

func _on_BackToGame_pressed():
	self.hide()

func _on_BackToMenu_pressed():
	get_tree().change_scene("res://scenes/GUI/MainMenu.scn") 
