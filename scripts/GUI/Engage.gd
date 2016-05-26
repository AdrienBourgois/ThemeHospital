
extends Button

onready var game = get_node("/root/Game")
onready var hire_manager = game.scene.hire_manager
onready var staff_buttons = get_parent().get_parent().get_node("StaffButtons")
onready var buttons_array = [staff_buttons.get_node("VBoxContainer/Doctor"),
staff_buttons.get_node("VBoxContainer/Nurse"),
staff_buttons.get_node("VBoxContainer/Handymen"),
staff_buttons.get_node("VBoxContainer/Receptionist")]

func waitToAdd(type, id):
	get_parent().get_parent().hide()
	addBodyStaff(type, id)

func addBodyStaff(type, idx):
	hire_manager.createStaffBody(type, idx)

func _on_Hire_pressed():
	for i in range(buttons_array.size()):
		if buttons_array[i].is_pressed():
			waitToAdd(i, get_parent().idx)
