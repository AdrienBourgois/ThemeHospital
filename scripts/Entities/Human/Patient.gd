
extends KinematicBody

export var machine = false
var happiness
var thirsty
var warmth
var count
onready var disease = get_node("Disease")
onready var entity_manager = get_parent()
onready var child_count = entity_manager.get_child_count()


func _ready():
	get_node("Timer").start()
	count = 0

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
	entity_manager.checkGlobalTemperature(self)
	checkThirsty()
	checkWarmth()
	
	if count == 5:
		count = 0