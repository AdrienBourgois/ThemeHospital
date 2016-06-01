
extends "Object.gd"

export var is_occuped = false

onready var hire_manager = get_node("/root/Game").scene.hire_manager

func _ready():
	created()
	pass

func created():
	for staff in hire_manager.get_children():
		if staff["id"] == 3:
			staff.reception_desk.append(self)
	pass