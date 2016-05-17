
tool
extends EditorPlugin

const GodotControl = preload("res://addons/MapEditor/GodotControl.gd")
const Map = preload("res://addons/MapEditor/Map.gd")
const Window = preload("res://addons/MapEditor/Window.gd")
var control = null
var map = null
var window = null

var current_brush = "Lobby"

func _enter_tree():
	print("[MAP EDITOR]  /*- Theme Hospital Editor - Initialisation... -*\\")
	control = GodotControl.new(self)
	add_control_to_dock(DOCK_SLOT_LEFT_UR, control)
	print("[MAP EDITOR]  /*- Theme Hospital Editor - Initialized ! -*\\")

func new_map(x, y):
	if (map):
		print("[MAP EDITOR] Delete previous Map")
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
	print("[MAP EDITOR] Change brush to ", type)

func _exit_tree():
	print("[MAP EDITOR]  /*- Theme Hospital Editor - Quit... -*\\")
	if (control):
		remove_control_from_docks(control)
		control.free()
	if (map):
		map.free()
	if (window):
		window.free()
	print("[MAP EDITOR] Bye !")
	queue_free()

func save():
	if (!map.is_valid()):
		print("[MAP EDITOR] Can't save map, map is invalid !")
	elif (control.path_lineedit.get_text() == ""):
		print("[MAP EDITOR] Please name the map !")
	else:
		var file = File.new()
		file.open("res://Maps/" + control.path_lineedit.get_text() + ".lvl", file.WRITE)
		var tiles = map.tiles
		
		file.store_string(str(map.size_x) + "\n" + str(map.size_y))
		for tile in tiles:
			if(tile.x == 0):
				file.store_string("\n")
			file.store_string(str(map.tile_type[tile.type]))
		
		file.close()
		print("[MAP EDITOR] Map saved : res://Maps/", control.path_lineedit.get_text(), ".lvl")