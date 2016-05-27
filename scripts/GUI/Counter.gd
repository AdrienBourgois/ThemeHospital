
extends Control

onready var value = 0 setget setValue, getValue
onready var label = get_node("Label")

func _ready():
	label.set_text(tr("TXT_COUNT") + "0")

func update():
	label.set_text(tr("TXT_COUNT") + str(value))

func _on_MainButton_pressed():
	_on_More_pressed()

func _on_Less_pressed():
	if (value <= 0):
		value = 0
		return
	value -= 1
	update()

func _on_More_pressed():
	value += 1
	if (value > 5):
		value = 5
	update()

func setValue(val):
	value = val

func getValue():
	return value
