
extends "../Entity.gd"

onready var timer = get_node("Timer")
onready var available = get_node("Available") setget, getAvailable

export var object_name = " " setget setName, getName
export var price = 100 setget getPrice, setPrice
export var expense_per_month = 0
export var in_room_object = false
export var room_id = 0

var object_stats = {}
var blink_number = 10
var idx = 0
var type = {}

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
		setAvailableTile(true)
		available.hide()
		available.timer.stop()
		if (object_stats.empty()):
			addToArray()
		else:
			gamescn.updateObjectsArray()
		
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("right_click") && can_selected == false:
		if (in_room_object):
			return
		available.on()
		is_selected = true
		can_selected = true
		setAvailableTile(false)
		set_process_input(true)

func setAvailableTile(boolean):
	var node = null
	if (boolean):
		node = self
	var vector_pos = Vector2(get_translation().x, get_translation().z)
	var rotation = get_rotation()
	var tile = map.getTile(vector_pos)
	tile.setObject(node)
	if (int(rotation.y) == int(deg2rad(-90))):
		tile.neighbours.Left.setObject(node)
	elif (int(rotation.x) == int(deg2rad(-180))):
		tile.neighbours.Up.setObject(node)
	elif (int(rotation.y) == int(deg2rad(90))):
		tile.neighbours.Right.setObject(node)
	else:
		tile.neighbours.Down.setObject(node)

func checkAvailableTileType():
	var vector_pos = Vector2(get_translation().x, get_translation().z)
	var rotation = get_rotation()
	var tile = map.getTile(vector_pos)
	if (int(rotation.y) == int(deg2rad(-90)) and tile.neighbours.Left.room_type.ID != room_id):
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
	var vector_pos = Vector2(get_translation().x, get_translation().z)
	var rotation = get_rotation()
	var tile = map.getTile(vector_pos)
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
	type = map.columns[map.tile_on_cursor.x][map.tile_on_cursor.y].room_type
	if (in_room_object and type.ID != room_id):
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
	var node = map.columns[map.tile_on_cursor.x][map.tile_on_cursor.y]
	type = node.room_type
	if (in_room_object):
		if (type.ID != room_id):
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