
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
var game = null

var reference_wall_tile = {}
var special_wall = {
	DOOR = null,
	WINDOW = []
	}

func _init(from, to, _type, _map_reference):
	map_reference = _map_reference
	game = map_reference.game
	type = _type
	
	tiles = map_reference.getList(from, to)
	
	for tile in tiles:
		tile.update(type)
	
	for tile in tiles:
		tile.updateWalls("Up")
		tile.updateWalls("Left")
		tile.updateWalls("Right")
		tile.updateWalls("Down")

func getUniqueID():
	return unique_id

func setUniqueID(rooms_size):
	unique_id = rooms_size

func enablePlaceDoor():
	for tile in tiles:
		for wall_key in tile.walls:
			var wall = tile.walls[wall_key]
			if(wall):
				wall.static_body.connect("input_event", wall, "placeDoor")
				wall.room = self
				reference_wall_tile[wall] = tile

func placeDoor(wall):
	for tile in tiles:
		for wall_key in tile.walls:
			var wall = tile.walls[wall_key]
			if(wall):
				wall.static_body.disconnect("input_event", wall, "placeDoor")
	
	var tile = reference_wall_tile[wall]
	for wall_key in tile.walls:
		if (tile.walls[wall_key] == wall):
			tile.changeWall(wall_key, tile.enum_wall_type.DOOR)
			var door = createSpecialWall(tile.x, tile.y, wall_key, tile.enum_wall_type.DOOR)
			get_parent().getSpecialWalls().append(door)
	
	reference_wall_tile.clear()
	placeObjects()

func placeObjects():
	var object_resources = game.scene.getObjectResources()
	object_resources.setUniqueID(getUniqueID())
	object_resources.createRoomObject(map_reference.getActualRoomTypeName())
	
	var temp_array = game.scene.getTempObjectsNodesArray()
	var object = temp_array[0]
	object = object_resources.createObject(object)
	temp_array[0] = object
	game.scene.add_child(object)
	object.is_selected = true
	object.can_selected = true
	object.set_process_input(true)
	object.setUniqueID(getUniqueID())

func createSpecialWall(tile_x, tile_y, wall_key, type):
	var special_wall = {
	X = tile_x,
	Y = tile_y,
	WALL_KEY = wall_key,
	TYPE = type
	}
	return special_wall