
extends "../Entity.gd"

var id
var name
var skill
var salary
var seniority
var specialities
var fixing_machinery = 50.0
var watering_plants = 50.0
var sweeping_litter = 50.0
var happiness = 100.0
var tireness = 100.0
var count = 0

onready var staff_information_gui = game.scene.in_game_gui.get_node("StaffInformationGUI/StaffGui")

func _ready():
	get_node("Timer").start()
	pass

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
	fixing_machinery += 5.0
	if fixing_machinery > 100.0:
		fixing_machinery = 100.0
	return fixing_machinery

func increaseWateringPlants():
	watering_plants += 5.0
	if watering_plants > 100.0:
		watering_plants = 100.0
	return watering_plants

func increaseSweepingLitter():
	sweeping_litter += 5.0
	if sweeping_litter > 100.0:
		sweeping_litter = 100.0
	return sweeping_litter

func decreaseFixingMachinery():
	fixing_machinery -= 5.0
	if fixing_machinery < 0.0:
		fixing_machinery = 0.0
	return fixing_machinery

func decreaseWateringPlants():
	watering_plants -= 5.0
	if watering_plants < 0.0:
		watering_plants = 0.0
	return watering_plants

func decreaseSweepingLitter():
	sweeping_litter -= 5.0
	if sweeping_litter < 0.0:
		sweeping_litter = 0.0
	return sweeping_litter