
tool
extends VBoxContainer

var zoom_slider = HSlider.new()
var decoration_brush = Button.new()
var lobby_brush = Button.new()
var door_brush = Button.new()
var display_doors_button = CheckButton.new()
var currentLabel = Label.new()

var editor = null

func _init(_editor):
	editor = _editor
	
	zoom_slider.set_min(1)
	zoom_slider.set_max(25)
	zoom_slider.set_val(editor.map.zoom)
	zoom_slider.connect("value_changed", editor.map, "change_zoom")
	decoration_brush.set_text("Decoration")
	decoration_brush.connect("pressed", editor, "change_brush", [0])
	lobby_brush.set_text("Lobby")
	lobby_brush.connect("pressed", editor, "change_brush", [1])
	door_brush.set_text("Door")
	door_brush.connect("pressed", editor, "change_brush", [2])
	display_doors_button.connect("toggled", editor.map, "display_doors")
	currentLabel.set_text("X: 0 - Y: 0")
	
	add_child(zoom_slider)
	add_child(decoration_brush)
	add_child(lobby_brush)
	add_child(door_brush)
	add_child(display_doors_button)
	add_child(currentLabel)
