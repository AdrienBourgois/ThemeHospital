
extends Spatial

const enum_room_type = { "DECORATION": 0, "LOBBY": 1 }
const enum_wall_type = { "VOID": 0, "WALL": 1, "WINDOW": 2, "DOOR": 3 }

var room_type = 0
var walls_types = { "Up": 0, "Left": 0, "Down": 0, "Right": 0 }

var material = FixedMaterial.new()

func _ready():
	get_node("StaticBody/Quad").set_material_override(material)

func update(type):
	room_type = type
	if (type == enum_room_type.DECORATION):
		material.set_parameter(0, Color(0,1,0))
	elif (type == enum_room_type.LOBBY):
		material.set_parameter(0, Color(1,0,0))

func change_wall(wall, type):
	if (type == enum_wall_type.WALL):
		if (walls_types[wall] == enum_wall_type.VOID):
			get_node("StaticBody/Quad/" + wall + "_Wall").add_child(load("res://scenes/Map/Wall.scn"))
	if (type == enum_wall_type.VOID):
		if (walls_types[wall] == enum_wall_type.WALL):
			get_node("StaticBody/Quad/" + wall + "_Wall").remove_child("Wall")
	walls_types[wall] = type
	