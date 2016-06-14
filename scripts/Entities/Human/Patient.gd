
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
go_to_reception = get_node("GoToReceptionist"),
random_movement = get_node("RandomMovement"),
go_to_gp_office = get_node("GoToGpOffice"),
check_bench = get_node("CheckBench")
}

var state_machine
var pathfinding
var happiness
var thirsty
var warmth
var count
var desk_ptr
var is_go_to_reception = false
var speed = 0.2
var is_diagnosed = false

func _ready():
	get_node("CheckStatsTimer").start()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.go_to_reception)
	count = 0
	set_process(true)

func _process(delta):
	if state_machine:
		state_machine.update()

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
				desk_ptr = desk
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), desk.vector_pos, self, speed, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.random_movement)

func checkEndPath():
	if pathfinding.animation_completed:
		pathfinding.free()
		return true

func moveTo():
	print(get_translation())
	var tile_to_go = map.corridor_tiles[randi()%map.corridor_tiles.size()]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, speed, map)
	add_child(pathfinding)

func checkGPOffice():
	if map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["ID"] == 1 && room.is_occuped == true && room.present_patient.size() == 0:
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[0].x, room.tiles[0].y), self, speed, map)
				add_child(pathfinding)
				room.present_patient.append(self)
				return
	state_machine.changeState(states.check_bench)

func checkBench():
	if object_array.size() != 0:
		for bench in object_array:
			print(bench.object_name)
			if bench.object_name == "Bench" && bench.is_occuped == false:
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().y), bench.vector_pos, self, speed, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.random_movement)

func goToAdaptedRoom():
	if disease.type == "pharmacy":
		pass
	elif disease.type == "psychiatric":
		pass