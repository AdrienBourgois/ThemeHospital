
tool
extends VBoxContainer

var editor = null

var new_button = Button.new()
var label_x = Label.new()
var label_y = Label.new()
var spin_size_x = SpinBox.new()
var spin_size_y = SpinBox.new()

var zoom_slider = HSlider.new()
var decoration_brush = Button.new()
var lobby_brush = Button.new()

func _init(_editor):
	print("Init")
	editor = _editor
	create_new_container()

func create_new_container():
	new_button.set_text("New")
	new_button.connect("pressed", self, "new_map_pressed")
	label_x.set_text("X : ")
	label_y.set_text("Y : ")
	
	add_child(label_x)
	add_child(spin_size_x)
	add_child(label_y)
	add_child(spin_size_y)
	add_child(new_button)
	
	add_spacer(false)
	
	zoom_slider.set_min(1)
	zoom_slider.set_max(25)
	decoration_brush.set_disabled(true)
	decoration_brush.set_text("Decoration")
	decoration_brush.connect("pressed", editor, "change_brush", ["Decoration"])
	lobby_brush.set_disabled(true)
	lobby_brush.set_text("Lobby")
	lobby_brush.connect("pressed", editor, "change_brush", ["Lobby"])
	
	add_child(zoom_slider)
	add_child(decoration_brush)
	add_child(lobby_brush)

func new_map_pressed():
	print("New Map")
	decoration_brush.set_disabled(false)
	lobby_brush.set_disabled(false)
	editor.new_map(spin_size_x.get_line_edit().get_text().to_int(), spin_size_y.get_line_edit().get_text().to_int())
	zoom_slider.connect("value_changed", editor.current_map, "change_zoom")
	