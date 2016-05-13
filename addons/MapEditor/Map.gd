
tool
extends Control

var editor = null

var tiles = []
var zoom = 10
var node2d = null

var tile

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
			print("-> Generation Progress : ", (y*size_x)+x, "/", size_x * size_y) #, " -- ", 100/(size_x * size_y)*(x*y), "%")
			var tile = Tile.new()
			tile.x = x
			tile.y = y
			tiles.append(tile)
	print("Generated !")
	
	node2d = Node2D.new()
	node2d.set_scale(Vector2(zoom,zoom))
	add_child(node2d)
	set_process(true)
	node2d.connect("draw", self, "draw_map")
	
	editor.control.zoom_slider.set_val(zoom)
	
	#tiles[0].type = 1
	#tiles[1].type = 0
	#tiles[1500].type = 1
	#tiles[684].type = 0
	#tiles[351].type = 0
	#tiles[2505].type = 0
	#tiles[1648].type = 0

func draw_map():
	for tile in tiles:
		if(tile.type == -1):
			node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(1,1,1))
		if(tile.type == 0):
			node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(0,1,0))
		if(tile.type == 1):
			node2d.draw_rect(Rect2(tile.x,tile.y,1,1), Color(0,0,0))

func change_zoom(_zoom):
	zoom = _zoom
	node2d.set_scale(Vector2(zoom,zoom))
	