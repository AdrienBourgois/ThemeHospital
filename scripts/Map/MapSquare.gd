
extends Spatial

onready var wall_res = preload("res://scenes/Map/Wall.scn")
onready var have_object = false

const enum_room_type = { "DECORATION": 0, "LOBBY": 1 }
const enum_wall_type = { "VOID": 0, "WALL": 1, "WINDOW": 2, "DOOR": 3 }

var room_type = 0
var walls_types = { "Up": 0, "Left": 0, "Down": 0, "Right": 0 }

var name
var x = 0
var y = 0

var room_material = FixedMaterial.new()
var wall_material = FixedMaterial.new()

func _ready():
	get_node("StaticBody/Quad").set_material_override(room_material)
	get_node("StaticBody").connect("mouse_enter", self, "hover_on")
	get_node("StaticBody").connect("mouse_exit", self, "hover_off")

func create(_x, _y, _type):
	name = "Tile-" + str(_x) + "." + str(_y)
	set_name(name)
	x = _x
	y = _y
	update(_type)

func createStatsDict():
	var stats = {
	NAME = name,
	X = x,
	Y = y
	}
	return stats

func update(type):
	room_type = type
	room_material.set_flag(1, true)
	wall_material.set_flag(1, true)
	if (type == enum_room_type.DECORATION):
		room_material.set_parameter(0, colors.green)
	elif (type == enum_room_type.LOBBY):
		room_material.set_parameter(0, colors.red)

func update_walls(direction):
	if (get(direction) != null):
		if (!get(direction).room_type):
			change_wall(direction, enum_wall_type.WALL)

func change_wall(wall, type):
	if (type == enum_wall_type.WALL):
		if (walls_types[wall] == enum_wall_type.VOID):
			var new_wall = wall_res.instance()
			new_wall.set_material_override(wall_material)
			get_node("StaticBody/Quad/" + wall + "_Wall").add_child(new_wall)
	if (type == enum_wall_type.VOID):
		if (walls_types[wall] == enum_wall_type.WALL):
			get_node("StaticBody/Quad/" + wall + "_Wall").remove_child("Wall")
	walls_types[wall] = type

func hover_on():
	room_material.set_parameter(0, colors.brown)

func hover_off():
	update(room_type)

func _input_event( camera, event, click_pos, click_normal, shape_idx ):
	get_parent().mouse_pos = click_pos
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click")):
		get_parent().new_room("from", Vector2(x, y))
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("left_click")):
		get_parent().new_room("to", Vector2(x, y))
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("right_click")):
	#	get_parent().addObject(self)
		pass

func _current_select():
	get_parent().new_room("current", Vector2(x, y))

func get(neighbour):
	if (neighbour == "Up"):
		return get_parent().get_tile(Vector2(x, y - 1))
	elif (neighbour == "Left"):
		return get_parent().get_tile(Vector2(x - 1, y))
	elif (neighbour == "Down"):
		return get_parent().get_tile(Vector2(x, y + 1))
	elif (neighbour == "Right"):
		return get_parent().get_tile(Vector2(x + 1, y))
