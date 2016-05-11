
extends Button

func _on_HireExit_pressed():
	get_parent().get_node("TabContainer").hide()
	get_parent().get_node("Engage").hide()
	hide()
