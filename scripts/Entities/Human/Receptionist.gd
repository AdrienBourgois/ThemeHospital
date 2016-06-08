
extends "Staff.gd"

var desk_occuped
export var x = 0
export var y = 0
onready var object_array = game.scene.getObjectsNodesArray()

onready var states = {
	wandering = get_node("RandomMovement"),
	looking_for_desk = get_node("GoToDesk"),
	at_desk = get_node("AtDesk")
}

func _ready():
	set_fixed_process(true)

func put():
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.looking_for_desk)

func take():
	state_machine = get_node("StateMachine")
	state_machine.changeState(states.looking_for_desk)

func _fixed_process(delta):
	if state_machine:
		state_machine.update()

func checkDesk():
	if object_array.size() != 0:
		for desk in object_array:
			if desk.object_name == "ReceptionDesk" && !desk.is_occuped:
				desk_occuped = desk
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), desk.vector_pos, self, 0.2, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.wandering)

func checkEndPath():
	if pathfinding.animation_completed:
		pathfinding.free()
		state_machine.changeState(states.wandering)