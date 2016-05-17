
tool
extends VBoxContainer

var zoom_slider = HSlider.new()
var decoration_brush = Button.new()
var lobby_brush = Button.new()

var editor = null

func _init(_editor):
	editor = _editor
	
	zoom_slider.set_min(1)
	zoom_slider.set_max(25)
	zoom_slider.set_val(editor.current_map.zoom)
	zoom_slider.connect("value_changed", editor.current_map, "change_zoom")
	decoration_brush.set_text("Decoration")
	decoration_brush.connect("pressed", editor, "change_brush", ["Decoration"])
	lobby_brush.set_text("Lobby")
	lobby_brush.connect("pressed", editor, "change_brush", ["Lobby"])
	
	add_child(zoom_slider)
	add_child(decoration_brush)
	add_child(lobby_brush)
