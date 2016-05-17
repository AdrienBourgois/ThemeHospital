
tool
extends Control

var editor = null

var tiles = []
var zoom = 10
var node2d = null

var is_inside = false
var current_tile = Vector2(-1,-1)
var current_color = Color(0,0,0)

const tile_type = {"Null":-1, "Decoration":0, "Lobby":1}

class Tile:
	var type = "Null"
	var x = -1
	var y = -1

var size_x = 0
var size_y = 0

func coord_to_index(x, y):
	return (y*size_y)+x

func _init(_x, _y, _editor):
	size_x = _x
	size_y = _y
	editor = _editor
	print("Create new Map of ", size_x, "X", size_y, " tiles")
	
	for y in range(size_y):
		for x in range(size_x):
			var tile = Tile.new()
			tile.x = x
			tile.y = y
			tiles.append(tile)
	print("Map generated !")
	
	node2d = Node2D.new()
	node2d.set_scale(Vector2(zoom,zoom))
	add_child(node2d)
	node2d.connect("draw", self, "draw_map")
	
	set_process_input(true)
	print("Node for map initialized !")

func _input(event):
	if ((event.type == InputEvent.MOUSE_MOTION) or (event.type == InputEvent.MOUSE_BUTTON)):
		var pos = node2d.get_global_pos()
		var size = node2d.get_scale()
		var rect = Rect2(pos.x, pos.y, size.x * size_x, size.y * size_y)
		is_inside = rect.has_point(event.pos)
		
		if(is_inside):
			var pos_mouse_in_node = Vector2(event.pos.x - pos.x, event.pos.y - pos.y)
			current_tile = Vector2(floor(pos_mouse_in_node.x / size.x), floor(pos_mouse_in_node.y / size.y))
		else:
			current_tile = Vector2(-1,-1)
		if (event.is_action_pressed("left_click")):
			if(current_tile != Vector2(-1,-1)):
				change_tile(current_tile.x, current_tile.y)
				node2d.update()

func draw_map():
	for tile in tiles:
		if(tile.type == "Null"):
			node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(1,1,1))
		if(tile.type == "Decoration"):
			node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(0,1,0))
		if(tile.type == "Lobby"):
			node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(0,0,0))

func change_tile(x, y):
	tiles[coord_to_index(x, y)].type = editor.current_brush
	node2d.update()

func change_zoom(_zoom):
	zoom = _zoom
	node2d.set_scale(Vector2(zoom,zoom))