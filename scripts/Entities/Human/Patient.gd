
extends KinematicBody

export var machine = false
var happiness
var thirsty
var warmth
export var global_temperature = 0
var count
onready var disease = get_node("Disease")

func _ready():
	get_node("Timer").start()
	count = 0
	pass

func _on_Timer_timeout():
	count += 1
	if global_temperature <= 16:
		warmth -= 2
	elif global_temperature >= 24:
		warmth += 2
	
	if warmth <= 40 || warmth >= 60:
		if count == 5:
			happiness -= 2
	
	thirsty -= 2
	if thirsty <= 20:
		if count == 5:
			happiness -= 2
			count = 0
		if machine == true:
			thirsty += 50
	print("Thirsty = ", thirsty, " | Warmth = ", warmth, " | Happiness = ", happiness)