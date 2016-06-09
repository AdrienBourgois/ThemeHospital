
extends "Staff.gd"

onready var rooms = game.scene.map.rooms
var room_occuped = null
var first_pos
var is_resting = false

export var tire = 10

onready var states = {
	wandering = get_node("Wandering"),
	looking_for_room = get_node("LookingForRoom"),
	waiting_for_patients = get_node("WaitingForPatients"), 
	looking_for_staff_room = get_node("LookingForStaffRoom"),
	rest = get_node("Rest") }

func _ready():
	set_process(true)

func _fixed_process(delta):
	if state_machine:
		state_machine.update()

func put():
	first_pos = get_translation()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.looking_for_room)
#	get_node("Timer").start()

func take():
	state_machine = get_node("StateMachine")
	state_machine.changeState(states.looking_for_room)
#	get_node("Timer").stop()

func checkEndPath():
	if pathfinding.animation_completed == true:
		pathfinding.free()
		state_machine.changeState(states.looking_for_room)

func checkWorkRoom():
	if rooms.size() != 0:
		for room in rooms:
			if room.type.NAME == "ROOM_PHARMACY" || room.type.NAME == "ROOM_WARD":
				if !room.is_occuped:
					room_occuped = room
					room_occuped.is_occuped = true
					set_translation(room.tiles[0].get_translation())
					state_machine.changeState(states.waiting_for_patients)
					return
	state_machine.changeState(states.wandering)

func checkStaffRoom():
	if rooms.size() != 0:
		for room in rooms:
			if room.type.NAME == "ROOM_STAFF_ROOM":
				room_occuped = room
				set_translation(room.tiles[0].get_translation())
				state_machine.changeState(states.rest)
				return
	state_machine.changeState(states.looking_for_room)

func moveIntoRoom():
	var rand = randi()%(room_occuped.tiles.size() - 1)
	print(rand)
	var tile_to_go
	if rand != prev_rand_tile:
		tile_to_go = room_occuped.tiles[rand]
	else:
		tile_to_go = room_occuped.tiles[rand + 1]
	prev_rand_tile = rand
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, 0.2, map)
	add_child(pathfinding)

func _on_Timer_timeout():
	pass
#	tireness -= tire
#	#print(tireness)
#	
#	if tireness <= 50 && !is_resting:
#		pathfinding.free()
#		state_machine.changeState(states.looking_for_staff_room)
#		return
#	if tireness < 0:
#		tireness = 0
#	elif tireness > 100:
#		tireness = 100