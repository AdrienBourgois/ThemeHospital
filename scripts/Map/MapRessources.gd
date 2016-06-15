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
	"STAFF": [],
	"RESSOURCES": "res://assets/GPdesk.png",
	"OBJECTS": {}
}

var general_diagnosis = {
	"ID": 2,
	"NAME": "ROOM_GENERAL_DIAGNOSIS",
	"SIZE_MIN": 5,
	"COLOR": colors.white,
	"COST": 1000,
	"TOOLTIP": "TOOLTIP_GENERAL_DIAGNOSIS",
	"STAFF": [],
	"RESSOURCES": "res://assets/CrashTrolley.png",
	"OBJECTS": {}
}

var cardiogram = {
	"ID": 3,
	"NAME": "ROOM_CARDIOGRAM",
	"SIZE_MIN": 4,
	"COLOR": colors.red,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_CARDIOGRAM",
	"STAFF": [],
	"RESSOURCES": "res://assets/Cardio.png",
	"OBJECTS": {}
}

var psychiatric = {
	"ID": 10,
	"NAME": "ROOM_PSYCHIATRIC",
	"SIZE_MIN": 5,
	"COLOR": colors.blue,
	"COST": 2500,
	"TOOLTIP": "TOOLTIP_PSYCHIATRIC",
	"STAFF": [],
	"RESSOURCES": "res://assets/Psychatric.png", 
	"OBJECTS": {}
}

var pharmacy = {
	"ID": 11,
	"NAME": "ROOM_PHARMACY",
	"SIZE_MIN": 4,
	"COLOR": colors.pink,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_PHARMACY",
	"STAFF": [],
	"RESSOURCES": "res://assets/Pharmacy.png",
	"OBJECTS": {}
}

var ward = {
	"ID": 12,
	"NAME": "ROOM_WARD",
	"SIZE_MIN": 6,
	"COLOR": colors.yellow,
	"COST": 2000,
	"TOOLTIP": "TOOLTIP_WARD",
	"STAFF": [],
	"RESSOURCES": "res://assets/Bed.png",
	"OBJECTS": {}
}

var operating = {
	"ID": 13,
	"NAME": "ROOM_OPERATING",
	"SIZE_MIN": 6,
	"COLOR": colors.white,
	"COST": 8000,
	"TOOLTIP": "TOOLTIP_OPERATING",
	"STAFF": [],
	"RESSOURCES": "res://assets/Operating.png",
	"OBJECTS": {}
}

var inflation = {
	"ID": 20,
	"NAME": "ROOM_INFLATION",
	"SIZE_MIN": 4,
	"COLOR": colors.purple,
	"COST": 4000,
	"TOOLTIP": "TOOLTIP_INFLATION",
	"STAFF": [],
	"RESSOURCES": "res://assets/Inflation.png",
	"OBJECTS": {}
}

var tongue = {
	"ID": 21,
	"NAME": "ROOM_TONGUE",
	"SIZE_MIN": 4,
	"COLOR": colors.purple,
	"COST": 3000,
	"TOOLTIP": "TOOLTIP_TONGUE",
	"STAFF": [],
	"RESSOURCES": "res://assets/Tongue.png",
	"OBJECTS": {}
}

var staff_room = {
	"ID": 30,
	"NAME": "ROOM_STAFF_ROOM",
	"SIZE_MIN": 4,
	"COLOR": colors.brown,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_STAFF_ROOM",
	"STAFF": [],
	"RESSOURCES": "res://assets/Sofa.png",
	"OBJECTS": {}
}

var toilets = {
	"ID": 31,
	"NAME": "ROOM_TOILETS",
	"SIZE_MIN": 4,
	"COLOR": colors.black,
	"COST": 1500,
	"TOOLTIP": "TOOLTIP_TOILETS",
	"STAFF": [],
	"RESSOURCES": "res://assets/Toilets.png",
	"OBJECTS": {}
}

var research = {
	"ID": 32,
	"NAME": "ROOM_RESEARCH",
	"SIZE_MIN": 5,
	"COLOR": colors.white,
	"COST": 5000,
	"TOOLTIP": "TOOLTIP_RESEARCH",
	"STAFF": [],
	"RESSOURCES": "res://assets/Research.png",
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
	"WARD": ward,
	"PSYCHIATRIC": psychiatric,
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

var rooms_array = [lobby, gp_office, general_diagnosis, cardiogram, psychiatric, pharmacy, ward, operating, inflation, tongue, staff_room, toilets, research, grass, pavement, plot] 

func getRoomFromId(room_id):
	for current in rooms_array:
		if (current.ID == room_id):
			return current
	return lobby


func getCostFromId(room_id):
	for current in rooms_array:
		if (current.ID == room_id):
			return current.COST
	return 0