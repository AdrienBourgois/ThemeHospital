extends Control

onready var container = get_node("Container")
onready var total = get_node("Total")
onready var hud = get_parent().get_node("HUD")

onready var map = get_node("/root/Game").scene.map

onready var rooms_ressources = map.ressources
onready var rooms_type = rooms_ressources.type_rooms
onready var research_room = rooms_type.TYPE_FACILITIES.RESEARCH

var global_value = 0

func _ready():
	set_global_value()

func set_global_value():
	global_value = 0
	for i in range(container.get_child_count()):
		var value = container.get_child(i).get_value()
		global_value += value
		total.set_value(global_value)

func _on_Quit_pressed():
	self.hide()
	hud.show()
	set_pause_mode(false)

func get_staff_in_research():
	if research_room.STAFF.empty():
		return
	else:
		return research_room.STAFF