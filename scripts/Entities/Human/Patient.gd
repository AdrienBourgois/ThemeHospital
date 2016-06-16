
extends KinematicBody

onready var game = get_node("/root/Game")
onready var map = game.scene.map
onready var object_array = game.scene.getObjectsNodesArray()
export var machine = false
onready var disease = get_node("Disease")
onready var entity_manager = get_parent()
onready var child_count = entity_manager.get_child_count()
onready var pathfinding_res = load("res://scripts/Map/PathFinding.gd")
onready var spawn_point = Vector3(15,0.5,45)
onready var states = {
go_to_reception = get_node("GoToReceptionist"),
random_movement = get_node("RandomMovement"),
go_to_gp_office = get_node("GoToGpOffice"),
check_bench = get_node("CheckBench"),
go_to_adapted_heal_room = get_node("GoToAdaptedHealRoom"),
go_out = get_node("GoOut")
}

var state_machine
var pathfinding
var happiness
var thirsty
var warmth
var count
var room_occuped
var desk_ptr
var bench_ptr
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
	var tile_to_go = map.corridor_tiles[randi()%map.corridor_tiles.size()]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, speed, map)
	add_child(pathfinding)

func checkGPOffice():
	if map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["NAME"] == "ROOM_GP" && room.is_occuped == true && room.present_patient.size() == 0:
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[0].x, room.tiles[0].y), self, speed, map)
				add_child(pathfinding)
				room_occuped = room
				room.present_patient.append(self)
				return
	state_machine.changeState(states.check_bench)

func checkBench():
	if object_array.size() != 0:
		for bench in object_array:
			if bench.object_name == "Bench" && bench.is_occuped == false:
				bench_ptr = bench
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), bench.vector_pos, self, speed, map)
				add_child(pathfinding)
				bench.is_occuped = true
				return
	state_machine.changeState(states.random_movement)

func goToAdaptedHealRoom():
	if disease.type == "pharmacy" && map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["NAME"] == "ROOM_PHARMACY" && room.is_occuped == true && room.present_patient.size() == 0:
				room_occuped = room
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[0].x, room.tiles[0].y), self, speed, map)
				add_child(pathfinding)
				room.present_patient.append(self)
				return
	elif disease.type == "psychiatric" && map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["NAME"] == "ROOM_PSYCHIATRIC" && room.is_occuped == true && room.present_patient.size() == 0:
				room_occuped = room
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[0].x, room.tiles[0].y), self, speed, map)
				add_child(pathfinding)
				room.present_patient.append(self)
				return
	state_machine.changeState(states.check_bench)