
extends Panel

onready var game = get_node("/root/Game")
onready var selector = get_node("SpeedSelector")

func _ready():
	selector.add_item("SLOWEST", 0)
	selector.add_item("SLOWER", 1)
	selector.add_item("NORMAL", 2)
	selector.add_item("MAX", 3)
	selector.add_item("AND THEN SOME MORE", 4)
	selector.select(2)

func _on_SpeedSelector_item_selected( ID ):
	game.speed = game.speed_array[ID]