
extends Panel

onready var game = get_node("/root/Game")
onready var staff_selected = game.scene.hire_manager.staff_selected

func _ready():
	if staff_selected != null:
		set_process(true)
	else:
		set_process(false)

func _process(delta):
	get_node("NameStaff").set_text(staff_selected.name)
	get_node("Happiness").set_val(staff_selected.happiness)
	get_node("Tireness").set_val(staff_selected.tireness)
	get_node("Skill").set_val(staff_selected.skill)
	if staff_selected.id == 0:
		get_node("Seniority").set_val(staff_selected.seniority)
	get_node("Salary").set_text(str(staff_selected.salary))
	pass