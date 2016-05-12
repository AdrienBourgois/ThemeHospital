extends Node

var gp_office = { "ID": 1, "NAME": "gp's office", "SIZE_MIN": 4, "COLOR": colors.red, "RESSOURCES": [], "OBJECTS": []}
var general_diagnosis = { "ID": 2, "NAME": "general diagnosis", "SIZE_MIN": 5, "COLOR": colors.white, "RESSOURCES": [], "OBJECTS": []}
var psychiatric = { "ID": 10, "NAME": "psychiatric", "SIZE_MIN": 5, "COLOR": colors.red, "RESSOURCES": [], "OBJECTS": []}
var pharmacy = { "ID": 11, "NAME": "pharmacy", "SIZE_MIN": 4, "COLOR": colors.pink, "RESSOURCES": [], "OBJECTS": []}
var ward = { "ID": 12, "NAME": "ward", "SIZE_MIN": 6, "COLOR": colors.white, "RESSOURCES": [], "OBJECTS": []}
var inflation = { "ID": 20, "NAME": "inflation", "SIZE_MIN": 4, "COLOR": colors.purple, "RESSOURCES": [], "OBJECTS": []}
var staff_room = { "ID": 30, "NAME": "staff room", "SIZE_MIN": 4, "COLOR": colors.purple, "RESSOURCES": [], "OBJECTS": []}
var toilets = { "ID": 31, "NAME": "toilets", "SIZE_MIN": 4, "COLOR": colors.white, "RESSOURCES": [], "OBJECTS": []}

var diagnosis_rooms = {"GP_OFFICE": gp_office, "GENERAL_DIAGNOSIS": general_diagnosis}
var treatment_rooms = {"PSYCHIATRIC": psychiatric, "PHARMACY": pharmacy, "WARD": ward}
var clinics = {"INFLATION": inflation}
var facilities = {"STAFF_ROOM": staff_room, "TOILETS": toilets}
