
extends Control


onready var button = get_node("Button")

onready var commands_menu = get_node("../..")

export var action = ""

var event = null setget setEvent
var scancode setget setScancode
onready var key = null

func _ready():
	init()


func init():
	var list = InputMap.get_action_list(action)
	for idx in list:
		if idx.type == InputEvent.KEY:
			key = idx
	if key != null:
		button.set_text(OS.get_scancode_string(key.scancode))


func _on_Button_pressed():
	commands_menu.popup.show()
	commands_menu.selected_command = self


func setNewInput():
	if event != null:
		var list = InputMap.get_action_list(action)
		InputMap.action_erase_event(action, key)
		InputMap.action_add_event(action, event)


func setEvent(new_event):
	event = new_event


func setScancode(new_scancode):
	scancode = new_scancode
	button.set_text(OS.get_scancode_string(scancode))