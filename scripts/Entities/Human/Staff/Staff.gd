
extends "../../Entity.gd"

export var id = 0 setget setID
export var name = "" setget setName
export var skill = 0 setget setSkill
export var salary = 0 setget setSalary

export var warmth = 50.0
export var happiness = 100.0
export var tireness = 100.0
export var count = 0

onready var tile = map.columns[floor(abs(get_translation().x/1))][floor(abs(get_translation().z/1))]

onready var staff_information_gui = preload("res://scenes/GUI/InGameGUI/StaffInformationGUI.scn")
onready var entity_manager = game.scene.entity_manager
onready var pathfinding_res = preload("res://scripts/Map/PathFinding/PathFinding.gd")
var state_machine
onready var info_bar = game.scene.in_game_gui.control_panel.dynamic_info_bar_label
onready var timer = get_node("Timer")
onready var wait_time = timer.get_wait_time()

var pathfinding
var staff_stats = {}
var speed = 0.2

func _ready():
	connect("input_event", self, "_on_Staff_input_event")
	Game.connect("speed_change", self, "_on_Speed_Change")
	set_fixed_process(true)
	gamescn.getStaffNodesArray().append(self)

func addToArray():
	updateStats()
	gamescn.getStaffDataArray().append(staff_stats)

func displayInfo():
	if state_machine:
		info_bar.set_text(name + " : " + tr(state_machine.getCurrentStateName()))

func updateStats():
	position.x = get_translation().x 
	position.y = get_translation().y
	position.z = get_translation().z
	rotation = get_rotation().y
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

func sack():
	pass

func checkEndPath():
	pass

func _on_Staff_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click"):
		count += 1
		if count >= 2:
			get_parent().staff_selected = self
			var node = staff_information_gui.instance()
			game.scene.add_child(node)
			node.get_child(0).initViewport(self)

func deleteFromArray():
	for current in gamescn.getStaffNodesArray():
			var index = gamescn.getStaffNodesArray().find(current)
			if (self == gamescn.getStaffNodesArray()[index]):
				gamescn.getStaffNodesArray().remove(index)
	gamescn.updateStaffDataArray()

func moveTo():
	var tile_to_go = map.corridor_tiles[randi()%map.corridor_tiles.size()]
	pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(tile_to_go.x, tile_to_go.y), self, 0.2, map)
	add_child(pathfinding)
	
	if (staff_stats.empty()):
		addToArray()
	else:
		gamescn.updateStaffDataArray()

func _on_Speed_Change():
	if game.speed > 0:
		var new_set_time = wait_time / Game.speed
		if new_set_time > 0:
			timer.set_wait_time(wait_time / Game.speed)

func setName(val):
	name = val

func setID(val):
	id = val

func setSkill(val):
	skill = val

func setSalary(val):
	salary = val
