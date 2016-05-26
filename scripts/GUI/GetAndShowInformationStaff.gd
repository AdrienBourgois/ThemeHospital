
extends Panel

onready var game = get_node("/root/Game")
onready var entity_manager = game.scene.entity_manager
onready var staff_gui = get_parent()
onready var showing_staff_information = staff_gui.get_node("StaffInformation/ShowingStaffInfo")
onready var name = showing_staff_information.get_node("Name")
onready var skill_bar = showing_staff_information.get_node("SkillBar")
onready var salary = showing_staff_information.get_node("Salary")
onready var doctor_speciality = showing_staff_information.get_node("DoctorSpeciality")
onready var doctor_seniority = showing_staff_information.get_node("DoctorSeniority")
onready var text_description = showing_staff_information.get_node("TextDescription")
onready var speciality_array = [doctor_speciality.get_node("Speciality/NoSpeciality"),
doctor_speciality.get_node("Speciality/Psychiatrist"), 
doctor_speciality.get_node("Speciality/Researcher"),
doctor_speciality.get_node("Speciality/Surgeon")]

func getAndShowInformation(type, idx):
	for speciality in speciality_array:
		speciality.hide()
	doctor_seniority.hide()
	doctor_speciality.hide()
	if type == 0:
		doctor_seniority.show()
		doctor_speciality.show()
		speciality_array[entity_manager.staff_array[type][idx]["specialities"]].show()
		doctor_seniority.get_node("SenioritySelector").set_val(entity_manager.staff_array[type][idx]["seniority"])
	name.set_text(entity_manager.staff_array[type][idx]["name"])
	skill_bar.set_val(entity_manager.staff_array[type][idx]["skill"])
	salary.set_text(str(entity_manager.staff_array[type][idx]["salary"]))
	showing_staff_information.show()
