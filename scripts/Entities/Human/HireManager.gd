
extends Spatial

onready var game = get_node("/root/Game")
onready var player = game.scene.player
onready var staff_res = [preload("res://scenes/Entities/Human/Doctor.scn"),
preload("res://scenes/Entities/Human/Nurse.scn"),
preload("res://scenes/Entities/Human/Handymen.scn"),
preload("res://scenes/Entities/Human/Receptionist.scn")]
var staff_array
var staff_body
var staff_selected

func setStaffArray(new_staff_array):
	staff_array = new_staff_array 

func createStaffBody(type, index):
	staff_body = staff_res[type].instance()
	staff_body.setID(staff_array[type][index]["type"])
	staff_body.setName(staff_array[type][index]["name"])
	staff_body.setSkill(staff_array[type][index]["skill"])
	staff_body.setSalary(staff_array[type][index]["salary"])
	if staff_array[type][index]["type"] == 0:
		staff_body.specialities = staff_array[type][index]["specialities"]
		staff_body.seniority = staff_array[type][index]["seniority"]
	game.scene.player.increaseExpense(staff_body.salary)
	add_child(staff_body)
	staff_body.add_to_group("Staff")
	
func sackStaff():
	staff_selected.deleteFromArray()
	staff_selected.sack()
	remove_child(staff_selected)

func loadStaffBody(name, id, skill, salary, seniority=0, speciality=0):
	staff_body = staff_res[id].instance()
	staff_body.setID(id)
	staff_body.setName(name)
	staff_body.setSkill(skill)
	staff_body.setSalary(salary)
	if id == 0:
		staff_body.specialities = speciality
		staff_body.seniority = seniority
	add_child(staff_body)
	staff_body.add_to_group("Staff")
	return staff_body