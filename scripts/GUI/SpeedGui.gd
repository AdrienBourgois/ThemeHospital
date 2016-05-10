
extends Panel

export(int, 0,4) var default_speed = 2
onready var game = get_node("/root/Game")
onready var selector = get_node("SpeedSelector")

func _ready():
	if !game.multiplayer:
		selector.add_item(tr("TXT_SLOWEST"), 0)
		selector.add_item(tr("TXT_SLOWER"), 1)
		selector.add_item(tr("TXT_NORMAL"), 2)
		selector.add_item(tr("TXT_MAX"), 3)
		selector.add_item(tr("TXT_SOME_MORE"), 4)
		selector.select(default_speed)
	else:
		hide()

func _on_SpeedSelector_item_selected( ID ):
	game.speed = game.speed_array[ID]