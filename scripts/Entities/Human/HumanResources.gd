
extends Node

var doctor_res = preload("res://scenes/Entities/Human/Staff/Doctor.scn")
var nurse_res = preload("res://scenes/Entities/Human/Staff/Nurse.scn")
var handyman_res = preload("res://scenes/Entities/Human/Staff/Handymen.scn")
var receptionist_res = preload("res://scenes/Entities/Human/Staff/Receptionist.scn")
var patient_res = preload("res://scenes/Entities/Human/Patient.scn")

func createHuman(id):
	var node = null
	if (id == 0):
		node = doctor_res.instance()
	elif (id == 1):
		node = nurse_res.instance()
	elif (id == 2):
		node = handyman_res.instance()
	elif (id == 3):
		node = receptionist_res.instance()
	elif (id == 4):
		node = patient_res.instance()
	else:
		node = null
	return node