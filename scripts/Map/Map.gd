extends Node

var columns = []
var tiles = []
onready var tile_res = preload("res://scenes/Map/Tile.scn")

var new_room_from = Vector2(-1,-1)
var previous_current_selection = []
var new_room_to = Vector2(-1,-1)

var size_x = 0
var size_y = 0

func _ready():
	create_map("res://Maps/Map1.lvl")
	new_room("new", 0)

func create_map(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	
	size_x = file.get_line().to_int()
	size_y = file.get_line().to_int()
	
	var lines_str = []
	for i in range(size_y):
		lines_str.append(file.get_line())
	
	for x in range(size_x):
		var column = []
		for y in range(size_y):
			var tile = tile_res.instance()
			add_child(tile)
			var tile_type = lines_str[y].substr(x, 1).to_int()
			tile.create(x, y, tile_type)
			tile.set_translation(Vector3(x, 0, y))
			tiles.append(tile)
			column.append(tile)
		columns.append(column)
	for tile in tiles:
		tile.get_all_neighbour()
		if (tile.room_type):
			tile.update_walls("Up")
			tile.update_walls("Left")
			tile.update_walls("Right")
			tile.update_walls("Down")

func reload_map():
	for tile in tiles:
		tile.update(tile.room_type)
		tile.update_walls("Up")
		tile.update_walls("Left")
		tile.update_walls("Right")
		tile.update_walls("Down")

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

func new_room(state, parameters):
	if (state == "new"):
		for tile in tiles:
			tile.staticBody.connect("input_event", tile, "_input_event")

	elif (state == "from"):
		new_room_from = parameters
		for tile in tiles:
			tile.staticBody.connect("mouse_enter", tile, "_current_select")
	
	elif (state == "current"):
		for tile in previous_current_selection:
			tile.update(tile.room_type)
		previous_current_selection = get_list(new_room_from, parameters)
		print("tile x : ", new_room_from.x - parameters.x, " tile y : ", new_room_from.y - parameters.y)
		for tile in previous_current_selection:
			if (parameters.x - new_room_from.x < 4 && parameters.y - new_room_from.y < 4 && parameters.x - new_room_from.x > -4 && parameters.y - new_room_from.y > -4):
				tile.room_material.set_parameter(0, colors.red)
			else:
				tile.room_material.set_parameter(0, colors.blue)

	elif (state == "to" && new_room_from != Vector2(-1,-1)):
		new_room_to = parameters
		for tile in tiles:
			tile.staticBody.disconnect("input_event", tile, "_input_event")
			tile.staticBody.disconnect("mouse_enter", tile, "_current_select")
		var new_room_square = get_list(new_room_from, new_room_to)
		for tile in new_room_square:
			tile.update(tile.enum_room_type.DIAGNOSTIC.GP_OFFICE)
		for tile in new_room_square:
			tile.update_walls("Up")
			tile.update_walls("Left")
			tile.update_walls("Right")
			tile.update_walls("Down")