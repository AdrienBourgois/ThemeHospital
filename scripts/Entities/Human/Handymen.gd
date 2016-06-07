
extends "Staff.gd"

export var fixing_machinery = 50.0
export var watering_plants = 50.0
export var sweeping_litter = 50.0
export var hospital_sanity = 100
export var engine_broken = 100

onready var object_array = game.scene.getObjectsNodesArray()


var delta = 5.0
var max_value = 100.0
var plant_pos

func checkEndPath():
	if pathfinding.animation_completed == true:
		checkWork()

func checkPlant():
	if object_array.size() != 0:
		for plant in object_array:
			if plant.object_name == "Plant":
				plant_pos = Vector2(plant.get_translation().x, plant.get_translation().z)
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), plant_pos, self, 0.2, map)
				add_child(pathfinding)
				return

func _fixed_process(delta):
	if state_machine:
		state_machine.update()

func put():
	get_node("Timer").start()
	state_machine = get_node("StateMachine")
	state_machine.setOwner(self)
	state_machine.setCurrentState(get_node("RandomMovement"))

func checkWork():
	if checkPlantThirsty():
		state_machine.changeState(get_node("GoToWater"))
	elif hospital_sanity <= 50:
		state_machine.changeState(get_node("GoToSweep"))
	elif engine_broken <= 50:
		state_machine.changeState(get_node("GoToRepare"))
	else:
		state_machine.changeState(get_node("RandomMovement"))

func checkPlantThirsty():
	if object_array.size() != 0:
		for plant in object_array:
			if plant.object_name == "Plant":
				print(plant.getThirst())
				if plant.getThirst() <= 50:
					return true

func watering():
	if object_array.size() != 0:
		for plant in object_array:
			if plant.object_name == "Plant":
				plant.setThirst() = 100

func increaseFixingMachinery():
	fixing_machinery += delta
	if fixing_machinery > max_value:
		fixing_machinery = max_value
	return fixing_machinery

func increaseWateringPlants():
	watering_plants += delta
	if watering_plants > max_value:
		watering_plants = max_value
	return watering_plants

func increaseSweepingLitter():
	sweeping_litter += delta
	if sweeping_litter > max_value:
		sweeping_litter = max_value
	return sweeping_litter

func decreaseFixingMachinery():
	fixing_machinery -= delta
	if fixing_machinery < 0.0:
		fixing_machinery = 0.0
	return fixing_machinery

func decreaseWateringPlants():
	watering_plants -= delta
	if watering_plants < 0.0:
		watering_plants = 0.0
	return watering_plants

func decreaseSweepingLitter():
	sweeping_litter -= delta
	if sweeping_litter < 0.0:
		sweeping_litter = 0.0
	return sweeping_litter