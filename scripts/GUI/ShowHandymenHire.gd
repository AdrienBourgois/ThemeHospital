
extends Button



func _on_Handymen_toggled( pressed ):
	get_parent().get_parent().getAndShowInformation(2, 0)
	get_parent().get_parent().get_parent().get_node("HireButton").idx = 0