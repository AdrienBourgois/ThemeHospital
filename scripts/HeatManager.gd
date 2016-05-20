
extends Spatial

onready var game = get_node("/root/Game")
export var heat_ray = 0
var heat_cost = 0
var heats = []

func _ready():
	for heat in heats:
		heat.heat_ray = heat_ray
		if heats.size() != 0:
			increaseHeatCost()

func increaseHeatCost():
	if heats.size() != 0:
		for heat in heats:
			if (heat_ray/1)%2:
				game.scene.player.increaseExpense(7)
				heat_cost += 7
			else:
				game.scene.player.increaseExpense(8)
				heat_cost += 8

func decreaseHeatCost():
	if heats.size() != 0:
		for heat in heats:
			if (heat_ray/1)%2:
				game.scene.player.decreaseExpense(8)
				heat_cost -= 8
			else:
				game.scene.player.decreaseExpense(7)
				heat_cost -= 7

