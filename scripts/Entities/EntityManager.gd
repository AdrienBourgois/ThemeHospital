
extends Spatial

export var spawn_time = 12


onready var game = get_node("/root/Game")
onready var salary_tab = [[75, 105, 205], 60, 25, 20]
onready var speciality_bonus_salary = [0, 20, 30, 40]
onready var last_name = ["CRAMBLIN", "WARMOND", "CRABINGTON", "SCOTE", "WRIGHTSON", "HIGHTON", "BURMORE", "BANE", "KINGSMITH", "PETCLIFFE", "PODMAN", "FENTON", "GOLDBERRY", "BYSON", "WATERS", "WRIGHTMORE", "BYTON", "BINNWICK", "WYERS", "CURLAN", "BOYBAUM", "CRABELTON", "WATERSON", "HIGHLEY", "PODINGTON"]
onready var first_name = ["A. ", "B. ", "C. ", "D. ", "E. ", "F. ", "G. ", "H. ", "I. ", "J. ", "K. ", "L. ", "M. ", "N. ", "O. ", "P. ", "Q. ", "R. ", "S. ", "T. ", "U. ", "V. ", "W. ", "X. ", "Y. ", "Z. "]
var heats = []
var nb_staff = 0
onready var timer = get_node("SpawnTimerPatient")
var count = 0

onready var staff_id = {
DOCTOR = 0,
NURSE = 1,
HANDYMEN = 2,
RECEPTIONIST = 3
}

onready var specialities_id = {
NONE = 0,
PSYCHIATRIS = 1,
RESEARCHER = 2,
SURGEON = 3
}

onready var seniority_id = {
JUNIOR = 0,
DOCTOR = 1,
CONSULTANT = 2
}

onready var entity_id = {
STAFF = 0,
PATIENT = 1
}

onready var patient_res = preload("res://scenes/Entities/Human/Patient.scn")

onready var patient_array = []
onready var staff_array = [[],[],[],[]]

func _ready():
	randomize()
	nb_staff = 28
	generateStaffIdAndDataArray(nb_staff)
	timer.set_wait_time(spawn_time/game.speed)
	game.connect("end_month", self, "_on_end_month")
	game.connect("speed_change", self, "_speed_change")

func generateStaffData(id):
	var staff_data = {}
	staff_data["entity_id"] = 0
	staff_data["type"] = id
	staff_data["name"] = first_name[randi()%first_name.size()] + last_name[randi()%last_name.size()]
	staff_data["skill"] = randi()%1000 
	if id == 0:
		staff_data["seniority"] = calculateSeniorityWithSkill(staff_data["skill"])
		staff_data["specialities"] = randi()%4
		staff_data["salary"] = calculateSalary(id, staff_data["skill"], staff_data["seniority"], staff_data["specialities"])
	else:
		staff_data["salary"] = calculateSalary(id, staff_data["skill"])
	return staff_data

func generateStaffIdAndDataArray(nb_staff):
	var id = 0
	for i in range(nb_staff):
		id = randi()%4
		staff_array[id].push_back(generateStaffData(id))

func generatePatientData():
	var patient_data = {}
	patient_data["entity_id"] = 1
	patient_data["happiness"] = 100
	patient_data["thirsty"] = 100
	patient_data["warmth"] = 40
	return patient_data

func createPatientBody():
	var patient = patient_res.instance()
	patient.happiness = patient_array[0]["happiness"]
	patient.thirsty = patient_array[0]["thirsty"]
	patient.warmth = patient_array[0]["warmth"]
	patient.set_translation(Vector3(15, 0, 45))
	add_child(patient)
	patient.add_to_group("Patients")
	patient_array.clear()

func calculateSeniorityWithSkill(skill):
	var seniority = 0
	if skill >= 1 && skill <= 249:
		seniority = seniority_id.JUNIOR
	elif skill >= 250 && skill <= 799:
		seniority = seniority_id.DOCTOR
	elif skill >= 800 && skill <= 1000:
		seniority = seniority_id.CONSULTANT
	return seniority

func calculateSalary(id, skill, seniority=0, speciality=0):
	var salary = 0
	if id == 0:
		salary = salary_tab[id][seniority] + speciality_bonus_salary[speciality] + skill/10
	else:
		salary = salary_tab[id] + skill/10
	return salary

func isInRadiatorRay(node):
	for heat in heats:
		if (node.get_translation().distance_to(heat.get_translation()) <= heat.heat_ray):
			return true

func checkGlobalTemperature(node):
	if isInRadiatorRay(node) == true:
		node.warmth = 60
	else:
		node.warmth -= 2

func _on_Timer_timeout():
	if count < 3:
		var spawn_time = rand_range(1, 20)
		patient_array.push_back(generatePatientData())
		createPatientBody()
		count += 1

func _speed_change():
	if game.speed > 0:
		timer.set_wait_time(spawn_time/game.speed)
		timer.start()

func _on_end_month():
	for id in staff_array:
		id.clear()
	generateStaffIdAndDataArray(nb_staff)