
tool
extends VBoxContainer

var editor = null

var label_x = Label.new()
var label_y = Label.new()
var spin_size_x = SpinBox.new()
var spin_size_y = SpinBox.new()
var new_button = Button.new()
var see_map_button = Button.new()
var save_button = Button.new()

func _init(_editor):
	editor = _editor
	
	label_x.set_text("X : ")
	label_y.set_text("Y : ")
	new_button.set_text("New")
	new_button.connect("pressed", self, "new_map_pressed")
	see_map_button.set_text("See map")
	see_map_button.set_disabled(true)
	see_map_button.connect("pressed", editor, "see_map")
	save_button.set_text("Save")
	save_button.set_disabled(true)
	save_button.connect("pressed", editor, "save")
	
	add_child(label_x)
	add_child(spin_size_x)
	add_child(label_y)
	add_child(spin_size_y)
	add_child(new_button)
	add_child(see_map_button)
	add_child(save_button)
	
	add_spacer(false)

func new_map_pressed():
	print("New Map")
	editor.new_map(spin_size_x.get_line_edit().get_text().to_int(), spin_size_y.get_line_edit().get_text().to_int())
	see_map_button.set_disabled(false)
	save_button.set_disabled(false)