extends Node

var lobby = { 
	"ID": 0,
	"NAME": "lobby",
	"COLOR": colors.grey,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var gp_office = { 
	"ID": 1,
	"NAME": "ROOM_GP",
	"SIZE_MIN": 4,
	"COLOR": colors.red,
	"COST": 2500,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var general_diagnosis = { 
	"ID": 2,
	"NAME": "general diagnosis",
	"SIZE_MIN": 5,
	"COLOR": colors.white,
	"COST": 1000,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var psychiatric = { 
	"ID": 10,
	"NAME": "psychiatric",
	"SIZE_MIN": 5,
	"COLOR": colors.blue,
	"COST": 2500,
	"RESSOURCES": {}, 
	"OBJECTS": {}
}

var pharmacy = { 
	"ID": 11,
	"NAME": "pharmacy",
	"SIZE_MIN": 4,
	"COLOR": colors.pink,
	"COST": 1500,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var ward = { 
	"ID": 12,
	"NAME": "ward",
	"SIZE_MIN": 6,
	"COLOR": colors.yellow,
	"COST": 2000,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var inflation = { 
	"ID": 20,
	"NAME": "inflation",
	"SIZE_MIN": 4,
	"COLOR": colors.purple,
	"COST": 4000,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var staff_room = { 
	"ID": 30,
	"NAME": "staff room",
	"SIZE_MIN": 4,
	"COLOR": colors.brown,
	"COST": 1500,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var toilets = {
	"ID": 31,
	"NAME": "toilets",
	"SIZE_MIN": 4,
	"COLOR": colors.black,
	"COST": 1500,
	"RESSOURCES": {},
	"OBJECTS": {}
}

var grass = {
	"ID": 40,
	"NAME": "grass",
	"COLOR": colors.green,
	"RESSOURCES": {}
}

var pavement = {
	"ID": 41,
	"NAME": "pavement",
	"COLOR": colors.grey,
	"RESSOURCES": {}
}

var diagnosis_rooms = {
	"ROOM_GP": gp_office,
	"ROOM_GENERAL_DIAGNOSIS": general_diagnosis
}

var treatment_rooms = {
	"ROOM_PSYCHIATRIC": psychiatric,
	"ROOM_PHARMACY": pharmacy,
	"ROOM_WARD": ward
}

var clinics = {
	"ROOM_INFLATION": inflation
}

var facilities = {
	"ROOM_STAFF_ROOM": staff_room,
	"ROOM_TOILETS": toilets
}

var decorations = {
	"GRASS": grass,
	"PAVEMENT": pavement
}

var type_rooms = {
	"TREATMENT": treatment_rooms,
	"DIAGNOSIS": diagnosis_rooms,
	"CLINICS": clinics,
	"FACILITIES": facilities
}

func getRoomFromId(room_id):
	if (room_id == 0):
		return lobby
	elif (room_id == 1):
		return gp_office
	elif (room_id == 2):
		return general_diagnosis
	elif (room_id == 10):
		return psychiatric
	elif (room_id == 11):
		return pharmacy
	elif (room_id == 12):
		return ward
	elif (room_id == 20):
		return inflation
	elif (room_id == 30):
		return staff_room
	elif (room_id == 31):
		return toilets