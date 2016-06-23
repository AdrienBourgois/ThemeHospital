
extends "Staff.gd"

onready var rooms = game.scene.map.rooms

export var work_rooms = ["ROOM_TONGUE", "ROOM_GENERAL_DIAGNOSIS", "ROOM_INFLATION", "ROOM_GP", "ROOM_CARDIOGRAM"]

var room_occuped = null

onready var states = {
	wandering = get_node("Wandering"),
	looking_for_room = get_node("LookingForRoom"),
	looking_for_staff_room = get_node("LookingForStaffRoom"),
	waiting_for_patient = get_node("WaitingForPatient"),
	go_to_staff_room = get_node("GoToStaffRoom")
}

var seniority
var specialities
var patients

func _ready():
	timer.connect("timeout", self, "_on_Timer_Timeout")
	set_process(true)

func _process(delta):
	if state_machine:
		if is_taken == false:
			state_machine.update()

func updateStats():
	position.x = self.get_translation().x 
	position.y = self.get_translation().y
	position.z = self.get_translation().z
	rotation = self.get_rotation().y
	staff_stats = {
	NAME = name,
	X = position.x,
	Y = position.y,
	Z = position.z,
	ID = id,
	ROTATION = rotation,
	SKILL = skill,
	SALARY = salary,
	SENIORITY = seniority,
	SPECIALITIES = specialities
	}
	return staff_stats

func put():
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	timer.start()
	state_machine.setCurrentState(states.looking_for_room)

func take():
	pathfinding.stop()
	pathfinding.free()
	pathfinding = null
	if room_occuped:
		room_occuped.is_occuped = false
		room_occuped = null

func sack():
	if room_occuped:
		room_occuped.is_occuped = false
		room_occuped = null

func checkEndPath():
	pathfinding.free()
	state_machine.changeState(states.looking_for_room)

func checkWorkRoom():
	if rooms.size() != 0:
		for room in rooms:
			if checkRoomValidity(room):
				checkDistanceToRoom(room)
		if room_occuped:
			room_occuped.is_occuped = true
			pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room_occuped.tiles[10].x, room_occuped.tiles[10].y), self, speed, map)
			add_child(pathfinding)
			return
	state_machine.changeState(states.wandering)

func checkDistanceToRoom(room):
	var position = get_translation()
	if !room_occuped:
		room_occuped = room
	elif position.distance_to(room.tiles[5].get_translation()) < position.distance_to(room_occuped.tiles[5].get_translation()):
		room_occuped = room

func diagnose():
	var present_patient = room_occuped.present_patient[0]
	var present_patient_disease = present_patient.disease
	present_patient.is_diagnosed = true
	if present_patient_disease.disease_type["TREATMENT_ROOM"] == "ROOM_PHARMACY":
		present_patient_disease.type = "pharmacy"
	elif present_patient_disease.disease_type["TREATMENT_ROOM"] == "ROOM_PSYCHIATRIC":
		present_patient_disease.type = "psychiatric"
	elif present_patient_disease.name == "NAME_BLOATY":
		present_patient_disease.type = "bloaty_head"
	elif present_patient_disease.name == "NAME_TONGUE":
		present_patient_disease.type = "tongue"
	else:
		present_patient_disease.type = "unknow"

func checkRoomValidity(room):
	if !room.is_occuped:
		if room.type.NAME == "ROOM_PSYCHIATRIC" && specialities == 1:
			return true
		elif room.type.NAME == "ROOM_RESEARCH" && specialities == 2:
			return true
		elif room.type.NAME == "ROOM_OPERATING" && specialities == 3:
			return true
		elif work_rooms.find(room.type.NAME) != -1:
			return true
	return false

func goToStaffRoom():
	if map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["NAME"] == "ROOM_STAFF_ROOM":
				if room_occuped != null:
					room_occuped.is_occuped = false
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[0].x, room.tiles[0].y), self, speed, map)
				add_child(pathfinding)
				timer.start()
				return
	state_machine.changeState(states.looking_for_room)

func moveIntoRoom():
	var rand = randi()%(room_occuped.tiles.size())
	var tile_to_go = room_occuped.tiles[rand]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, speed, map)
	add_child(pathfinding)

func _on_Timer_Timeout():
	if state_machine.getCurrentStateName() != states.go_to_staff_room.name:
		tireness -= 2
		if tireness < 0:
			tireness = 0
		if tireness < 95:
			if pathfinding != null:
				pathfinding.stop()
				pathfinding.free()
			state_machine.changeState(states.go_to_staff_room)

	else:
		tireness += 5
		if tireness > 100:
			tireness = 100
