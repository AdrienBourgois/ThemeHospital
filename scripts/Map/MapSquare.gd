
extends Spatial

const enum_room_type = { "DECORATION": 0, "LOBBY": 1 }
const enum_wall_type = { "VOID": 0, "WALL": 1, "WINDOW": 2, "DOOR": 3 }

var room_type = 0
var walls_types = { "Up": 0, "Left": 0, "Down": 0, "Right": 0 }

var x = 0
var y = 0

var material = FixedMaterial.new()

func _ready():
	get_node("StaticBody/Quad").set_material_override(material)
	get_node("StaticBody").connect("mouse_enter", self, "hover_on")
	get_node("StaticBody").connect("mouse_exit", self, "hover_off")

func create(_x, _y, _type):
	set_name("Tile-" + str(_x) + "." + str(_y))
	x = _x
	y = _y
	update(_type)

func update(type):
	room_type = type
	if (type == enum_room_type.DECORATION):
		material.set_parameter(0, colors.green)
	elif (type == enum_room_type.LOBBY):
		material.set_parameter(0, colors.red)

func change_wall(wall, type):
	if (type == enum_wall_type.WALL):
		if (walls_types[wall] == enum_wall_type.VOID):
			get_node("StaticBody/Quad/" + wall + "_Wall").add_child(load("res://scenes/Map/Wall.scn").instance())
	if (type == enum_wall_type.VOID):
		if (walls_types[wall] == enum_wall_type.WALL):
			get_node("StaticBody/Quad/" + wall + "_Wall").remove_child("Wall")
	walls_types[wall] = type

func hover_on():
	#print("Tile : ", x, "-", y)
	material.set_parameter(0, colors.brown)

func hover_off():
	update(room_type)

func _input_event( camera, event, click_pos, click_normal, shape_idx ):
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click")):
		get_parent().new_room("from", Vector2(x, y))
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("left_click")):
		get_parent().new_room("to", Vector2(x, y))

func _current_select():
	get_parent().new_room("current", Vector2(x, y))

func get(neighbour):
	if (neighbour == "up"):
		return get_parent().get_tile(Vector2(x, y - 1))
	elif (neighbour == "left"):
		return get_parent().get_tile(Vector2(x - 1, y))
	elif (neighbour == "down"):
		return get_parent().get_tile(Vector2(x, y + 1))
	elif (neighbour == "right"):
		return get_parent().get_tile(Vector2(x + 1, y))
