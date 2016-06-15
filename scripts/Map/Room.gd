
extends Node

var tiles = []
var size_x = 0
var size_y = 0
var type = 0
var construted = 0
var present_staff = []
var present_patient = []
var is_occuped = false
var unique_id = 0 setget setUniqueID, getUniqueID

var has_door = false
var map_reference = null

func _init(from, to, _type, _map_reference):
	map_reference = _map_reference
	type = _type
	
	tiles = map_reference.get_list(from, to)
	
	for tile in tiles:
		tile.update(type)
	
	for tile in tiles:
		tile.update_walls("Up")
		tile.update_walls("Left")
		tile.update_walls("Right")
		tile.update_walls("Down")

func getUniqueID():
	return unique_id

func setUniqueID(rooms_size):
	unique_id = rooms_size