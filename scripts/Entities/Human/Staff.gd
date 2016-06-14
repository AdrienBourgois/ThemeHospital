
extends "../Entity.gd"

export var id = 0 setget getID, setID
export var name = "" setget getName, setName
export var skill = 0 setget getSkill, setSkill
export var salary = 0 setget getSalary, setSalary

export var warmth = 50.0
export var happiness = 100.0
export var tireness = 100.0
export var count = 0

onready var tile = map.columns[int(get_translation().x/1)][int(get_translation().z/1)]

onready var staff_information_gui = game.scene.in_game_gui.get_node("StaffInformationGUI/StaffGui")
onready var entity_manager = game.scene.entity_manager
onready var pathfinding_res = preload("res://scripts/Map/PathFinding.gd")
var state_machine
onready var info_bar = game.scene.in_game_gui.control_panel.dynamic_info_bar_label

var pathfinding
var staff_stats = {}

func _ready():
	connect("input_event", self, "_on_Staff_input_event")
	get_node("Timer").start()
	set_fixed_process(true)
	gamescn.getStaffNodesArray().append(self)

func addToArray():
	updateStats()
	gamescn.getStaffDataArray().append(staff_stats)

func displayInfo():
	if state_machine:
		info_bar.set_text(get_name() + " : " + tr(state_machine.getCurrentStateName()))

func updateStats():
	position.x = self.get_translation().x 
	position.y = self.get_translation().y
	position.z = self.get_translation().z
	rotation = self.get_rotation().y
	staff_stats = {
	NAME = name,
	X = position.x,
	Y = position.y,
	Z = position.z,
	ID = id,
	ROTATION = rotation,
	SKILL = skill,
	SALARY = salary
	}
	return staff_stats

func take():
	pass

func put():
	pass

func checkEndPath():
	pass

func _on_Staff_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		count += 1
		if count >= 2:
			get_parent().staff_selected = self
			staff_information_gui._ready()
			staff_information_gui.show()
			staff_information_gui.initViewport(self)

func moveTo():
	var tile_to_go = map.corridor_tiles[randi()%map.corridor_tiles.size()]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, 0.2, map)
	add_child(pathfinding)
	
	if (staff_stats.empty()):
		addToArray()
	else:
		gamescn.updateStaffDataArray()

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