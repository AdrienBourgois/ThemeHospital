extends State

onready var gamescn = get_node("/root/Game").scene
onready var player = gamescn.player

func enter(owner):
	owner.checkGPOffice()

func execute(owner):
	if owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.pathfinding.free()
		var cost = owner.disease_list.DIAG_GP.NEW_COST
		player.increaseMoney(cost)
		var label = gamescn.in_game_gui.label_3d.instance()
		gamescn.in_game_gui.add_child(label)
		label.setPosition(owner.get_translation() + Vector3(0,2,0))
		label.display(str(cost) + " $")
		owner.disease_list.DIAG_GP.MONEY_EARNED += owner.disease_list.DIAG_GP.NEW_COST
		owner.disease_list.DIAG_GP.RECOVERIES += 1
		owner.room_occuped.present_patient.clear()
		owner.state_machine.changeState(owner.states.go_to_adapted_heal_room)

func exit(owner):
	pass