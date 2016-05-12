extends Node

const gp_office = { "ID": 1, "NAME": "gp's office", "SIZE_MIN": 4, "RESSOURCES": [], "OBJECTS": []}
const general_diagnosis = { "ID": 2, "NAME": "general diagnosis", "SIZE_MIN": 5, "RESSOURCES": [], "OBJECTS": []}
const psychiatric = { "ID": 10, "NAME": "psychiatric", "SIZE_MIN": 5, "RESSOURCES": [], "OBJECTS": []}
const pharmacy = { "ID": 11, "NAME": "pharmacy", "SIZE_MIN": 4, "RESSOURCES": [], "OBJECTS": []}
const ward = { "ID": 12, "NAME": "ward", "SIZE_MIN": 6, "RESSOURCES": [], "OBJECTS": []}
const inflation = { "ID": 20, "NAME": "inflation", "SIZE_MIN": 4, "RESSOURCES": [], "OBJECTS": []}
const staff_room = { "ID": 30, "NAME": "staff room", "SIZE_MIN": 4, "RESSOURCES": [], "OBJECTS": []}
const toilets = { "ID": 31, "NAME": "toilets", "SIZE_MIN": 4, "RESSOURCES": [], "OBJECTS": []}

const diagnosis_rooms = {"GP_OFFICE": gp_office, "GENERAL_DIAGNOSIS": general_diagnosis}
const treatment_rooms = {"PSYCHIATRIC": psychiatric, "PHARMACY": pharmacy, "WARD": ward}
const clinics = {"INFLATION": inflation}
const facilities = {"STAFF_ROOM": staff_room, "TOILETS": toilets}