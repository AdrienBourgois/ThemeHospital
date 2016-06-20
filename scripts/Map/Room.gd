
extends Node

var tiles = []
var size_x = 0
var size_y = 0
var type = 0
var construted = 0
var present_staff = []
var present_patient = []
var is_occuped = false

var map_reference = null
var game = null

var reference_wall_tile = {}

func _init(from, to, _type, _map_reference):
	map_reference = _map_reference
	game = map_reference.game
	type = _type
	
	tiles = map_reference.get_list(from, to)
	
	for tile in tiles:
		tile.update(type)
	
	for tile in tiles:
		tile.update_walls("Up")
		tile.update_walls("Left")
		tile.update_walls("Right")
		tile.update_walls("Down")

func enable_place_door():
	for tile in tiles:
		for wall_key in tile.walls:
			var wall = tile.walls[wall_key]
			if(wall):
				wall.static_body.connect("input_event", wall, "place_door")
				wall.room = self
				reference_wall_tile[wall] = tile

func place_door(wall):
	for tile in tiles:
		for wall_key in tile.walls:
			var wall = tile.walls[wall_key]
			if(wall):
				wall.static_body.disconnect("input_event", wall, "place_door")
	
	var tile = reference_wall_tile[wall]
	for wall_key in tile.walls:
		if (tile.walls[wall_key] == wall):
			tile.change_wall(wall_key, tile.enum_wall_type.DOOR)
	
	reference_wall_tile.clear()
	place_objects()

func place_objects():
	var temp_array = game.scene.getTempObjectsNodesArray()
	
	temp_array.append(game.scene.getObjectResources().createRoomObject(map_reference.getActualRoomTypeName()))
	temp_array[0].is_selected = true
	temp_array[0].can_selected = true
	temp_array[0].set_process_input(true)
	for current in temp_array:
		game.scene.map.add_child(current)
	if (!temp_array.empty()):
		temp_array[0].hideOtherObjects()
		game.scene.setHaveObject(true)
