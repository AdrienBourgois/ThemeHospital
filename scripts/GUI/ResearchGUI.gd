extends Control


onready var container = get_node("Container")
onready var total = get_node("Total")
onready var hud = get_parent().get_node("HUD")

onready var camera = get_node("/root/Game").scene.camera
onready var map = get_node("/root/Game").scene.map

onready var rooms_ressources = map.ressources
onready var rooms_type = rooms_ressources.type_rooms
onready var clinics = rooms_type.TYPE_CLINICS
onready var diagnosis = rooms_type.TYPE_DIAGNOSIS
onready var research_room = rooms_type.TYPE_FACILITIES.RESEARCH

var global_value = 0
var clinics_array = []
var diagnosis_array = []

func _ready():
	setGlobalValue()
	
	getClinicsLocked()
	getDiagnosisLocked()

func setGlobalValue():
	global_value = 0
	
	for i in range(container.get_child_count()):
		var value = container.get_child(i).getValue()
		global_value += value
		
		total.set_value(global_value)

func _on_Quit_pressed():
	self.hide()
	hud.show()
	camera.pause = false

func getStaffInResearchRoom():
	if research_room.STAFF.empty():
		return
	else:
		return research_room.STAFF

func getClinicsLocked():
	for rooms in clinics:
		if (clinics[rooms].UNLOCK == false):
			clinics_array.append(clinics[rooms])
	
	return clinics_array

func getDiagnosisLocked():
	for rooms in diagnosis:
		if (diagnosis[rooms].UNLOCK == false):
			diagnosis_array.append(diagnosis[rooms])
	
	return diagnosis_array