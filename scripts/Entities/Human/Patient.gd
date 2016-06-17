
extends KinematicBody

onready var game = get_node("/root/Game")
onready var player = game.scene.player
onready var map = game.scene.map
onready var object_array = game.scene.getObjectsNodesArray()
onready var disease_list = game.scene.diseases.list_diseases
export var machine = false
onready var disease = get_node("Disease")
onready var entity_manager = get_parent()
onready var child_count = entity_manager.get_child_count()
onready var pathfinding_res = load("res://scripts/Map/PathFinding.gd")
onready var spawn_point = Vector3(15,0.5,45)
onready var states = {
go_to_reception = get_node("GoToReceptionist"),
random_movement = get_node("RandomMovement"),
go_to_drinking_machine = get_node("GoToDrinkingMachine"),
go_to_gp_office = get_node("GoToGpOffice"),
check_bench = get_node("CheckBench"),
go_to_adapted_heal_room = get_node("GoToAdaptedHealRoom"),
go_out = get_node("GoOut")
}

onready var info_bar = game.scene.in_game_gui.control_panel.dynamic_info_bar_label

var state_machine
var pathfinding
var happiness
var thirsty
var warmth
var room_occuped
var desk_ptr
var bench_ptr
var is_go_to_reception = false
var speed = 0.2
var is_diagnosed = false

var is_unhappy = false

func _ready():
	player.increaseTotalPatients(1)
	get_node("CheckStatsTimer").start()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.go_to_reception)
	set_process(true)

func _process(delta):
	if state_machine:
		state_machine.update()

func displayInfo():
	if state_machine:
<<<<<<< HEAD
		info_bar.set_text("Patient : " + tr(state_machine.getCurrentStateName()) + "\nHappiness : " + str(happiness))

func increaseHappiness(val):
	if !is_unhappy:
		happiness += val
	if happiness > 100:
		happiness = 100

func decreaseHappiness(val):
	happiness -= val
	if happiness < 0:
		happiness = 0
	is_unhappy = true
=======
		info_bar.set_text("Patient : " + tr(state_machine.getCurrentStateName()))

func calculateHappiness(is_increase):
	if count == 5:
		if is_increase == false && happiness > 0:
			happiness -= 2
		elif is_increase == true && happiness < 10:
			happiness += 2
	if happiness == 0:
		pathfinding.stop()
		pathfinding.free()
		state_machine.changeState(states.go_out)
>>>>>>> 39eeade20f565e4360e4f8257b4afcd8ee9ec490

func checkThirsty():
	if thirsty > 0:
		thirsty -= 2
	if thirsty <= 20:
		decreaseHappiness(2)
		if state_machine.getCurrentStateName() == "WANDERING" || state_machine.getCurrentStateName() == "CHECK_BENCH":
			pathfinding.stop()
			pathfinding.free()
			state_machine.changeState(states.go_to_drinking_machine)

func checkWarmth():
	if warmth <= 40 || warmth >= 60:
		decreaseHappiness(2)

func _on_Timer_timeout():
	entity_manager.checkGlobalTemperature(self)
	checkThirsty()
	checkWarmth()
	
	increaseHappiness(4)
	is_unhappy = false
	
	if happiness == 0:
		if state_machine.getCurrentStateName() == "WANDERING" || state_machine.getCurrentStateName() == "CHECK_BENCH":
			pathfinding.stop()
			pathfinding.free()
			state_machine.changeState(states.go_out)

func goToReception():
	if object_array.size() != 0:
		for desk in object_array:
			if desk.object_name == "ReceptionDesk" && desk.is_occuped == true:
				desk_ptr = desk
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), desk.vector_pos, self, speed, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.random_movement)

func goToDrinkingMachine():
	if object_array.size() != 0:
		for drinking in object_array:
			if drinking.object_name == "DrinkMachine":
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), drinking.vector_pos, self, speed, map)
				add_child(pathfinding)
				return
	state_machine.returnToPreviousState()

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

func _on_Patient_input_event( camera, event, click_pos, click_normal, shape_idx ):
	displayInfo()
