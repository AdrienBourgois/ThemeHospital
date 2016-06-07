
extends "./Object.gd" 

onready var thirsty_timer = get_node("ThirstyTimer")

export var radius = 5
export var thirst = 100 setget, getThirst
export var decrease_when_timout = 10

func _ready():
	thirsty_timer.connect("timeout", self, "decrease")
	thirsty_timer.start()

func decrease():
	thirst -= decrease_when_timout
	if (thirst < 0):
		thirst = 0

func getThirst():
	return thirst