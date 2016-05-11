
extends Spatial

onready var last_name = ["CRAMBLIN", "WARMOND", "CRABINGTON", "SCOTE", "WRIGHTSON", "HIGHTON", "BURMORE", "BANE", "KINGSMITH", "PETCLIFFE", "PODMAN", "FENTON", "GOLDBERRY", "BYSON", "WATERS", "WRIGHTMORE", "BYTON", "BINNWICK", "WYERS", "CURLAN", "BOYBAUM", "CRABELTON", "WATERSON", "HIGHLEY", "PODINGTON"]
onready var first_name = ["A. ", "B. ", "C. ", "D. ", "E. ", "F. ", "G. ", "H. ", "I. ", "J. ", "K. ", "L. ", "M. ", "N. ", "O. ", "P. ", "Q. ", "R. ", "S. ", "T. ", "U. ", "V. ", "W. ", "X. ", "Y. ", "Z. "]

onready var staff_id = {
DOCTOR = 0,
NURSE = 1,
HANDYMEN = 2,
RECEPTIONIST = 3
}

onready var entity_id = {
STAFF = 0,
PATIENT = 1
}

onready var staff_array = []

func _ready():
	var id = 0
	randomize()
	for i in range(28):
		id = randi()%4
		staff_array.push_back(generateStaffData(id))

func generateStaffData(id):
	var staff_data = {}
	staff_data["type"] = id
	staff_data["name"] = first_name[randi()%first_name.size()] + last_name[randi()%last_name.size()]
	staff_data["skill"] = randi()%1000
	return staff_data

