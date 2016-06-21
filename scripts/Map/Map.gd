
extends Node

export var map_path = "res://Maps/map1.lvl"

var columns = []
var tiles = []
var rooms = []
var rooms_save = []
var rooms_array = []
var occupied_tiles = []
var corridor_tiles = []

onready var game = get_node("/root/Game/")
onready var tile_res = preload("res://scenes/Map/Tile.scn")
onready var room_class = preload("res://scripts/Map/Room.gd")
onready var ressources = preload("res://scripts/Map/MapRessources.gd").new() setget ,getResources
onready var stats = {}

var room
var special_walls = [] setget, getSpecialWalls
var new_room_from = Vector2(-1,-1)
var new_room_to = Vector2(-1,-1)
var previous_current_selection = []
var new_room_type = {}
var actual_room_type_name = "grass" setget, getActualRoomTypeName

var size_x = 0
var size_y = 0
var position
var creating_room = false

var tile_on_cursor_node = null setget, getTileOnCursorNode
var tile_on_cursor = Vector2(-1, -1)
var center_tile_on_cursor = Vector2(-1, -1)
var actual_unique_id = 0 setget getActualUniqueID, setActualUniqueID

func _ready():
	create_map(map_path)
	position = tiles[0].get_translation()

func createStatsDict():
	stats = {
	MAP_PATH = map_path,
	ROOMS = rooms_save,
	OCCUPIED_TILES = getOccupiedTiles(),
	SPECIAL_WALLS = special_walls
	}
	return stats

func resetStatsDict():
	stats.clear()

func loadData():
	for current in stats.ROOMS:
		new_room_from = Vector2(current.FROM_X, current.FROM_Y)
		new_room_to = Vector2(current.TO_X, current.TO_Y)
		new_room_type = ressources.getRoomFromId(current.ID)
		var room = room_class.new(new_room_from, new_room_to, new_room_type, self)
		add_child(room)
		rooms.append(room)
		createRoomData()
		
	for data in stats.SPECIAL_WALLS:
		var temp_tile = get_tile(Vector2(data.X, data.Y))
		temp_tile.change_wall(data.WALL_KEY, temp_tile.enum_wall_type.DOOR)

	resetStatsDict()

func create_map(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	
	var lines_str = []
	while(!file.eof_reached()):
		lines_str.append(file.get_line())
	
	var x = 0
	var numbers = []
	var tiles_lines = []
	var doors = []
	
	for line in lines_str:
		if(line.begins_with("S")):
			numbers = getNumbersFormString(line)
			size_x = numbers[0]
			size_y = numbers[1]
		elif(line.begins_with("T")):
			numbers = getNumbersFormString(line, true)
			tiles_lines.append(numbers)
		elif(line.begins_with("D")):
			numbers = getNumbersFormString(line)
			doors.append(numbers)
	
	for x in range(size_x):
		var column = []
		for y in range(size_y):
			var tile = tile_res.instance()
			add_child(tile)
			var tile_type = tiles_lines[y][x]
			if (tile_type == 0):
				tile.create(x, y, ressources.grass)
			elif (tile_type == 1):
				tile.create(x, y, ressources.lobby)
				corridor_tiles.append(tile)
			tile.set_translation(Vector3(x, 0, y))
			tiles.append(tile)
			column.append(tile)
		columns.append(column)

	for tile in tiles:
		tile.get_all_neighbour()
		tile.update_walls("Up")
		tile.update_walls("Left")
		tile.update_walls("Right")
		tile.update_walls("Down")
	
	for door in doors:
		var tile = columns[door[0]][door[1]]
		for wall in tile.walls_types:
			if(tile.walls_types[wall] != 0):
				tile.change_wall(wall, tile.enum_wall_type.DOOR)
	
	file.close()

func getNumbersFormString(string, cut_as_digit = false):
	var numbers = []
	var number = ""
	var previous_was_digit = false
	
	if(!cut_as_digit):
		for i in range(string.length()):
			if (string[i] >= '0' and string[i] <= '9'):
				number += string[i]
				previous_was_digit = true
			elif(previous_was_digit):
				previous_was_digit = false
				numbers.append(number.to_int())
				number = ""
		if(number != ""):
			numbers.append(number.to_int())
	else:
		for i in range(string.length()):
			if (string[i] >= '0' and string[i] <= '9'):
				numbers.append(string[i].to_int())
	
	return numbers

func getTile(vector2):
	return columns[vector2.x][vector2.y]

func getTileOnCursorNode():
	return columns[tile_on_cursor.x][tile_on_cursor.y]

func getActualRoomTypeName():
	return actual_room_type_name

func get_tile(coords):
	for tile in tiles:
		if (tile.x == coords.x && tile.y == coords.y):
			return tile
	return null

func get_list(from, to):
	if (from > to):
		var swap_tmp = from
		from = to
		to = swap_tmp
	
	var selection = []
	if(from.y > to.y):
		for tile in tiles:
			if ((tile.x >= from.x && tile.x <= to.x) && (tile.y <= from.y && tile.y >= to.y)):
				selection.append(tile)
	else:
		for tile in tiles:
			if ((tile.x >= from.x && tile.x <= to.x) && (tile.y >= from.y && tile.y <= to.y)):
				selection.append(tile)
	
	return selection

func is_huge_as(from, to, size):
	if (from > to):
		var swap_tmp = from
		from = to
		to = swap_tmp
	
	if(from.y <= to.y):
		if (to.x - from.x >= size - 1 && to.y - from.y >= size - 1):
			return true
		else:
			return false
	else:
		if (to.x - from.x >= size - 1 && from.y - to.y >= size - 1):
			return true
		else:
			return false

func is_new_room_valid():
	if(!is_huge_as(new_room_from, new_room_to, new_room_type.SIZE_MIN)):
		return false
	for tile in previous_current_selection:
		if (tile.room_type.ID != ressources.lobby.ID):
			return false
		if (tile.getObject()):
			return false
	return true

func new_room(state, parameters):
	if (state == "new"):
		creating_room = true
		new_room_from = Vector2(-1,-1)
		previous_current_selection = []
		new_room_to = Vector2(-1,-1)
		new_room_type = {}
		new_room_type = parameters
		for tile in tiles:
			tile.staticBody.connect("input_event", tile, "_input_event")
			tile.staticBody.connect("mouse_enter", tile, "hover_on", [colors.brown])
			tile.staticBody.connect("mouse_exit", tile, "hover_off")

	elif (state == "from"):
		new_room_from = parameters
		for tile in tiles:
			tile.currently_create_room = true
			tile.staticBody.disconnect("mouse_enter", tile, "hover_on")
		new_room("current", parameters)

	elif (state == "current"):
		new_room_to = parameters
		for tile in previous_current_selection:
			tile.hover_off()
		previous_current_selection = get_list(new_room_from, new_room_to)
		for tile in previous_current_selection:
			if (is_new_room_valid()):
				tile.hover_on(colors.blue)
			else:
				if tile.getObject() || tile.room_type.ID != ressources.lobby.ID || !is_huge_as(new_room_from, new_room_to, new_room_type.SIZE_MIN):
					tile.hover_on(colors.red)
				else:
					tile.hover_on(colors.blue)
	
	elif (state == "to" && new_room_from != Vector2(-1,-1)):
		new_room_to = parameters
		for tile in tiles:
			tile.staticBody.disconnect("input_event", tile, "_input_event")
			tile.staticBody.disconnect("mouse_exit", tile, "hover_off")
			tile.currently_create_room = false
	
	elif (state == "cancel"):
		for tile in tiles:
			tile.hover_off()
			tile.currently_create_room = false
		if(new_room_to == Vector2(-1,-1)):
			for tile in tiles:
				tile.staticBody.disconnect("input_event", tile, "_input_event")
				tile.staticBody.disconnect("mouse_exit", tile, "hover_off")
		if(new_room_from == Vector2(-1,-1)):
			for tile in tiles:
				tile.staticBody.disconnect("mouse_enter", tile, "hover_on")
		new_room_from = Vector2(-1,-1)
		previous_current_selection = []
		new_room_to = Vector2(-1,-1)
		new_room_type = {}
		creating_room = false

	elif (state == "create"):
		if (is_new_room_valid()):
			room = room_class.new(new_room_from, new_room_to, new_room_type, self)
			add_child(room)
			rooms.append(room)
			room.setUniqueID(rooms.size())
			room.enable_place_door()
			for tile in previous_current_selection:
				tile.hover_off()
				tile.unique_id = room.getUniqueID()
				actual_unique_id = tile.unique_id
				removeTileFormCorridor(tile)
			createRoomData()
			actual_room_type_name = new_room_type.NAME
			new_room_from = Vector2(-1,-1)
			previous_current_selection = []
			new_room_to = Vector2(-1,-1)
			new_room_type = {}
			creating_room = false
			return room
		else:
			game.feedback.display("ROOM_NOT_VALID")
			new_room("cancel", null)
		return null

func createRoomData():
	var room_data = {
		FROM_X = new_room_from.x,
		FROM_Y = new_room_from.y,
		TO_X = new_room_to.x,
		TO_Y = new_room_to.y,
		ID = new_room_type.ID,
#		ID = room.getID()
		}
	rooms_save.append(room_data)

#func sendRoomToServer():
#	var packet = "/game 5 " + str(new_room_from.x) + " " + str(new_room_from.y) + " " + str(new_room_to.x) + " " + str(new_room_to.y) + " " + str(new_room_type.ID)
#	global_client.addPacket(packet)

func getOccupiedTiles():
	occupied_tiles.clear()
	for current in tiles:
		if (current.getObject()):
			var tile_data = {
			X = current.x,
			Y = current.y
			}
			occupied_tiles.append(tile_data)
	return occupied_tiles

func getActualUniqueID():
	return actual_unique_id

func setActualUniqueID(new_id):
	actual_unique_id = new_id

func getResources():
	return ressources

func getSize():
	return Vector3(size_x, 0, size_y)

func getPosition():
	return position

func getSpecialWalls():
	return special_walls

func removeTileFormCorridor(tiles_to_remove):
	var idx = corridor_tiles.find(tiles_to_remove)
	if idx != -1:
		corridor_tiles.remove(idx)
