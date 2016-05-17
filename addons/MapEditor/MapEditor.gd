
tool
extends EditorPlugin

const GodotControl = preload("res://addons/MapEditor/GodotControl.gd")
const Map = preload("res://addons/MapEditor/Map.gd")
const Window = preload("res://addons/MapEditor/Window.gd")
var control = null
var map = null
var window = null

var current_brush = "Decoration"

func _enter_tree():
	print("----------------------------- /*- Theme Hospital Editor - Initialisation... -*\\ -----------------------------")
	control = GodotControl.new(self)
	add_control_to_dock(DOCK_SLOT_LEFT_UR, control)

func new_map(x, y):
	if (map):
		print("Delete previous Map")
		map.free()
		window.free()
	map = Map.new(x, y, self)
	
	window = Window.new(self)
	window.set_map(map)
	add_child(window)
	
	see_map()

func see_map():
	window.show()

func change_brush(type):
	current_brush = type
	print("Change brush to ", type)

func _exit_tree():
	control.get_parent().remove_child(control)

func save():
	var file = File.new()
	file.open("res://Maps/Map1.lvl", file.WRITE)
	var tiles = map.tiles
	
	file.store_string(str(map.size_x) + "\n" + str(map.size_y))
	for tile in tiles:
		if(tile.x == 0):
			file.store_string("\n")
		file.store_string(str(map.tile_type[tile.type]))
	
	file.close()