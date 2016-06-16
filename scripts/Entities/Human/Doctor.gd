
extends "Staff.gd"

onready var rooms = game.scene.map.rooms

var room_occuped = null

onready var states = {
	wandering = get_node("Wandering"),
	looking_for_room = get_node("LookingForRoom"),
	looking_for_staff_room = get_node("LookingForStaffRoom"),
	waiting_for_patient = get_node("WaitingForPatient")
}

var seniority
var specialities
var patients

func _ready():
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
	state_machine.setCurrentState(states.looking_for_room)

func take():
	pathfinding.stop()
	pathfinding.free()

func checkEndPath():
	if pathfinding.animation_completed == true:
		pathfinding.free()
		state_machine.changeState(states.looking_for_room)

func checkWorkRoom():
	if rooms.size() != 0:
		for room in rooms:
			if checkRoomValidity(room):
				room_occuped = room
				room_occuped.is_occuped = true
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[10].x, room.tiles[10].y), self, speed, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.wandering)

func diagnose():
	var present_patient = room_occuped.present_patient[0]
	var present_patient_disease = present_patient.disease
	present_patient.is_diagnosed = true
	if present_patient_disease.disease_type["TREATMENT_ROOM"] == "ROOM_PHARMACY":
		present_patient_disease.type = "pharmacy"
	elif present_patient_disease.disease_type["TREATMENT_ROOM"] == "ROOM_PSYCHIATRIC":
		present_patient_disease.type = "psychiatric"
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
		elif room.type.NAME == "ROOM_TONGUE" || room.type.NAME == "ROOM_GENERAL_DIAGNOSIS" || room.type.NAME == "ROOM_INFLATION" || room.type.NAME == "ROOM_GP" || room.type.NAME == "ROOM_CARDIOGRAM":
			return true
	return false

func moveIntoRoom():
	var rand = randi()%(room_occuped.tiles.size())
	var tile_to_go = room_occuped.tiles[rand]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, speed, map)
	add_child(pathfinding)

func _on_Timer_Timeout():
	pass