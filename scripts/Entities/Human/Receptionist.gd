
extends "Staff.gd"

var reception_desk = []
onready var object_array = get_node("/root/Game").scene.getObjectArray()
var reception_desk_pos
onready var pathfinding = load("res://scripts/Map/PathFinding.gd") setget, getPath

func _ready():
	set_process(true)

func _process(delta):
	if can_selected == false:
		for desk in object_array:
			if desk["NAME"] == "Reception Desk":
				reception_desk_pos = Vector3(desk["X"], desk["Y"], desk["Z"])
				print("Self Pos[", Vector3(get_translation().x,0,get_translation().z), "] | Desk Pos[", map.columns[reception_desk_pos.x][reception_desk_pos.y], "]")
				pathfinding.new(tile, map.columns[reception_desk_pos.x][reception_desk_pos.y], self, 1.0, map)
				set_process(false)

func getPath():
	pass



