
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
var array_scn = [benchscn, plantscn, radiatorscn, drinkscn, firescn, receptiondeskscn]

var toiletsscn = preload("res://scenes/Entities/Objects/Toilets.scn")
var temp_array = null setget getTempArray, setTempArray

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
	else:
		node = createRoomObject(name)
	return node

func createRoomObject(name):
	var node = null
	if (name == "ROOM_GP" or name == "Desk"):
		node = deskscn.instance()
		var locker = locker_scn.instance()
		var gp_chair = gp_chair_scn.instance()
		temp_array.append(locker)
		temp_array.append(gp_chair)
	elif (name == "ROOM_TOILETS" or name == "Toilets"):
		node = toiletsscn.instance()
	elif (name == "ROOM_GENERAL_DIAGNOSIS" or name == "CrashTrolley"):
		node = crash_trolley_scn.instance()
	elif (name == "ROOM_PHARMACY" or name == "PharmacyCabinet"):
		node = pharmacy_cabinet_scn.instance()
	elif (name == "ROOM_PSYCHIATRIC" or name == "Psychiatric"):
		node = psychiatricscn.instance()
	elif (name == "ROOM_WARD" or name == "Bed"):
		node = bedscn.instance()
	elif (name == "ROOM_CARDIOGRAM" or name == "Treadmill"):
		node = treadmillscn.instance()
	elif (name == "ROOM_OPERATING" or name == "OperatingTheater"):
		node = operatingscn.instance()
	elif (name == "ROOM_INFLATION" or name == "GasBottle"):
		node = gasbottlescn.instance()
	elif (name == "ROOM_TONGUE" or name == "TongueMachine"):
		node = tongue_machine_scn.instance()
	elif (name == "ROOM_STAFF_ROOM" or name == "Sofa"):
		node = sofascn.instance()
	elif (name == "ROOM_RESEARCH" or name == "ResearchMachine"):
		node = research_machine_scn.instance()
	else:
		node = objectscn.instance()
	return node

func getTempArray():
	return temp_array

func setTempArray(array):
	temp_array = array

func returnPlant():
	var node = plantscn.instance()
	return node