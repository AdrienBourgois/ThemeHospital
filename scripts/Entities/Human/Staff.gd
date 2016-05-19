
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
export var happiness = 100.0
export var tireness = 100.0
export var count = 0
export var delta = 5.0
export var max_value = 100

onready var staff_information_gui = game.scene.in_game_gui.get_node("StaffInformationGUI/StaffGui")
onready var entity_manager = game.scene.entity_manager

func _ready():
	get_node("Timer").start()
	set_process(true)
	pass

func _process(delta):
	entity_manager.isInRadiatorRay(self)

func _on_Staff_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		count += 1
		if count >= 2:
			get_parent().staff_selected = self
			staff_information_gui._ready()
			staff_information_gui.show()

func _on_Timer_timeout():
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