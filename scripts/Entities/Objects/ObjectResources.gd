
extends Node

var objectscn = preload("res://scenes/Entities/Objects/Object.scn")
var benchscn = preload("res://scenes/Entities/Objects/Bench.scn")
var plantscn = preload("res://scenes/Entities/Objects/Plant.scn")
var radiatorscn = preload("res://scenes/Entities/Objects/Radiator.scn")
var drinkscn = preload("res://scenes/Entities/Objects/DrinkMachine.scn") 
var firescn = preload("res://scenes/Entities/Objects/Fire.scn")
var receptiondeskscn = preload("res://scenes/Entities/Objects/ReceptionistDesk.scn")
var deskscn = preload("res://scenes/Entities/Objects/Desk.scn")
var crash_trolley_scn = preload("res://scenes/Entities/Objects/CrashTrolley.scn")
var pharmacy_cabinet_scn = preload("res://scenes/Entities/Objects/PharmacyCabinet.scn")
var psychiatricscn = preload("res://scenes/Entities/Objects/Psychiatric.scn")
var bedscn = preload("res://scenes/Entities/Objects/Bed.scn")
var treadmillscn = preload("res://scenes/Entities/Objects/Treadmill.scn")
var operatingscn = preload("res://scenes/Entities/Objects/OperatingTheater.scn")
var gasbottlescn = preload("res://scenes/Entities/Objects/GasBottle.scn")
var tongue_machine_scn = preload("res://scenes/Entities/Objects/TongueMachine.scn")
var sofascn = preload("res://scenes/Entities/Objects/Sofa.scn")
var research_machine_scn = preload("res://scenes/Entities/Objects/ResearchMachine.scn")
var locker_scn = preload("res://scenes/Entities/Objects/Locker.scn")
var gp_chair_scn = preload("res://scenes/Entities/Objects/GPChair.scn")
var ward_desk_scn = preload("res://scenes/Entities/Objects/WardDesk.scn")
var general_diagnosis_screen_scn = preload("res://scenes/Entities/Objects/GeneralDiagnosisScreen.scn")
var doorscn = preload("res://scenes/Map/Door.scn")
var windowscn = preload("res://scenes/Map/Window.scn")
var array_scn = [benchscn, plantscn, radiatorscn, drinkscn, firescn, receptiondeskscn]

var toiletsscn = preload("res://scenes/Entities/Objects/Toilets.scn")
var temp_array = null setget getTempArray, setTempArray
var unique_id = 0 setget getUniqueID, setUniqueID


func createObject(name):
	var node = null
	if (name == "Bench"):
		node = benchscn.instance()
	elif (name == "Plant"):
		node = plantscn.instance()
	elif (name == "Radiator"):
		node = radiatorscn.instance()
	elif (name == "Drink" or name == "DrinkMachine"):
		node = drinkscn.instance()
	elif (name == "Fire" or name == "FireExtinguisher"):
		node = firescn.instance()
	elif (name == "Reception Desk" or name == "ReceptionDesk"):
		node = receptiondeskscn.instance()
	elif (name == "Desk"):
		node = deskscn.instance()
	elif (name == "GPChair"):
		node = gp_chair_scn.instance()
	elif (name == "Locker"):
		node = locker_scn.instance()
	elif (name == "Bed"):
		node = bedscn.instance()
	elif (name == "WardDesk"):
		node = ward_desk_scn.instance()
	elif (name == "GeneralDiagnosisScreen"):
		node = general_diagnosis_screen_scn.instance()
	elif (name == "CrashTrolley"):
		node = crash_trolley_scn.instance()
	elif (name == "Door"):
		node = doorscn.instance()
	elif (name == "Window"):
		node = windowscn.instance()
	elif (name == "Toilet"):
		node = toiletsscn.instance()
	elif (name == "PharmacyCabinet"):
		node = pharmacy_cabinet_scn.instance()
	elif (name == "Psychiatric"):
		node = psychiatricscn.instance()
	elif (name == "Treadmill"):
		node = treadmillscn.instance()
	elif (name == "OperatingTheater"):
		node = operatingscn.instance()
	elif (name == "GasBottle"):
		node = gasbottlescn.instance()
	elif (name == "TongueMachine"):
		node = tongue_machine_scn.instance()
	elif (name == "Sofa"):
		node = sofascn.instance()
	elif (name == "ResearchMachine"):
		node = research_machine_scn.instance()
	else:
		node = createRoomObject(name)
	node.setUniqueID(unique_id)
	unique_id = 0 
	return node

func createRoomObject(name):
	var node = null
	if (name == "ROOM_GP" or name == "Desk"):
		temp_array.push_back("Desk")
		temp_array.push_back("Locker")
		temp_array.push_back("GPChair")
	elif (name == "ROOM_TOILETS" or name == "Toilets"):
		temp_array.push_back("Toilet")
	elif (name == "ROOM_GENERAL_DIAGNOSIS" or name == "CrashTrolley"):
		temp_array.push_back("CrashTrolley")
		temp_array.push_back("GeneralDiagnosisScreen")
	elif (name == "ROOM_PHARMACY"  or name == "PharmacyCabinet"):
		temp_array.push_back("PharmacyCabinet")
	elif (name == "ROOM_PSYCHIATRIC" or name == "Psychiatric"):
		temp_array.push_back("Psychiatric")
	elif (name == "ROOM_WARD" or name == "Bed"):
		temp_array.push_back("Bed")
		temp_array.push_back("WardDesk")
	elif (name == "ROOM_CARDIOGRAM" or name == "Treadmill"):
		temp_array.push_back("Treadmill")
	elif (name == "ROOM_OPERATING" or name == "OperatingTheater"):
		temp_array.push_back("OperatingTheater")
	elif (name == "ROOM_INFLATION" or name == "GasBottle"):
		temp_array.push_back("GasBottle")
	elif (name == "ROOM_TONGUE" or name == "TongueMachine"):
		temp_array.push_back("TongueMachine")
	elif (name == "ROOM_STAFF_ROOM" or name == "Sofa"):
		temp_array.push_back("Sofa")
	elif (name == "ROOM_RESEARCH" or name == "ResearchMachine"):
		temp_array.push_back("ResearchMachine")
	else:
		node = objectscn.instance()
	return node

func getUniqueID():
	return unique_id

func setUniqueID(new_id):
	unique_id = new_id

func getTempArray():
	return temp_array

func setTempArray(array):
	temp_array = array

func returnPlant():
	var node = plantscn.instance()
	return node