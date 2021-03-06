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
onready var pathfinding_res = load("res://scripts/Map/PathFinding/PathFinding.gd")
onready var spawn_point = Vector3(15,0.5,45)

onready var patient = get_node("./Patient")
onready var body = patient.get_node("Body")
onready var head = patient.get_node("Head")
onready var tv_head = patient.get_node("TvHead")
onready var tongue = head.get_node("Tongue")

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
var object_ptr
var is_go_to_reception = false
export var speed = 0.2
var is_diagnosed = false

var is_unhappy = false

var default_skin_material = {
leftleg = null,
rightleg = null,
head = null,
tongue = null
}

func _ready():
	player.increaseTotalPatients(1)
	get_node("CheckStatsTimer").start()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.go_to_reception)
	saveDefaultSkinMaterial()
	setPhysicalDisease()
	set_process(true)

func saveDefaultSkinMaterial():
	default_skin_material.leftleg = body.get_node("LeftLeg").get_material_override()
	default_skin_material.rightleg = body.get_node("RightLeg").get_material_override()
	default_skin_material.head = patient.get_node("Head").get_material_override()
	default_skin_material.tongue = patient.get_node("Head/Tongue").get_material_override()

func setPhysicalDisease():
	if (disease.name == "NAME_INVISIBILITY"):
		setHeadDisappear()
	elif (disease.name == "NAME_BLOATY"):
		setBigHead()
	elif (disease.name == "NAME_TONGUE"):
		setBigTongue()
	elif (disease.name == "NAME_UNCOMMON"):
		setBluePatient()
	elif (disease.name == "NAME_SQUITS"):
		setBrownPant()
	elif (disease.name == "NAME_TV"):
		setTvHead()

func setHeadDisappear():
	head.set_hidden(true)

func setBigHead():
	head.set_hidden(false)
	tongue.set_hidden(true)
	head.set_scale(Vector3(0.8, 0.7, 0.8))

func setBigTongue():
	head.set_hidden(false)
	tongue.set_hidden(false)

func setBluePatient():
	var material = FixedMaterial.new()
	material.set_parameter(0, Color("2799ed"))
	head.set_material_override(material)

func setBrownPant():
	var leftleg = body.get_node("LeftLeg")
	var rightleg = body.get_node("RightLeg")
	var material = FixedMaterial.new()
	material.set_parameter(material.PARAM_DIFFUSE, Color("411616"))
	leftleg.set_material_override(material)
	rightleg.set_material_override(material)

func setTvHead():
	head.set_hidden(true)
	tv_head.set_hidden(false)


func _process(delta):
	if state_machine:
		state_machine.update()

func displayInfo():
	if state_machine:
		info_bar.set_text("Patient : " + str(tr(state_machine.getCurrentStateName())))

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

func checkThirsty():
	if thirsty > 0:
		thirsty -= 2
	if thirsty <= 20:
		decreaseHappiness(2)
		if state_machine.getCurrentStateName() == "WANDERING" || state_machine.getCurrentStateName() == "CHECK_BENCH":
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
				checkDistanceToObject(desk)
		if object_ptr:
			pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), object_ptr.vector_pos, self, speed, map)
			add_child(pathfinding)
			return
	state_machine.changeState(states.random_movement)

func goToDrinkingMachine():
	if object_array.size() != 0:
		for drinking in object_array:
			if drinking.object_name == "DrinkMachine":
				checkDistanceToObject(drinking)
		if object_ptr:
			pathfinding.stop()
			pathfinding.free()
			pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), object_ptr.vector_pos, self, speed, map)
			add_child(pathfinding)
			return
	state_machine.returnToPreviousState()

func checkEndPath():
	pathfinding.free()
	state_machine.returnToPreviousState()

func moveTo():
	var tile_to_go = map.corridor_tiles[randi()%map.corridor_tiles.size()]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, speed, map)
	add_child(pathfinding)

func checkGPOffice():
	if goToRoom("ROOM_GP"):
			return
	else:
		state_machine.changeState(states.check_bench)

func checkBench():
	if object_array.size() != 0:
		for bench in object_array:
			if bench.object_name == "Bench" && bench.is_occuped == false:
				checkDistanceToObject(bench)
			if object_ptr:
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), object_ptr.vector_pos, self, speed, map)
				add_child(pathfinding)
				object_ptr.is_occuped = true
				return
	state_machine.changeState(states.random_movement)

func goToAdaptedHealRoom():
	if disease.type == "pharmacy" && map.rooms.size() != 0:
		if goToRoom("ROOM_PHARMACY"):
			return
	elif disease.type == "psychiatric" && map.rooms.size() != 0:
		if goToRoom("ROOM_PSYCHIATRIC"):
			return
	elif disease.type == "bloaty_head" && map.rooms.size() != 0:
		if goToRoom("ROOM_INFLATION"):
			return
	elif disease.type == "tongue" && map.rooms.size() != 0:
		if goToRoom("ROOM_TONGUE"):
			return
	state_machine.changeState(states.check_bench)

func goToRoom(room_name):
	for room in map.rooms:
		if room.type["NAME"] == room_name && room.is_occuped == true && room.present_patient.size() == 0:
			checkDistanceToRoom(room)
	if room_occuped:
		pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room_occuped.tiles[0].x, room_occuped.tiles[0].y), self, speed, map)
		add_child(pathfinding)
		room_occuped.present_patient.append(self)
		return true
	else:
		return false

func _on_Patient_input_event( camera, event, click_pos, click_normal, shape_idx ):
	displayInfo()
	displayFeedback()

func displayFeedback():
	if thirsty <= 20 :
		game.feedback.display("FEEDBACK_THIRSTY")
	else:
		game.feedback.display("FEEDBACK_PATIENT")

func checkDistanceToRoom(room):
	var position = get_translation()
	if !room_occuped:
		room_occuped = room
	elif position.distance_to(room.tiles[5].get_translation()) < position.distance_to(room_occuped.tiles[5].get_translation()):
		room_occuped = room

func checkDistanceToObject(object):
	var position = get_translation()
	if !object_ptr:
		object_ptr = object
	elif position.distance_to(object.get_translation()) < position.distance_to(object_ptr.get_translation()):
		object_ptr = object

func setDefaultSkin():
	body.get_node("LeftLeg").set_material_override(default_skin_material.leftleg)
	body.get_node("RightLeg").set_material_override(default_skin_material.rightleg)
	patient.get_node("Head").set_material_override(default_skin_material.head) 
	tongue.set_hidden(true)
	head.set_scale(Vector3(0.5, 0.5, 0.5))
	head.set_hidden(false)
	tv_head.set_hidden(true)