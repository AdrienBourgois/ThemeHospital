
tool
extends EditorPlugin

const EditorControl = preload("res://addons/MapEditor/Control.gd")
const Map = preload("res://addons/MapEditor/Map.gd")
var control = null
var current_map = null

var current_brush = "Decoration"

func _enter_tree():
	control = EditorControl.new(self)
	add_control_to_dock(DOCK_SLOT_LEFT_UR, control)

func new_map(x, y):
	if (current_map):
		print("Delete previous Map")
		remove_control_from_bottom_panel(current_map)
		current_map.free()
	current_map = Map.new(x, y, self)
	add_control_to_bottom_panel(current_map, "Map")
	current_map.set_custom_minimum_size(Vector2(500, 500))
	current_map.set_size(Vector2(5,5))

func change_brush(type):
	current_brush = type
	print("Change brush to ", type)

func _exit_tree():
	control.get_parent().remove_child(control)