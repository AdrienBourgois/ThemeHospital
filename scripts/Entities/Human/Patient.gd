
extends KinematicBody

onready var game = get_node("/root/Game")
onready var map = game.scene.map
onready var object_array = game.scene.getObjectsNodesArray()
export var machine = false
onready var disease = get_node("Disease")
onready var entity_manager = get_parent()
onready var child_count = entity_manager.get_child_count()
onready var pathfinding_res = load("res://scripts/Map/PathFinding.gd")
onready var states = {
go_to_reception = get_node("GoToReceptionist")
}

var state_machine
var happiness
var thirsty
var warmth
var count

func _ready():
	get_node("CheckStatsTimer").start()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.go_to_reception)
	print("TAMER")
	count = 0

func calculateHappiness(is_increase):
	if count == 5:
		if is_increase == false:
			happiness -= 2
		elif is_increase == true && happiness < 100:
			happiness += 2

func checkThirsty():
	if thirsty > 0:
		thirsty -= 2
	if thirsty <= 20:
		calculateHappiness(false)
		if machine == true:
			thirsty += 50
	else:
		calculateHappiness(true)

func checkWarmth():
	if warmth <= 40 || warmth >= 60:
		calculateHappiness(false)
	else:
		calculateHappiness(true)

func _on_Timer_timeout():
	count += 1
	entity_manager.checkGlobalTemperature(self)
	checkThirsty()
	checkWarmth()
	
	if count == 5:
		count = 0

func goToReception():
	if object_array.size() != 0:
		for desk in object_array:
			if desk.object_name == "ReceptionDesk" && desk.is_occuped == true:
				print("desk pos[", desk.vector_pos, "] | self pos[", self.get_translation(), "]")
				var pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), desk.vector_pos, self, 0.5, map)
				add_child(pathfinding)