
extends "Staff.gd"

onready var rooms = game.scene.map.rooms

onready var states = {
	wandering = get_node("Wandering"),
	looking_for_room = get_node("LookingForRoom") }

func _ready():
	set_process(true)

func _process(delta):
	if state_machine:
		if is_taken == false:
			state_machine.update()

func put():
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.looking_for_room)
	is_taken = false

func take():
	pathfinding.stop()
	pathfinding.free()
#	state_machine = get_node("StateMachine")
#	state_machine.changeState(states.looking_for_room)

func checkEndPath():
	if pathfinding.animation_completed == true:
		state_machine.changeState()

func checkRoom():
	if rooms.size() != 0:
		for room in rooms:
			pass
	state_machine.changeState(states.wandering)