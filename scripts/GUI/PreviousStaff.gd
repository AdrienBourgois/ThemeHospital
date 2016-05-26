
extends Button

onready var staff_buttons = get_parent().get_parent().get_node("StaffButtons")
onready var buttons_array = [staff_buttons.get_node("VBoxContainer/Doctor"),
staff_buttons.get_node("VBoxContainer/Nurse"),
staff_buttons.get_node("VBoxContainer/Handymen"),
staff_buttons.get_node("VBoxContainer/Receptionist")]

func _on_PreviousButton_pressed():
	get_parent().idx -= 1
	for i in range(buttons_array.size()):
		if buttons_array[i].is_pressed():
			if get_parent().idx >= 0:
				staff_buttons.getAndShowInformation(i, get_parent().idx)
			else:
				get_parent().idx += 1
