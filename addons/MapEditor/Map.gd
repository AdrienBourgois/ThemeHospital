
tool
extends Control

var tiles = []
var zoom = 20

class Tile:
	var panel = null
	var type = -1
	var x = -1
	var y = -1

var size_x = 0
var size_y = 0

func _init(_x, _y):
	size_x = _x
	size_y = _y
	print("Create new Map of ", size_x, "X", size_y)
	
	for x in range(size_x):
		for y in range(size_y):
			var tile = Tile.new()
			tile.x = x
			tile.y = y
			tile.panel = Panel.new()
			add_child(tile.panel)
			tiles.append(tile)
			print("Progress : ", (x*size_x)+y, "/", size_x * size_y, " -- ", 100/(size_x * size_y)*(x*y), "%")
	
	display_map()

func display_map():
	for tile in tiles:
		tile.panel.set_size(Vector2(zoom,zoom))
		tile.panel.set_pos(Vector2(tile.x * (zoom + 5), tile.y * (zoom + 5)))

