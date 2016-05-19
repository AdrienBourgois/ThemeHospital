
extends Button

onready var hud = get_parent().get_parent().get_node("HUD")

func _on_Exit_pressed():
	get_parent().hide()
	hud.show()