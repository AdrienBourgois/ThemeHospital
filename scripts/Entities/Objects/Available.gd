
extends Spatial

onready var on = get_node("On")
onready var off = get_node("Off")
onready var timer = get_node("Timer")

func _ready():
	self.hide()
	timer.connect("timeout", self, "blink")

func blink():
	self.set_hidden(not self.is_hidden())

func on():
	off.hide()
	on.show()
	self.show()
	timer.start()

func off():
	off.show()
	on.hide()
	self.show()
	timer.start()

