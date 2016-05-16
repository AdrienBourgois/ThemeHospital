
extends "../Entity.gd"

var id
var name
var skill
var salary
var seniority
var specialities
var happiness = 100.0
var tireness = 100.0
var count = 0

onready var staff_information_gui = game.scene.in_game_gui.get_node("StaffInformationGUI/StaffGui")

func _ready():
	get_node("Timer").start()
	pass

func _on_Staff_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		count += 1
		if count >= 2:
			get_parent().staff_selected = self
			staff_information_gui.staff_selected = get_parent().staff_selected
			staff_information_gui._ready()
			staff_information_gui.show()
			staff_information_gui.get_node("Happiness").set_val(happiness)
			staff_information_gui.get_node("Tireness").set_val(tireness)
			staff_information_gui.get_node("Skill").set_val(skill)
			if id == 0:
				staff_information_gui.get_node("Seniority").set_val(seniority)
			staff_information_gui.get_node("Salary").set_text(str(salary))

func _on_Timer_timeout():
	tireness -= 1