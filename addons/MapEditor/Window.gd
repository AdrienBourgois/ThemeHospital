
tool
extends WindowDialog

const EditorControls = preload("res://addons/MapEditor/Controls.gd")
var controls = null
var container = ScrollContainer.new()
var editor = null
var map = null

func _init(_editor):
	editor = _editor
	set_size(Vector2(900,800))
	set_exclusive(true)
	controls = EditorControls.new(editor)
	container.set_pos(Vector2(85,0))
	container.set_size(Vector2(790,790))
	add_child(controls)
	add_child(container)

func _ready():
	popup_centered()

func setMap(_map):
	map = _map
	container.add_child(map)
	connect("hide", self, "window_hide")
	set_title("Map Editor - " + str(map.size_x) + "X" + str(map.size_y))

func windowHide():
	map.set_process_input(false)

