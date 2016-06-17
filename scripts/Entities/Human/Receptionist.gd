
extends "Staff.gd"

var reception_desk_pos
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
	set_process(true)

func put():
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.looking_for_desk)
	is_taken = false

func take():
	pathfinding.stop()
	pathfinding.free()

func _process(delta):
	if state_machine:
		if is_taken == false:
			state_machine.update()

func checkDesk():
	if object_array.size() != 0:
		for desk in object_array:
			if desk.object_name == "ReceptionDesk" && !desk.is_occuped && !desk.is_processing_input():
				desk_occuped = desk
				var tile_to_reach_trans = desk.getEntityInteractionTile().get_translation()
				reception_desk_pos = Vector2(tile_to_reach_trans.x, tile_to_reach_trans.z)
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), reception_desk_pos, self, speed, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.wandering)

func checkEndPath():
	if pathfinding.animation_completed:
		pathfinding.free()
		state_machine.changeState(states.looking_for_desk)