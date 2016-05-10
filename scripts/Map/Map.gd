
extends Node

var lines = []
var tiles = []
onready var tile_res = preload("res://scenes/Map/Tile.scn")

var new_room_from = Vector2(-1,-1)
var previous_current_selection = []
var new_room_to = Vector2(-1,-1)

var size_x = 0
var size_y = 0

func _ready():
	create_map(28, 28)
	new_room("new", 0)

func create_map(_x, _y):
	size_x = _x
	size_y = _y
	for x in range(_x):
		var column = []
		for y in range(_y):
			var tile = tile_res.instance()
			add_child(tile)
			tile.create(x, y, tile.enum_room_type.DECORATION)
			tile.set_translation(Vector3(x, 0, y))
			tiles.append(tile)
			column.append(tile)
		lines.append(column)
	for tile in tiles:
		tile.get_all_neighbour()

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
		for tile in previous_current_selection:
			tile.room_material.set_parameter(0, colors.purple)

	elif (state == "to" && new_room_from != Vector2(-1,-1)):
		new_room_to = parameters
		for tile in tiles:
			tile.staticBody.disconnect("input_event", tile, "_input_event")
			tile.staticBody.disconnect("mouse_enter", tile, "_current_select")
		var new_room_square = get_list(new_room_from, new_room_to)
		for tile in new_room_square:
			tile.update(tile.enum_room_type.LOBBY)
		for tile in new_room_square:
			tile.update_walls("Up")
			tile.update_walls("Left")
			tile.update_walls("Right")
			tile.update_walls("Down")

