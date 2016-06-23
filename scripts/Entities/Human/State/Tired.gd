
extends State

var timer_is_started = false

func enter(owner):
	owner.get_node("Timer").stop()
	owner.goToStaffRoom()

func execute(owner):
	if timer_is_started == false:
		if owner.pathfinding.animation_completed == true:
			owner.get_node("Timer").start()
			timer_is_started = true
	if owner.tireness == 100:
		timer_is_started = false
		if owner.id == 2:
			owner.state_machine.changeState(owner.states.go_to_water)
		else:
			owner.state_machine.changeState(owner.states.looking_for_room)

func exit(owner):
	pass