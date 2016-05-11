extends Spatial

onready var wall_res = preload("res://scenes/Map/Wall.scn")

const enum_diagnostic_rooms_type = { "GP_OFFICE" : 10, "GENERAL_DIAGNOSTIC": 11 }
const enum_treatment_rooms_type = { "PSYCHIATRIC" : 20, "WARD": 21, "PHARMACY": 22 }
const enum_clinic_rooms_type = { "INFLATION": 30 }
const enum_facilities_rooms_type = { "STAFF": 40, "TOILETS": 41 }
const enum_wall_type = { "VOID": 0, "WALL": 1, "WINDOW": 2, "DOOR": 3 }
const enum_room_type = { "DECORATION":  0, "LOBBY": 1, 
"DIAGNOSTIC": enum_diagnostic_rooms_type,"TREATMENT": enum_treatment_rooms_type, 
"CLINICS": enum_clinic_rooms_type, "FACILITIES": enum_facilities_rooms_type }

var room_type = 0
var walls_types = { "Up": 0, "Left": 0, "Down": 0, "Right": 0 }
var neighbour = { "Up": null, "Left": null, "Down": null, "Right": null }

var x = 0
var y = 0

var room_material = FixedMaterial.new()
var wall_material = FixedMaterial.new()

onready var staticBody = get_node("StaticBody")

func _ready():
	get_node("StaticBody/Quad").set_material_override(room_material)
	get_node("StaticBody").connect("mouse_enter", self, "hover_on")
	get_node("StaticBody").connect("mouse_exit", self, "hover_off")

func create(_x, _y, _type):
	set_name("Tile-" + str(_x) + "." + str(_y))
	x = _x
	y = _y
	update(_type)

func update(type):
	get_node("StaticBody/Quad").set_material_override(room_material)
	room_type = type
	room_material.set_flag(1, true)
	wall_material.set_flag(1, true)
	if (type == enum_room_type.DECORATION):
		room_material.set_parameter(0, colors.green)
	elif (type == enum_room_type.LOBBY):
		room_material.set_parameter(0, colors.grey)
	elif (type == enum_room_type.DIAGNOSTIC.GP_OFFICE):
		room_material.set_parameter(0, colors.red)

func update_walls(direction):
	if (neighbour[direction] != null):
		if (!neighbour[direction].room_type):
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
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click")):
		get_parent().new_room("from", Vector2(x, y))
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("left_click")):
		get_parent().new_room("to", Vector2(x, y))

func _current_select():
	get_parent().new_room("current", Vector2(x, y))

func get_all_neighbour():
	var map = get_parent()
	if ((y - 1) > 0):
		neighbour.Up = map.columns[x][y - 1]
	if ((y + 1) < map.size_y):
		neighbour.Down = map.columns[x][y + 1]
	if ((x - 1) > 0):
		neighbour.Left = map.columns[x - 1][y]
	if ((x + 1) < map.size_x):
		neighbour.Right = map.columns[x + 1][y]