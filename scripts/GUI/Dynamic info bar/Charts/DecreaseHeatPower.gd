
extends Button

onready var game = get_node("/root/Game")
onready var heat_manager = game.scene.heat_manager

func _on_DecreaseHeatPower_pressed():
	if heat_manager.heat_ray > 1:
		heat_manager.heat_ray -= 1
		get_parent().get_node("HeatPower").set_value(heat_manager.heat_ray * 10)
		heat_manager.decreaseHeatCost()
		get_parent().get_node("CostHeat").set_text(str(heat_manager.heat_cost))