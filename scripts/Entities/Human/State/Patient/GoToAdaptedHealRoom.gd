 
extends State

onready var gamescn = get_node("/root/Game").scene
onready var player = gamescn.player

func enter(owner):
	owner.goToAdaptedHealRoom()

func execute(owner):
	if owner.pathfinding.animation_completed || !owner.pathfinding.found:
		owner.pathfinding.free()
		player.increaseHealPatients(1)
		var cost = owner.disease.disease_type.NEW_COST
		player.increaseMoney(cost)
		var label = gamescn.in_game_gui.label_3d.instance()
		gamescn.in_game_gui.add_child(label)
		label.setPosition(owner.get_translation() + Vector3(0,2,0))
		label.display(str(cost) + " $")
		owner.disease.disease_type.MONEY_EARNED += owner.disease.disease_type.NEW_COST
		owner.disease.disease_type.RECOVERIES += 1
		owner.room_occuped.present_patient.clear()
		owner.disease.queue_free()
		owner.state_machine.changeState(owner.states.go_out)

func exit(owner):
	pass