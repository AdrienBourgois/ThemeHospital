
extends Control

onready var options_menu = get_node("../..")
onready var popup = get_node("ConfirmationDialog") setget ,getPopup
onready var commands = get_node("Commands")

var selected_command setget setSelectedCommand

var scancode
var eventData = null

func _ready():
	set_process(true)

func _process(delta):
	if !popup.is_hidden():
		set_process_input(true)

func _input(event):
	if event.type == InputEvent.KEY:
		eventData = event
		scancode = event.scancode
		popup.set_text(OS.get_scancode_string(scancode))

func setAllNewInput():
	for idx in commands.get_children():
		idx.setNewInput()

func getPopup():
	return popup


func setSelectedCommand(command):
	selected_command = command


func _on_ConfirmationDialog_confirmed():
	if selected_command && eventData != null && scancode:
		selected_command.event = eventData
		selected_command.scancode = scancode
		set_process_input(false)
		selected_command = null
		eventData = null
	options_menu.apply_button.set_disabled(false)