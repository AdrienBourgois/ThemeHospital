
extends Button

func _on_Doctor_toggled( pressed ):
	for i in range(get_parent().get_child_count()):
		get_parent().get_child(i).set_pressed(false)
	set_pressed(true)
	get_parent().get_parent().getAndShowInformation(0, 0)
	get_parent().get_parent().get_parent().get_node("HireButton").idx = 0
