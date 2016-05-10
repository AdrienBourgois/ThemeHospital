
tool
extends EditorPlugin

const EditorControl = preload("res://addons/MapEditor/Control.gd")
var control = null

var current_brush = null

func _enter_tree():
	control = EditorControl.new(self)
	add_control_to_container(CONTAINER_SPATIAL_EDITOR_SIDE, control)

func new_map(x, y):
	print(x, " - ", y)

func change_brush(type):
	current_brush = type
	print("Change to ", type)

func _exit_tree():
	control.get_parent().remove_child(control)