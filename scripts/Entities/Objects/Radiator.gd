
extends "Object.gd"

onready var entity_manager = get_node("/root/Game").scene.entity_manager
var heating_cost = 7
var heat_ray = 1

func _ready():
	entity_manager.heats.append(self)

#if ((v/10)%2):
#	+8
#else:
#	+7