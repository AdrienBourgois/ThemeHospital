
extends Node

var squares = []
onready var square_res = preload("res://scenes/Map/MapSquare.scn")

var new_room_from = Vector2(-1,-1)
var previous_current_selection = []
var new_room_to = Vector2(-1,-1)

func _ready():
	create_map(28, 28)
	new_room("new", 0)

func create_map(_x, _y):
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
		for square in squares:
			square.get_node("StaticBody").disconnect("input_event", square, "_input_event")
			square.get_node("StaticBody").disconnect("mouse_enter", square, "_current_select")
		var new_room_square = get_list(new_room_from, new_room_to)
		for square in new_room_square:
			square.update(square.enum_room_type.LOBBY)
		for square in new_room_square:
			square.update_walls("Up")
			square.update_walls("Left")
			square.update_walls("Right")
			square.update_walls("Down")

