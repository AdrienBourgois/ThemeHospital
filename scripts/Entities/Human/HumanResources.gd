
extends Node

var doctor_res = load("res://scenes/Entities/Human.scn")
var nurse_res = load("res://scenes/Entities/Nurse.scn")
var handyman_res = load("res://scenes/Entities/Handymen.scn")
var receptionist_res = load("res://scenes/Entities/Receptionist.scn")
var patient_res = load("res://scenes/Entities/Patient.scn")

func getStaff(id):
	var node
	if (id == 1):
		node = doctor_res.instance()
	elif (id == 2):
		node = nurse_res.instance()
	elif (id == 3):
		node = handyman_res.instance()
	elif (id == 4):
		node = receptionist_res.instance()
	else:
		node = null
	return node

func getHumand():
	pass