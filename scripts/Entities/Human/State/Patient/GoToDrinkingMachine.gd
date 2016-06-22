
extends State

onready var gamescn = get_node("/root/Game").scene
onready var player = gamescn.player

func enter(owner):
	owner.goToDrinkingMachine()

func execute(owner):
	if owner.pathfinding.animation_completed == true || owner.pathfinding.found == false:
		owner.pathfinding.free()
		var cost = 20
		player.increaseMoney(cost)
		var label = gamescn.in_game_gui.label_3d.instance()
		gamescn.in_game_gui.add_child(label)
		label.setPosition(owner.get_translation() + Vector3(0,2,0))
		label.display(str(cost) + " $")
		owner.thirsty = 100
		owner.state_machine.returnToPreviousState()

func exit(owner):
	if owner.object_ptr:
		owner.object_ptr = null