
extends KinematicBody

export var machine = false
var happiness
var thirsty
var warmth
export var global_temperature = 0
var count
onready var disease = get_node("Disease")
onready var child_count = get_parent().get_child_count()


func _ready():
	get_node("Timer").start()
	count = 0
	pass

func checkGlobalTemperature():
	if warmth > 0:
		if global_temperature <= 16:
			warmth -= 2
		elif global_temperature >= 24:
			warmth += 2

func calculateHappiness(is_increase):
	if count == 5:
		if is_increase == false:
			happiness -= 2
		elif is_increase == true && happiness < 100:
			happiness += 2

func checkThirsty():
	if thirsty > 0:
		thirsty -= 2
	if thirsty <= 20:
		print(count)
		calculateHappiness(false)
		if machine == true:
			thirsty += 50
	else:
		calculateHappiness(true)

func checkWarmth():
	if warmth <= 40 || warmth >= 60:
		calculateHappiness(false)
	else:
		calculateHappiness(true)

func _on_Timer_timeout():
	count += 1
	checkGlobalTemperature()
	checkThirsty()
	checkWarmth()
	
	if count == 5:
		count = 0
	print("Patient " + str(get_tree().get_nodes_in_group("Patients").size()), ": Thirsty = ", thirsty, " | Warmth = ", warmth, " | Happiness = ", happiness)