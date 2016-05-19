
extends Button

onready var entity_manager = get_node("/root/Game").scene.entity_manager
var heats

func _on_IncreaseHeatPower_pressed():
	heats = entity_manager.heats
	for heat in heats:
		if heat.heat_ray < 100:
			heat.heat_ray += 1
			print(heat.heat_ray)
			get_parent().get_node("HeatPower").set_val(heat.heat_ray * 10)
