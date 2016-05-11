
extends Button

onready var game = get_node("/root/Game")
var hire_manager

onready var selectors = [
get_parent().get_node("TabContainer/Doctor/DoctorSelector"),
get_parent().get_node("TabContainer/Nurse/NurseSelector"),
get_parent().get_node("TabContainer/Handymen/HandymenSelector"),
get_parent().get_node("TabContainer/Receptionist/ReceptionistSelector")]

onready var tab_selected = get_parent().get_node("TabContainer")

func addBodyStaff(id):
	for i in range(selectors[id].get_item_count()):
		if selectors[id].get_selected() == i && is_pressed():
			hire_manager.createStaffBody(selectors[id].get_selected_ID())
			selectors[id].remove_item(i)
			selectors[id].set_text("Employee")

func init():
	hire_manager = game.scene.hire_manager

func _on_Engage_pressed():
	addBodyStaff(get_parent().get_node("TabContainer").get_current_tab())
