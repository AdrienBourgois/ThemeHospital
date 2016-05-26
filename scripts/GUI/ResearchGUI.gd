extends Control

onready var container = get_node("Container")
onready var total = get_node("Total")
onready var hud = get_parent().get_node("HUD")

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
	set_global_value()
	
	get_clinics_locked()
	get_diagnosis_locked()

func set_global_value():
	global_value = 0
	
	for i in range(container.get_child_count()):
		var value = container.get_child(i).get_value()
		global_value += value
		
		total.set_value(global_value)

func _on_Quit_pressed():
	self.hide()
	hud.show()

func get_staff_in_research():
	if research_room.STAFF.empty():
		return
	else:
		return research_room.STAFF

func get_clinics_locked():
	for rooms in clinics:
		if (clinics[rooms].UNLOCK == false):
			clinics_array.append(clinics[rooms])
	
	return clinics_array

func get_diagnosis_locked():
	for rooms in diagnosis:
		if (diagnosis[rooms].UNLOCK == false):
			diagnosis_array.append(diagnosis[rooms])
	
	return diagnosis_array