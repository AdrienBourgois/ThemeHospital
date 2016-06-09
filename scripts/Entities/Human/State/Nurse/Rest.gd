
extends State

func enter(owner):
	owner.tire *= -1
	owner.moveIntoRoom()
	owner.is_resting = true

func execute(owner):
	if owner.tireness == 100:
		owner.set_translation(owner.first_pos)
		owner.state_machine.changeState(owner.states.looking_for_room)
		return
		
	if owner.pathfinding.animation_completed == true:
		owner.moveIntoRoom()

func exit(owner):
	owner.tire *= -1
	owner.is_resting = false