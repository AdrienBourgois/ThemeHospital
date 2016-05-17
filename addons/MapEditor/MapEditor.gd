
tool
extends EditorPlugin

const GodotControl = preload("res://addons/MapEditor/GodotControl.gd")
const Map = preload("res://addons/MapEditor/Map.gd")
const Window = preload("res://addons/MapEditor/Window.gd")
var control = null
var current_map = null
var window = null

var current_brush = "Decoration"

func _enter_tree():
	print("----------------------------- /*- Theme Hospital Editor - Initialisation... -*\\ -----------------------------")
	control = GodotControl.new(self)
	add_control_to_dock(DOCK_SLOT_LEFT_UR, control)

func new_map(x, y):
	if (current_map):
		print("Delete previous Map")
		current_map.free()
		window.free()
	current_map = Map.new(x, y, self)
	
	window = Window.new(self)
	window.set_map(current_map)
	add_child(window)
	
	see_map()

func see_map():
	window.show()

func change_brush(type):
	current_brush = type
	print("Change brush to ", type)

func _exit_tree():
	control.get_parent().remove_child(control)