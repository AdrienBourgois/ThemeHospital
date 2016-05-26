
extends "../Entity.gd"

onready var timer = get_node("Timer")

export var object_name = " " setget setName, getName
export var price = 100 setget getPrice, setPrice
export var expense_per_month = 0
export var in_room_object = false
export var room_id = 0

var object_stats = {}
var blink_number = 10
var idx = 0

func _ready():
	timer.set_autostart(false)
	timer.set_wait_time(0.01)
	timer.connect("timeout", self, "blink")

func _on_Entity_input_event( camera, event, click_pos, click_normal, shape_idx ):
	if event.type == InputEvent.MOUSE_BUTTON && event.is_action_pressed("left_click") && can_selected == true:
		var type = map.columns[map.tile_on_cursor.x][map.tile_on_cursor.y].room_type
		if (in_room_object):
			if (type.ID != room_id):
				error()
				return
		if (type.ID != 0):
			error()
			return
		can_selected = false
		set_process_input(false)
		if (object_stats.empty()):
			addToArray()
		else:
			gamescn.updateObjectsArray()
		
	elif event.type == InputEvent.MOUSE_BUTTON && event.is_action_released("right_click") && can_selected == false:
		if (in_room_object):
			return
		gamescn.updateObjectsArray()
		is_selected = true
		can_selected = true
		set_process_input(true)

func blink():
	self.cube.set_hidden(not cube.is_hidden())
	if (idx > blink_number):
		timer.stop()
		self.cube.show()
		idx = 0
	idx += 1

func error():
	timer.start()

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

func setName(value):
	object_name = value

func getName(): 
	return object_name

func setPrice(value):
	price = value

func getPrice():
	return price