extends Node

var columns = []
var tiles = []
var rooms = []
var rooms_data = []
var tiles_data = []
onready var global_client = get_node("/root/GlobalClient")
onready var tile_res = preload("res://scenes/Map/Tile.scn")
onready var room_class = preload("res://scripts/Map/Room.gd")
onready var ressources = preload("res://scripts/Map/MapRessources.gd").new() setget ,getResources
onready var stats = {}
onready var path

var new_room_from = Vector2(-1,-1)
var previous_current_selection = []
var new_room_to = Vector2(-1,-1)
var new_room_type = {}

var size_x = 0
var size_y = 0

var tile_on_cursor = Vector2(-1, -1)
var center_tile_on_cursor = Vector2(-1, -1)

func _ready():
	create_map("res://Maps/Map1.lvl")

func createStatsDict():
	for current in tiles:
		tiles_data.append(current.createStatsDict())
	stats = {
	FILE_PATH = path,
	TILES = tiles_data
	}
	return stats

func resetStatsDict():
	stats.clear()

func create_map(file_path):
	path = file_path
	var file = File.new()
	file.open(file_path, File.READ)
	
	size_x = file.get_line().to_int()
	size_y = file.get_line().to_int()
	
	var lines_str = []
	for i in range(size_y):
		lines_str.append(file.get_line())
	
	for x in range(size_x):
		var column = []
		for y in range(size_y):
			var tile = tile_res.instance()
			add_child(tile)
			var tile_type = lines_str[y].substr(x, 1).to_int()
			if (tile_type == 0):
				tile.create(x, y, ressources.grass)
			elif (tile_type == 1):
				tile.create(x, y, ressources.lobby)
			tile.set_translation(Vector3(x, 0, y))
			tiles.append(tile)
			column.append(tile)
		columns.append(column)
	for tile in tiles:
		tile.get_all_neighbour()
		tile.update_walls("Up")
		tile.update_walls("Left")
		tile.update_walls("Right")
		tile.update_walls("Down")

func get_tile(coords):
	for tile in tiles:
		if (tile.x == coords.x && tile.y == coords.y):
			return tile
	return null

func get_list(from, to):
	if (from > to):
		var swap_tmp = from
		from = to
		to = swap_tmp
	
	var selection = []
	if(from.y > to.y):
		for tile in tiles:
			if ((tile.x >= from.x && tile.x <= to.x) && (tile.y <= from.y && tile.y >= to.y)):
				selection.append(tile)
	else:
		for tile in tiles:
			if ((tile.x >= from.x && tile.x <= to.x) && (tile.y >= from.y && tile.y <= to.y)):
				selection.append(tile)
	
	return selection

func is_huge_as(from, to, size):
	if (from > to):
		var swap_tmp = from
		from = to
		to = swap_tmp
	
	if(from.y <= to.y):
		if (to.x - from.x >= size - 1 && to.y - from.y >= size - 1):
			return true
		else:
			return false
	else:
		if (to.x - from.x >= size - 1 && from.y - to.y >= size - 1):
			return true
		else:
			return false

func is_new_room_valid():
	if(!is_huge_as(new_room_from, new_room_to, new_room_type.SIZE_MIN)):
		return false
	for tile in previous_current_selection:
		if (tile.room_type.ID != ressources.lobby.ID):
			return false
	return true

func new_room(state, parameters):
	if (state == "new"):
		new_room_from = Vector2(-1,-1)
		previous_current_selection = []
		new_room_to = Vector2(-1,-1)
		new_room_type = {}
		
		new_room_type = parameters
		for tile in tiles:
			tile.staticBody.connect("input_event", tile, "_input_event")
			tile.staticBody.connect("mouse_enter", tile, "hover_on", [colors.brown])
			tile.staticBody.connect("mouse_exit", tile, "hover_off")

	elif (state == "from"):
		new_room_from = parameters
		for tile in tiles:
			tile.currently_create_room = true
			tile.staticBody.disconnect("mouse_enter", tile, "hover_on")

	elif (state == "current"):
		new_room_to = parameters
		for tile in previous_current_selection:
			tile.hover_off()
		previous_current_selection = get_list(new_room_from, new_room_to)
		for tile in previous_current_selection:
			if (is_new_room_valid()):
				tile.hover_on(colors.blue)
			else:
				tile.hover_on(colors.red)

	elif (state == "to" && new_room_from != Vector2(-1,-1)):
		new_room_to = parameters
		for tile in tiles:
			tile.staticBody.disconnect("input_event", tile, "_input_event")
			tile.staticBody.disconnect("mouse_exit", tile, "hover_off")
			tile.currently_create_room = false
	
	elif (state == "cancel"):
		for tile in tiles:
			tile.hover_off()
			tile.currently_create_room = false
		if(new_room_to == Vector2(-1,-1)):
			for tile in tiles:
				tile.staticBody.disconnect("input_event", tile, "_input_event")
				tile.staticBody.disconnect("mouse_exit", tile, "hover_off")
		if(new_room_from == Vector2(-1,-1)):
			for tile in tiles:
				tile.staticBody.disconnect("mouse_enter", tile, "hover_on")
		new_room_from = Vector2(-1,-1)
		previous_current_selection = []
		new_room_to = Vector2(-1,-1)
		new_room_type = {}

	elif (state == "create"):
		if (is_new_room_valid()):
			var room = room_class.new(new_room_from, new_room_to, new_room_type, self)
			rooms.append(room)
			for tile in previous_current_selection:
				tile.hover_off()
			new_room_from = Vector2(-1,-1)
			previous_current_selection = []
			new_room_to = Vector2(-1,-1)
			new_room_type = {}
		else:
			print("New room is not valid !")
			test_path()
			new_room("cancel", null)

func can_go(from, direction):
	var tile_from = columns[from.x][from.y]
	if (direction == "Up"):
		var tile_to = tile_from.neighbours.Up
		if (tile_to == null):
			return false
		if(tile_from.walls_types.Up == 1 or tile_from.walls_types.Up == 2 or tile_to.walls_types.Down == 1 or tile_to.walls_types.Down == 2):
			return false
	elif (direction == "Down"):
		var tile_to = tile_from.neighbours.Down
		if (tile_to == null):
			return false
		if(tile_from.walls_types.Down == 1 or tile_from.walls_types.Down == 2 or tile_to.walls_types.Up == 1 or tile_to.walls_types.Up == 2):
			return false
	elif (direction == "Right"):
		var tile_to = tile_from.neighbours.Right
		if (tile_to == null):
			return false
		if(tile_from.walls_types.Right == 1 or tile_from.walls_types.Right == 2 or tile_to.walls_types.Left == 1 or tile_to.walls_types.Left == 2):
			return false
	elif (direction == "Left"):
		var tile_to = tile_from.neighbours.Left
		if (tile_to == null):
			return false
		if(tile_from.walls_types.Left == 1 or tile_from.walls_types.Left == 2 or tile_to.walls_types.Right == 1 or tile_to.walls_types.Right == 2):
			return false
	
	return true

func sendRoomToServer():
	var packet = "/game 5 " + str(new_room_from.x) + " " + str(new_room_from.y) + " " + str(new_room_to.x) + " " + str(new_room_to.y) + " " + str(new_room_type.ID)
	global_client.addPacket(packet)

func getResources():
	return ressources

#------------------------------------------------------------------------------------------------#

var PathFinding_res = preload("res://scripts/Map/PathFinding.gd")

func test_path():
	print("Start")
	var path = PathFinding_res.new(Vector2(0,39), Vector2(39,39), self)
	print("End")