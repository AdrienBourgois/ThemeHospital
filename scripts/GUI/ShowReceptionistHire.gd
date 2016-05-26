
extends Button



func _on_Receptionist_toggled( pressed ):
	get_parent().get_parent().getAndShowInformation(3, 0)
	get_parent().get_parent().get_parent().get_node("HireButton").idx = 0
