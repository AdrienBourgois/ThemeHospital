
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
	for i in range(buttons_array.size()):
		buttons_array[i].set_pressed(false)
	get_parent().get_parent().get_node("StaffInformation/ShowingStaffInfo").hide()


func addBodyStaff(type, idx):
	hire_manager.createStaffBody(type, idx)
	hire_manager.staff_array[type].remove(idx)
	for i in range(buttons_array.size()):
		if buttons_array[i].is_pressed():
			staff_buttons.getAndShowInformation(type, 0)

func _on_Hire_pressed():
	for i in range(buttons_array.size()):
		if buttons_array[i].is_pressed() && hire_manager.staff_array[i].size() != 0:
			if game.scene.player.money >= hire_manager.staff_array[i][get_parent().idx].salary:
				waitToAdd(i, get_parent().idx)
			else:
				game.feedback.display("FEEDBACK_ENOUGH_MONEY")