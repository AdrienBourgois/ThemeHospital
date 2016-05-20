
extends TabContainer

onready var game = get_node("/root/Game")
onready var hire_manager = game.scene.hire_manager
onready var entity_manager = game.scene.entity_manager
onready var selector = [get_node("Doctor/DoctorSelector"),
get_node("Nurse/NurseSelector"),
get_node("Handymen/HandymenSelector"),
get_node("Receptionist/ReceptionistSelector")]
var idx = 0

func _ready():
	for i in range(hire_manager.staff_array.size()):
		selector[hire_manager.staff_array[i]["type"]].add_item("name: " + hire_manager.staff_array[i]["name"], idx)
		idx += 1