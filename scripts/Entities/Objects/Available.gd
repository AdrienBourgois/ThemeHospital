
extends Spatial

onready var on = get_node("On")
onready var off = get_node("Off")

func _ready():
	self.hide()

func on():
	off.hide()
	on.show()
	self.show()

func off():
	off.show()
	on.hide()
	self.show()

