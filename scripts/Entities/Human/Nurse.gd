
extends "Staff.gd"

onready var rooms = game.scene.map.rooms
var room_occuped = null
var first_pos
var is_resting = false

export var work_rooms = ["ROOM_PHARMACY", "ROOM_WARD"]

export var tire = 10

onready var states = {
	wandering = get_node("Wandering"),
	looking_for_room = get_node("LookingForRoom"),
	waiting_for_patients = get_node("WaitingForPatients"), 
	looking_for_staff_room = get_node("LookingForStaffRoom"),
	rest = get_node("Rest"),
	go_to_staff_room = get_node("GoToStaffRoom")
	}

func _ready():
	timer.connect("timeout", self, "_on_Timer_Timeout")
	set_process(true)

func _fixed_process(delta):
	if state_machine:
		if is_taken == false:
			state_machine.update()

func put():
	first_pos = get_translation()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.looking_for_room)
	timer.start()

func take():
	pathfinding.stop()
	pathfinding.free()
	get_node("Timer").stop()
	if room_occuped:
		room_occuped.is_occuped = false
		room_occuped = false


func checkEndPath():
	if pathfinding.animation_completed == true || pathfinding.found == false:
		pathfinding.free()
		state_machine.changeState(states.looking_for_room)

func checkWorkRoom():
	if rooms.size() != 0:
		for room in rooms:
			if work_rooms.find(room.type.NAME) != -1:
				if !room.is_occuped:
					checkDistanceToRoom(room)
		
		if room_occuped:
			room_occuped.is_occuped = true
			var tile_to_go = room_occuped.tiles[5]
			pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, speed, map)
			add_child(pathfinding)
			return
	state_machine.changeState(states.wandering)

func checkStaffRoom():
	if rooms.size() != 0:
		for room in rooms:
			if room.type.NAME == "ROOM_STAFF_ROOM":
				room_occuped = room
				var tile_to_go = room_occuped.tiles[5]
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, speed, map)
				add_child(pathfinding)
				is_resting = true
				return
	state_machine.changeState(states.looking_for_room)

func goToStaffRoom():
	if map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["NAME"] == "ROOM_STAFF_ROOM":
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[0].x, room.tiles[0].y), self, speed, map)
				add_child(pathfinding)
				timer.start()
				return
	state_machine.changeState(states.looking_for_room)
	timer.start()

func checkDistanceToRoom(room):
	var position = get_translation()
	if !room_occuped:
		room_occuped = room
	elif position.distance_to(room.tiles[5].get_translation()) < position.distance_to(room_occuped.tiles[5].get_translation()):
		room_occuped = room

func moveIntoRoom():
	var tile_to_go = room_occuped.tiles[randi()%room_occuped.tiles.size()]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, 0.2, map)
	add_child(pathfinding)

func _on_Timer_Timeout():
	if state_machine.getCurrentStateName() != states.go_to_staff_room.name:
		tireness -= 2
		if tireness < 0:
			tireness = 0
		if tireness < 30:
			if pathfinding != null:
				pathfinding.stop()
				pathfinding.free()
				state_machine.changeState(states.go_to_staff_room)
			else:
				state_machine.changeState(states.go_to_staff_room)
	else:
		tireness += 2
		if tireness > 100:
			tireness = 100
