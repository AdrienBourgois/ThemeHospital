
extends Node

var squares = []
var objects = []
onready var mouse_pos
var rooms = []

onready var square_res = preload("res://scenes/Map/MapSquare.scn")
onready var object_res = preload("res://scenes/Entities/Objects/Object.scn")
onready var stats = {}

var new_room_from = Vector2(-1,-1)
var previous_current_selection = []
var new_room_to = Vector2(-1,-1)
var size_x 
var size_y

func _ready(): 
	pass

func init(_x, _y):
	create_map(_x, _y)
	new_room("new", 0)

func addObject(map_square):
	var new_object = object_res.instance()
	new_object.create(map_square)
	map_square.add_child(new_object)
	objects.append(new_object)

func loadData():
	size_x = stats.SIZE_X
	size_y = stats.SIZE_Y
	init(size_x, size_y)
	for current in stats.ROOMS:
		var square = square_res.instance()
		#square.create(size_x, size_y, square.enum_room_type.DECORATION)
		square.create(size_x, size_y, square.enum_room_type.LOBBY)
		#square.update(square.enum_room_type.LOBBY)
		#square.set_translation(Vector3(size_x, 0, size_y)) 
		add_child(square)
	resetStatsDict()

func createStatsDict():
	stats = {
	SIZE_X = size_x,
	SIZE_Y = size_y,
	ROOMS = rooms
	}
	return stats

func resetStatsDict():
	stats.clear()

func create_map(_x, _y):
	size_x = _x
	size_y = _y
	for x in range(_x):
		for y in range(_y):
			var square = square_res.instance()
			add_child(square)
			square.create(x, y, square.enum_room_type.DECORATION)
			square.set_translation(Vector3(x, 0, y))
			squares.append(square)

func get_tile(coords):
	for square in squares:
		if (square.x == coords.x && square.y == coords.y):
			return square
	return null

func get_list(from, to):
	if (from > to):
		var swap_tmp = from
		from = to
		to = swap_tmp
	
	var selection = []
	if(from.y > to.y):
		for square in squares:
			if ((square.x >= from.x && square.x <= to.x) && (square.y <= from.y && square.y >= to.y)):
				selection.append(square)
	else:
		for square in squares:
			if ((square.x >= from.x && square.x <= to.x) && (square.y >= from.y && square.y <= to.y)):
				selection.append(square)
	
	return selection

func new_room(state, parameters):
	if (state == "new"):
		for square in squares:
			square.get_node("StaticBody").connect("input_event", square, "_input_event")

	elif (state == "from"):
		new_room_from = parameters
		for square in squares:
			square.get_node("StaticBody").connect("mouse_enter", square, "_current_select")
	
	elif (state == "current"):
		for square in previous_current_selection:
			square.update(square.room_type)
		previous_current_selection = get_list(new_room_from, parameters)
		for square in previous_current_selection:
			square.room_material.set_parameter(0, colors.purple)
	elif (state == "to" && new_room_from != Vector2(-1,-1)):
		new_room_to = parameters
		var square = []
		for square in squares:
			square.get_node("StaticBody").disconnect("input_event", square, "_input_event")
			square.get_node("StaticBody").disconnect("mouse_enter", square, "_current_select")
		var new_room_square = get_list(new_room_from, new_room_to)
		for square in new_room_square:
			var new_room = []
			square.update(square.enum_room_type.LOBBY)
			new_room.append(square.createStatsDict())
			rooms.append(new_room)
		for square in new_room_square:
			square.update_walls("Up")
			square.update_walls("Left")
			square.update_walls("Right")
			square.update_walls("Down")

