
extends "../Entity.gd"

export var id = 0 setget getID, setID
export var name = "" setget getName, setName
export var skill = 0 setget getSkill, setSkill
export var salary = 0 setget getSalary, setSalary

export var warmth = 50.0
export var happiness = 100.0
export var tireness = 100.0
export var count = 0

onready var staff_information_gui = game.scene.in_game_gui.get_node("StaffInformationGUI/StaffGui")
onready var entity_manager = game.scene.entity_manager

func _ready():
	connect("input_event", self, "_on_Staff_input_event")
	get_node("Timer").start()
	
	print("READY")

func _on_Staff_input_event( camera, event, click_pos, click_normal, shape_idx ):
	print("ID[",id,"] | Name[", name, "] | Skill[", skill, "] | Salary[", salary, "]")
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		count += 1
		if count >= 2:
			
			get_parent().staff_selected = self
			staff_information_gui._ready()
			staff_information_gui.show()

func getName():
	return name
 
func setName(val):
	name = val

func getID():
	return id

func setID(val):
	id = val

func getSkill():
	return skill

func setSkill(val):
	skill = val

func getSalary():
	return salary

func setSalary(val):
	salary = val