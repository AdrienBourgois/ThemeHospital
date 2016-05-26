
extends Button



func _on_Nurse_toggled( pressed ):
	get_parent().get_parent().getAndShowInformation(1, 0)
	get_parent().get_parent().get_parent().get_node("HireButton").idx = 0
