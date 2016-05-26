
extends Button

func _on_Doctor_toggled( pressed ):
	get_parent().get_parent().getAndShowInformation(0, 0)
	get_parent().get_parent().get_parent().get_node("HireButton").idx = 0
