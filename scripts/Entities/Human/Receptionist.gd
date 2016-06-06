
extends "Staff.gd"

var reception_desk_pos
var desk_occuped
export var x = 0
export var y = 0
onready var object_array = get_node("/root/Game").scene.getObjectsNodesArray()

func _ready():
	set_fixed_process(true)

func put():
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(get_node("GoToDesk"))

func _fixed_process(delta):
	if state_machine:
		state_machine.update()

func checkDesk():
	if object_array.size() != 0:
		for desk in object_array:
			if desk.object_name == "Reception Desk" && !desk.is_occuped:
				desk_occuped = desk
				reception_desk_pos = Vector2(desk.get_translation().x, desk.get_translation().z)
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), reception_desk_pos, self, 0.2, map)
				add_child(pathfinding)
				return
	state_machine.changeState(get_node("RandomMovement"))

func checkEndPath():
	if pathfinding.animation_completed == true:
		state_machine.changeState(get_node("GoToDesk"))