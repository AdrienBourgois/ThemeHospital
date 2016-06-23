
extends "Staff.gd"

export var watering_plants = 50.0

onready var object_array = game.scene.getObjectsNodesArray()
onready var states = {
	wandering = get_node("RandomMovement"),
	go_to_water = get_node("GoToWater"),
	go_to_staff_room = get_node("GoToStaffRoom")
}

var delta = 5.0
var max_value = 100.0
var plant_pos

func checkEndPath():
	pathfinding.free()
	checkWork()

func checkPlant():
	if object_array.size() != 0:
		for plant in object_array:
			if plant.object_name == "Plant" && plant.getThirst() <= 90:
				plant_pos = Vector2(plant.get_translation().x, plant.get_translation().z)
				plant.is_occuped = true
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), plant_pos, self, speed, map)
				add_child(pathfinding)
				return
	state_machine.changeState(states.wandering)

func _fixed_process(delta):
	if state_machine:
		if is_taken == false:
			state_machine.update()

func put():
	timer.start()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(states.wandering)
	is_taken = false

func take():
	pathfinding.stop()
	pathfinding.free()

func checkWork():
	if checkPlantThirsty():
		state_machine.changeState(states.go_to_water)
	else:
		state_machine.changeState(states.wandering)

func checkPlantThirsty():
	if object_array.size() != 0:
		for plant in object_array:
			if plant.object_name == "Plant" && plant.getThirst() <= 90:
				return true

func watering():
	if object_array.size() != 0:
		for plant in object_array:
			if plant.object_name == "Plant" && Vector2(get_translation().x, get_translation().z) == Vector2(plant.get_translation().x, plant.get_translation().z):
				plant.setThirst(100)
				plant.is_occuped = false

func increaseWateringPlants():
	watering_plants += delta
	if watering_plants > max_value:
		watering_plants = max_value
	return watering_plants

func decreaseWateringPlants():
	watering_plants -= delta
	if watering_plants < 0.0:
		watering_plants = 0.0
	return watering_plants

func goToStaffRoom():
	if map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["NAME"] == "ROOM_STAFF_ROOM":
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(room.tiles[0].x, room.tiles[0].y), self, speed, map)
				add_child(pathfinding)
				timer.start()
				return
	state_machine.returnToPreviousState()
	timer.start()

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

