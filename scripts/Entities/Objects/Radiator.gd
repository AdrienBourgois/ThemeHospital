
extends "Object.gd"

onready var heat_manager = get_node("/root/Game").scene.heat_manager
var heat_ray

func _ready():
	heat_manager.heats.append(self)
	heat_manager._ready()