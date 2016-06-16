
extends "../Entity.gd"

export var id = 0 setget getID, setID
export var name = "" setget getName, setName
export var skill = 0 setget getSkill, setSkill
export var salary = 0 setget getSalary, setSalary

export var warmth = 50.0
export var happiness = 100.0
export var tireness = 100.0
export var count = 0

onready var tile = map.columns[floor(abs(get_translation().x/1))][floor(abs(get_translation().z/1))]

onready var staff_information_gui = game.scene.in_game_gui.get_node("StaffInformationGUI/StaffGui")
onready var entity_manager = game.scene.entity_manager
onready var pathfinding_res = preload("res://scripts/Map/PathFinding.gd")
var state_machine
onready var info_bar = game.scene.in_game_gui.control_panel.dynamic_info_bar_label

var pathfinding
var staff_stats = {}
var speed = 0.2

func _ready():
	connect("input_event", self, "_on_Staff_input_event")
	get_node("Timer").connect("timeout", self, "on_Timer_Timeout")
	Game.connect("speed_change", self, "_on_Speed_Change")
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
	get_node("Timer").set_wait_time(get_node("Timer").get_time_left() / Game.speed)

func _on_Timer_Timeout():
	if id != 3:
		tireness -= 2
	
	if tireness < 0:
		tireness = 0
	elif tireness > 100:
		tireness = 100
	
	if tireness < 50:
		state_machine.changeState(get_node("GoToStaffRoom"))

func goToStaffRoom():
	if map.rooms.size() != 0:
		for room in map.rooms:
			if room.type["NAME"] == "ROOM_STAFF_ROOM":
				pathfinding = pathfinding_res.new(Vector2(get_translation().x, get_translation().z), Vector2(map.tile[0].x, map.tile[0].y), self, speed, map)
			pass
	pass

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