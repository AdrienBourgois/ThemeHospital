
extends "../Entity.gd"

onready var timer = get_node("Timer")
onready var available = get_node("Available") setget, getAvailable
onready var temp_array = gamescn.getTempObjectsNodesArray()

export var object_name = " " setget setName, getName
export var price = 100 setget getPrice, setPrice
export var expense_per_month = 0
export var in_room_object = false
export var room_id = 0

var object_stats = {}
var blink_number = 10
var idx = 0
var type = {}
var vector_pos
var tile
export var big_object = false

func _ready():
	timer.set_autostart(false)
	timer.set_wait_time(0.01)
	timer.connect("timeout", self, "blink")
	gamescn.objects_nodes_array.append(self)

func _on_Entity_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if (is_selected and can_selected):
		checkAvailableProcess()
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		if (!checkAvailable()):
			return
		can_selected = false
		set_process_input(false)
		gamescn.setHaveObject(false)
		setAvailableTile(true)
		available.hide()
		available.timer.stop()
		put()
		nextObject()
		if (object_stats.empty()):
			addToArray()
		else:
			gamescn.updateObjectsArray()
		
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("right_click") && can_selected == false:
		if (in_room_object or gamescn.getHaveObject()):
			return
		available.on()
		is_selected = true
		can_selected = true
		gamescn.setHaveObject(true)
		setAvailableTile(false)
		set_process_input(true)

func hideOtherObjects():
	for current in temp_array:
		current.hide()
	if (!temp_array.empty()):
		temp_array[0].show()

func nextObject():
	if (!temp_array.empty()):
		temp_array.pop_front()
		if (!temp_array.empty()):
			temp_array[0].show()

func setAvailableTile(boolean):
	var node = null
	if (boolean):
		node = self
	updateTilePosition()
	tile.setObject(node)
	if (int(rotation.y) == int(deg2rad(-90))):
		tile.neighbours.Left.setObject(node)
	elif (int(rotation.x) == int(deg2rad(-180))):
		tile.neighbours.Up.setObject(node)
	elif (int(rotation.y) == int(deg2rad(90))):
		tile.neighbours.Right.setObject(node)
	else:
		tile.neighbours.Down.setObject(node)

func updateTilePosition():
	vector_pos = Vector2(get_translation().x, get_translation().z)
	rotation = get_rotation()
	tile = map.getTile(vector_pos)

func checkAvailableBigObjectTile():
	for current in cube.get_children():
		var current_position = Vector2(current.get_global_transform().origin.x, current.get_global_transform().origin.z)
		var current_tile = map.getTile(current_position)
		if (current_tile.getObject() or current_tile.room_type.ID != room_id):
			return false
	return true

func checkAvailableTileType():
	updateTilePosition()
	if (tile.getObject()):
		return false
	elif (int(rotation.y) == int(deg2rad(-90)) and tile.room_type.ID != room_id):
		return false
	elif (int(rotation.y) == int(deg2rad(-90)) and tile.neighbours.Left.room_type.ID != room_id):
		return false
	elif (int(rotation.x) == int(deg2rad(-180))and tile.neighbours.Up.room_type.ID != room_id):
		return false
	elif (int(rotation.y) == int(deg2rad(90)) and tile.neighbours.Right.room_type.ID != room_id):
		return false
	elif (int(rotation.y) == int(deg2rad(0)) and tile.neighbours.Down.room_type.ID != room_id):
		return false
	else:
		return true

func checkAvaiblableTile():
	updateTilePosition()
	if (int(rotation.y) == int(deg2rad(-90)) and tile.neighbours.Left.getObject()):
		return false
	elif (int(rotation.x) == int(deg2rad(-180))and tile.neighbours.Up.getObject()):
		return false
	elif (int(rotation.y) == int(deg2rad(90)) and tile.neighbours.Right.getObject()):
		return false
	elif (int(rotation.y) == int(deg2rad(0)) and tile.neighbours.Down.getObject()):
		return false
	else:
		return true

func checkAvailableProcess():
	updateTilePosition()
	type = map.getTile(vector_pos).room_type
	if (in_room_object and type.ID != room_id):
		available.off()
	elif (big_object and !checkAvailableBigObjectTile()):
		available.off()
	elif (!checkAvaiblableTile()):
		available.off()
	elif (!in_room_object and type.ID != 0):
		available.off()
	elif (!checkAvailableTileType()):
		available.off()
	else: 
		available.on()

func checkAvailable():
	updateTilePosition()
	var node = map.getTile(vector_pos)
	type = node.room_type
	if (in_room_object):
		if (big_object):
			if (!checkAvailableBigObjectTile()):
				error()
				return false
		if (type.ID != room_id or !checkAvaiblableTile() or !checkAvailableTileType()):
			error()
			return false
	elif (type.ID != 0):
		error()
		return false
	elif (map.getTileOnCursorNode().getObject()):
		error()
		return false
	elif (!checkAvaiblableTile()):
		error()
		return false
	elif (!checkAvailableTileType()):
		error()
		return false
	return true

func blink():
	self.cube.set_hidden(not cube.is_hidden())
	if (idx > blink_number):
		timer.stop()
		self.cube.show()
		idx = 0
	idx += 1

func error():
	timer.start()
	available.off()
	game.feedback.display("TOOLTIP_OBJECT_ERROR")

func updateStats():
	position.x = self.get_translation().x 
	position.y = self.get_translation().y
	position.z = self.get_translation().z
	rotation = self.get_rotation().y
	object_stats = {
	NAME = object_name,
	X = position.x,
	Y = position.y,
	Z = position.z,
	ROTATION = rotation
	}
	return object_stats

func addToArray():
	updateStats()
	gamescn.objects_array.append(object_stats)

func getAvailable():
	return available

func setName(value):
	object_name = value

func getName(): 
	return object_name

func setPrice(value):
	price = value

func getPrice():
	return price

func put():
	pass