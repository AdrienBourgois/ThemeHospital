
extends State

onready var gamescn = get_node("/root/Game").scene
onready var player = gamescn.player

func enter(owner):
	owner.goToAdaptedHealRoom()

func execute(owner):
	if owner.checkEndPath():
		player.increaseHealPatients(1)
		var cost = owner.disease.disease_type.DEFAULT_COST
		player.increaseMoney(cost)
		var label = gamescn.in_game_gui.label_3d.instance()
		gamescn.in_game_gui.add_child(label)
		label.setPosition(owner.get_translation() + Vector3(0,2,0))
		label.display(str(cost) + " $")
		owner.room_occuped.present_patient.clear()
		owner.disease.queue_free()
		owner.state_machine.changeState(owner.states.go_out)

func exit(owner):
	pass