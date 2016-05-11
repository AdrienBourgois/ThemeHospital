
extends TabContainer

onready var game = get_node("/root/Game")
var hire_manager
var entity_manager
onready var selector = [get_node("Doctor/DoctorSelector"),
get_node("Nurse/NurseSelector"),
get_node("Handymen/HandymenSelector"),
get_node("Receptionist/ReceptionistSelector")]
var idx = 0

func init():
	hire_manager = game.scene.hire_manager
	entity_manager = game.scene.entity_manager
	for i in range(hire_manager.staff_array.size()):
		selector[hire_manager.staff_array[i]["type"]].add_item("name: " + hire_manager.staff_array[i]["name"], idx)
		idx += 1
