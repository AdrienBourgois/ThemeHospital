extends Spatial

onready var game = get_node("/root/Game")
onready var wall_res = preload("res://scenes/Map/Wall.scn")
onready var window_res = preload("res://scenes/Map/Window.scn")
onready var door_res = preload("res://scenes/Map/Door.scn")

const enum_wall_type = { "VOID": 0, "WALL": 1, "WINDOW": 2, "DOOR": 3 }

var room_type = {}
var walls_types = { "Up": 0, "Left": 0, "Down": 0, "Right": 0 }
var walls = { "Up": null, "Left": null, "Down": null, "Right": null }
var neighbours = { "Up": null, "Left": null, "Down": null, "Right": null }

var x = 0
var y = 0
var object = null setget setObject, getObject
var unique_id = 0 setget setUniqueID, getUniqueID

var room_material = FixedMaterial.new()
var wall_material = FixedMaterial.new()
var hover_material = FixedMaterial.new()

var signals_enabled = false
var currently_create_room = false

onready var staticBody = get_node("StaticBody")
onready var quad = get_node("StaticBody/Quad")
onready var hover = get_node("Hover")
onready var stats = {}

func _ready():
	quad.set_material_override(room_material)
	staticBody.connect("mouse_enter", self, "updateCursorPos")
	hover.set_material_override(hover_material)
	hover.hide()

func createStatsDict():
	stats = {
	X = x,
	Y = y,
	ROOM_TYPE = room_type }
	return stats

func resetStatsDict():
	stats.clear()

func create(_x, _y, _type):
	set_name("Tile-" + str(_x) + "." + str(_y))
	x = _x
	y = _y
	update(_type)

func update(_room_type):
	quad.set_material_override(room_material)
	room_type = _room_type
	room_material.set_flag(1, true)
	wall_material.set_flag(1, true)
	room_material.set_parameter(0, room_type.COLOR)

func updateWalls(direction):
	if(room_type.ID != 40):
		if (neighbours[direction] != null):
			if (neighbours[direction].room_type != room_type):
				changeWall(direction, enum_wall_type.WALL)

func changeWall(wall, type):
	var location = Vector3(0,0.5,0)
	var rotation = Vector3(0,0,0)
	
	if (wall == "Up"):
		location = Vector3(0,0,-0.5)
		rotation = Vector3(0,0,0)
	elif (wall == "Down"):
		location = Vector3(0,0,0.5)
		rotation = Vector3(0,deg2rad(180),0)
	elif (wall == "Left"):
		location = Vector3(-0.5,0,0)
		rotation = Vector3(0,deg2rad(90),0)
	elif (wall == "Right"):
		location = Vector3(0.5,0,0)
		rotation = Vector3(0,deg2rad(-90),0)
	
	if(type != walls_types[wall]):
		if (walls_types[wall] != enum_wall_type.VOID):
			if(walls[wall]):
				quad.remove_child(walls[wall])
				walls[wall] = null
		if (type != enum_wall_type.VOID):
			var new_wall = null
			if (type == enum_wall_type.WALL):
				new_wall = wall_res.instance()
				new_wall.set_material_override(wall_material)
			elif (type == enum_wall_type.DOOR):
				new_wall = door_res.instance()
			new_wall.set_name(wall)
			quad.add_child(new_wall)
			new_wall.set_translation(location)
			new_wall.set_rotation(rotation)
			walls[wall] = new_wall
	
	walls_types[wall] = type

func updateCursorPos():
	get_parent().tile_on_cursor = Vector2(x, y)
	var translation = get_translation()
	var quad_size = quad.get_size()
	get_parent().center_tile_on_cursor = Vector2((quad_size.x / 2) + translation.x, (quad_size.y / 2) + translation.z)
	if (currently_create_room):
		get_parent().newRoom("current", get_parent().tile_on_cursor)

func hoverOn(color):
	hover_material.set_parameter(0, color)
	hover.show()

func hoverOff():
	hover.hide()

func _input_event( camera, event, click_pos, click_normal, shape_idx ):
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click")):
		get_parent().newRoom("from", Vector2(x, y))
	if(event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("left_click")):
		get_parent().newRoom("to", Vector2(x, y))

func setObject(new_object):
	object = new_object

func getUniqueID():
	return unique_id

func setUniqueID(value):
	unique_id = value

func getObject():
	return object

func get_all_neighbour():
	var map = get_parent()
	if ((y - 1) > 0):
		neighbours.Up = map.columns[x][y - 1]
	if ((y + 1) < map.size_y):
		neighbours.Down = map.columns[x][y + 1]
	if ((x - 1) > 0):
		neighbours.Left = map.columns[x - 1][y]
	if ((x + 1) < map.size_x):
		neighbours.Right = map.columns[x + 1][y]