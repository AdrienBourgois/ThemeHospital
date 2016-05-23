
extends Node

var objectscn = preload("res://scenes/Entities/Objects/Object.scn")
var benchscn = preload("res://scenes/Entities/Objects/Bench.scn")
var plantscn = preload("res://scenes/Entities/Objects/Plant.scn")
var radiatorscn = preload("res://scenes/Entities/Objects/Radiator.scn")
var drinkscn = preload("res://scenes/Entities/Objects/DrinkMachine.scn") 
var firescn = preload("res://scenes/Entities/Objects/Fire.scn")

func createObject(name):
	var node
	if (name == "Object"):
		node = objectscn.instance()
	elif (name == "Bench"):
		node = objectscn.instance()
	elif (name == "Plant"):
		node = objectscn.instance()
	elif (name == "Radiator"):
		node = objectscn.instance()
	elif (name == "Drink" or name == "DrinkMachine"):
		node = objectscn.instance()
	elif (name == "Fire" or name == "FireExtinguisher"):
		node = objectscn.instance()
	return node