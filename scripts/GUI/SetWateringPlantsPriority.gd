
extends Button

var staff_selected

func _ready():
	connect("pressed", self, "_on_WateringPlants_pressed")
	pass

func _on_WateringPlants_pressed():
	staff_selected = get_node("/root/Game").scene.hire_manager.staff_selected
	get_parent().get_node("SweepingLitterPriority").set_val(staff_selected.sweeping_litter - 2)
	get_parent().get_node("FixingMachineryPriority").set_val(staff_selected.fixing_machinery - 2)
	get_parent().get_node("WateringPlantsPriority").set_val(staff_selected.watering_plants + 2)
	staff_selected.decreaseSweepingLitter()
	staff_selected.decreaseFixingMachinery()
	staff_selected.increaseWateringPlants()
