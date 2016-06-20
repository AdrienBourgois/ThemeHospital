
extends Panel

onready var game = get_node("/root/Game")
onready var staff_selected = game.scene.hire_manager.staff_selected
onready var speciality_selected = [
get_node("DoctorGui/Speciality/NoSpeciality"),
get_node("DoctorGui/Speciality/PsychiatrisString"), 
get_node("DoctorGui/Speciality/ResearcherString"),
get_node("DoctorGui/Speciality/SurgeonString")]
onready var name_staff = get_node("NameStaff")
onready var happiness = get_node("Happiness")
onready var tireness = get_node("Tireness")
onready var skill = get_node("Skill")
onready var doctor_gui = get_node("DoctorGui")
onready var handymen_gui = get_node("HandymenGui")
onready var seniority = doctor_gui.get_node("Seniority")
onready var salary = get_node("Salary")
onready var viewport = get_node("Viewport")

func _ready():
	if staff_selected != null:
		set_process(true)
	else:
		set_process(false)

func _process(delta):
	if staff_selected.id != 2:
		handymen_gui.hide()
	doctor_gui.hide()
	name_staff.set_text(staff_selected.name)
	happiness.set_val(staff_selected.happiness)
	tireness.set_val(staff_selected.tireness)
	skill.set_val(staff_selected.skill)
	salary.set_text(str(staff_selected.salary) + "$")
	if staff_selected.id == 0:
		doctor_gui.show()
		for i in speciality_selected:
			i.hide()
		seniority.set_val(staff_selected.seniority )
		if staff_selected.specialities != 0:
			speciality_selected[staff_selected.specialities].show()
	elif staff_selected.id == 2:
		handymen_gui.show()

func initViewport(node):
	viewport.node = node
	viewport.set_process(true)