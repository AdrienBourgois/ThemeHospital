
extends "../Entity.gd"

var id
var name
var skill
var salary
var seniority
var specialities

export var fixing_machinery = 50.0
export var watering_plants = 50.0
export var sweeping_litter = 50.0
export var warmth = 50.0
export var happiness = 100.0
export var tireness = 100.0
export var count = 0
export var delta = 5.0
export var max_value = 100

onready var staff_information_gui = game.scene.in_game_gui.get_node("StaffInformationGUI/StaffGui")
onready var entity_manager = game.scene.entity_manager
var patients

func _ready():
	get_node("Timer").start()

func _on_Staff_input_event( camera, event, click_pos, click_normal, shape_idx ):
	patients = get_tree().get_nodes_in_group("Patients")
	diagnostic()
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		count += 1
		if count >= 2:
			get_parent().staff_selected = self
			staff_information_gui._ready()
			staff_information_gui.show()

func diagnostic():
	if !get_tree().get_nodes_in_group("Patients").empty():
		if patients[patients.size() - 1].disease.disease_type["FOUND"] == false:
			sendToGeneralDiag(patients)
			goToGD(self)

func sendToGeneralDiag(patient):
	print("go to the GD!")

func goToGD(doctor):
	if doctor.id == 0:
		print("I'm going to GD!")

func _on_Timer_timeout():
	entity_manager.checkGlobalTemperature(self)
	tireness -= 1

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