
tool
extends Control

var editor = null

var tiles = []
var zoom = 10
var node2d = null

var is_inside = false
var current_tile = Vector2(-1,-1)
var need_update = false
var need_regeneration = true
var current_color = Color(0,0,0)

class Tile:
	var type = -1
	var x = -1
	var y = -1

var size_x = 0
var size_y = 0

func coord_to_index(x, y):
	return (x*size_x)+y

func _init(_x, _y, _editor):
	size_x = _x
	size_y = _y
	editor = _editor
	print("Create new Map of ", size_x, "X", size_y, " tiles")
	
	for y in range(size_y):
		for x in range(size_x):
			#print("-> Generation Progress : ", (y*size_x)+x, "/", size_x * size_y) #, " -- ", 100/(size_x * size_y)*(x*y), "%")
			var tile = Tile.new()
			tile.x = x
			tile.y = y
			tiles.append(tile)
	print("Generated !")
	
	node2d = Node2D.new()
	node2d.set_scale(Vector2(zoom,zoom))
	add_child(node2d)
	node2d.connect("draw", self, "draw_map")
	editor.control.zoom_slider.set_val(zoom)
	
	tiles[0].type = 1
	tiles[1].type = 0
	tiles[1500].type = 1
	tiles[684].type = 0
	tiles[351].type = 0
	tiles[2505].type = 0
	tiles[1648].type = 0
	
	set_process_input(true)

func _input(event):
	var pos = node2d.get_global_pos()
	var size = node2d.get_scale()
	var rect = Rect2(pos.x, pos.y, size.x * size_x, size.y * size_y)
	is_inside = rect.has_point(event.pos)
	print(is_inside)
	
	var pos_mouse_in_node = Vector2(event.pos.x - pos.x, event.pos.y - pos.y)
	
	if(is_inside):
		current_tile = Vector2(floor(pos_mouse_in_node.x / size.x), floor(pos_mouse_in_node.y / size.y))
		draw_tile(current_tile.x, current_tile.y, Color(255,255,0))
	else:
		current_tile = Vector2(-1,-1)
	print("-> current_tile : ", current_tile)

func draw_map():
	if(need_regeneration):
		print("REGENERATION !")
		for tile in tiles:
			if(tile.type == -1):
				node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(1,1,1))
			if(tile.type == 0):
				node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(0,1,0))
			if(tile.type == 1):
				node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(0,0,0))
		need_regeneration = false
	if(need_update):
		print("UPDATE !")
		node2d.draw_rect(Rect2(current_tile.x,current_tile.y,1,1), current_color)
		need_update = false

func draw_tile(x, y, color):
	need_update = true
	current_color = color
	

func change_zoom(_zoom):
	zoom = _zoom
	node2d.set_scale(Vector2(zoom,zoom))