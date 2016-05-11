
extends Spatial

onready var game = get_node("/root/Game")
onready var staff_res = load("res://scenes/Entities/Human/Staff.scn")
var staff_array
var staff_body

func setStaffArray(new_staff_array):
	staff_array = new_staff_array

func createStaffBody(index):
	staff_body = staff_res.instance()
	staff_body.id = staff_array[index]["type"]
	staff_body.name = staff_array[index]["name"]
	staff_body.skill = staff_array[index]["skill"]
	add_child(staff_body)
	staff_body.add_to_group("Staff")
	pass

func sackStaff():
	for i in range(get_child_count()):
		if get_child(i).is_selected == true:
			remove_child(get_child(i))