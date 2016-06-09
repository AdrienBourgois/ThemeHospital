
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
		if is_taken == false:
			state_machine.update()

func put():
	first_pos = get_translation()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.looking_for_room)
#	get_node("Timer").start()

func take():
#	get_node("Timer").stop()
	pathfinding.stop()
	pathfinding.free()
#	state_machine = get_node("StateMachine")
#	state_machine.changeState(states.looking_for_room)


func checkEndPath():
	if pathfinding.animation_completed == true || pathfinding.found == false:
		pathfinding.free()
		state_machine.changeState(states.looking_for_room)

func checkWorkRoom():
	if rooms.size() != 0:
		for room in rooms:
			if room.type.NAME == "ROOM_PHARMACY" || room.type.NAME == "ROOM_WARD":
				if !room.is_occuped:
					room_occuped = room
					room_occuped.is_occuped = true
					var tile_to_go = room_occuped.tiles[5]
					pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, 0.2, map)
					add_child(pathfinding)
					return
	state_machine.changeState(states.wandering)

func checkStaffRoom():
	if rooms.size() != 0:
		for room in rooms:
			if room.type.NAME == "ROOM_STAFF_ROOM":
				room_occuped = room
				var tile_to_go = room_occuped.tiles[5]
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, 0.2, map)
				add_child(pathfinding)
				state_machine.changeState(states.rest)
				return
	state_machine.changeState(states.looking_for_room)

func moveIntoRoom():
	var rand = randi()%(room_occuped.tiles.size())
	var tile_to_go = room_occuped.tiles[rand]
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