
extends Panel

onready var hud = get_parent().get_node("HUD")

func _on_Quit_pressed():
	hud.show()
	hide()