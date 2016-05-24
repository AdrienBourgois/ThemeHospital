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
	"TOOLTIP": "TOOLTIP_GP",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var general_diagnosis = { 
	"ID": 2,
	"NAME": "ROOM_GENERAL_DIAGNOSIS",
	"SIZE_MIN": 5,
	"COLOR": colors.white,
	"COST": 1000,
	"TOOLTIP": "TOOLTIP_GENERAL_DIAGNOSIS",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var cardiogram = { 
	"ID": 3,
	"NAME": "ROOM_CARDIOGRAM",
	"SIZE_MIN": 4,
	"COLOR": colors.red,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_CARDIOGRAM",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var psychiatric = { 
	"ID": 10,
	"NAME": "ROOM_PSYCHIATRIC",
	"SIZE_MIN": 5,
	"COLOR": colors.blue,
	"COST": 2500,
	"TOOLTIP": "TOOLTIP_PSYCHIATRIC",
	"RESSOURCES": {}, 
	"OBJECTS": {}
}

var pharmacy = { 
	"ID": 11,
	"NAME": "ROOM_PHARMACY",
	"SIZE_MIN": 4,
	"COLOR": colors.pink,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_PHARMACY",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var ward = { 
	"ID": 12,
	"NAME": "ROOM_WARD",
	"SIZE_MIN": 6,
	"COLOR": colors.yellow,
	"COST": 2000,
	"TOOLTIP": "TOOLTIP_WARD",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var operating = {
	"ID": 13,
	"NAME": "ROOM_OPERATING",
	"SIZE_MIN": 6,
	"COLOR": colors.white,
	"COST": 8000,
	"TOOLTIP": "TOOLTIP_OPERATING",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var inflation = { 
	"ID": 20,
	"NAME": "ROOM_INFLATION",
	"SIZE_MIN": 4,
	"COLOR": colors.purple,
	"COST": 4000,
	"TOOLTIP": "TOOLTIP_INFLATION",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var tongue = {
	"ID": 21,
	"NAME": "ROOM_TONGUE",
	"SIZE_MIN": 4,
	"COLOR": colors.purple,
	"COST": 3000,
	"TOOLTIP": "TOOLTIP_TONGUE",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var staff_room = { 
	"ID": 30,
	"NAME": "ROOM_STAFF_ROOM",
	"SIZE_MIN": 4,
	"COLOR": colors.brown,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_STAFF_ROOM",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var toilets = {
	"ID": 31,
	"NAME": "ROOM_TOILETS",
	"SIZE_MIN": 4,
	"COLOR": colors.black,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_TOILETS",
	"RESSOURCES": {},
	"OBJECTS": {}
}

var research = {
	"ID": 32,
	"NAME": "ROOM_RESEARCH",
	"SIZE_MIN": 5,
	"COLOR": colors.white,
	"COST": 5000,
	"TOOLTIP": "TOOLTIP_RESEARCH",
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

var plot = {
	"ID": 42,
	"NAME": "plot",
	"COLOR": colors.grey,
	"RESSOURCES": {}
}

var diagnosis_rooms = {
	"GP": gp_office,
	"GENERAL_DIAGNOSIS": general_diagnosis,
	"CARDIOGRAM": cardiogram,
}

var treatment_rooms = {
	"PSYCHIATRIC": psychiatric,
	"PHARMACY": pharmacy,
	"WARD": ward,
	"OPERATING": operating,
}

var clinics = {
	"INFLATION": inflation,
	"TONGUE": tongue,
}

var facilities = {
	"STAFF_ROOM": staff_room,
	"TOILETS": toilets,
	"RESEARCH": research,
}

var decorations = {
	"GRASS": grass,
	"PAVEMENT": pavement
}

var type_rooms = {
	"TYPE_TREATMENT": treatment_rooms,
	"TYPE_DIAGNOSIS": diagnosis_rooms,
	"TYPE_CLINICS": clinics,
	"TYPE_FACILITIES": facilities
}

func getRoomFromId(room_id):
	if (room_id == 0):
		return lobby
	elif (room_id == 1):
		return gp_office
	elif (room_id == 2):
		return general_diagnosis
	elif (room_id == 3):
		return cardiogram
	elif (room_id == 10):
		return psychiatric
	elif (room_id == 11):
		return pharmacy
	elif (room_id == 12):
		return ward
	elif (room_id == 13):
		return operating
	elif (room_id == 20):
		return inflation
	elif (room_id == 21):
		return tongue
	elif (room_id == 30):
		return staff_room
	elif (room_id == 31):
		return toilets
	elif (room_id == 32):
		return research
	elif (room_id == 40):
		return grass
	elif (room_id == 41):
		return pavement
	elif (room_id == 41):
		return plot
	return