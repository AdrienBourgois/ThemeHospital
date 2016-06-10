
extends Button

onready var game = get_node("/root/Game")
onready var heat_manager = get_node("/root/Game").scene.heat_manager

func _on_IncreaseHeatPower_pressed():
	if heat_manager.heat_ray < 10:
		heat_manager.heat_ray += 1
		get_parent().get_node("HeatPower").set_val(heat_manager.heat_ray * 10)
		heat_manager.increaseHeatCost()
		get_parent().get_node("CostHeat").set_text(str(heat_manager.heat_cost))
