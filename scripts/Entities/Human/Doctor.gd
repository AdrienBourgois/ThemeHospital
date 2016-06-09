
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
			if (room.is_occuped == false && (room.type.NAME == "ROOM_TONGUE" || room.type.NAME == "ROOM_GENERAL_DIAGNOSIS" || room.type.NAME == "ROOM_INFLATION" || room.type.NAME == "ROOM_GP" || room.type.NAME == "ROOM_CARDIOGRAM")):
				room_occuped = room
				room_occuped.is_occuped = true
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[5].x, room.tiles[5].y), self, 0.2, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.wandering)

func moveIntoRoom():
	var rand = randi()%(room_occuped.tiles.size() - 1)
	var tile_to_go
	if rand != prev_rand_tile:
		tile_to_go = room_occuped.tiles[rand]
	else:
		tile_to_go = room_occuped.tiles[rand + 1]
	prev_rand_tile = rand
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, 0.2, map)
	add_child(pathfinding)