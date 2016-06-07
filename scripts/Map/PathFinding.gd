
extends Node

var map = null
var from = null
var to = null
var current = null
var total_time = OS.get_ticks_msec()

var came_from = {}
var closed_list = []
var open_list = []

var found = false
var path_nodes = []

var curve = Curve3D
var current_point = Vector3()
var next_point = Vector3()
var next_point_number = 0

var node = null

var speed = 1
var delta_sum = 0
var animation_completed = false

func _init(_from, _to, _node, _speed, _map):
	if (_from != _to):
		map = _map
		from = map.columns[_from.x][_from.y]
		to = map.columns[_to.x][_to.y]
		node = _node
		speed = _speed
		path_finding()

func path_finding():
	open_list.append(from)
	
	while(open_list.size() && !found):
		current = open_list[0]
		open_list.pop_front()
		if (closed_list.find(current) == -1):
			if (current == to):
				found = true
				reconstruct()
				continue
			else:
				for neighbour in current.neighbours:
					if (can_go(current, neighbour)):
						if(open_list.find(current.neighbours[neighbour]) == -1 and closed_list.find(current.neighbours[neighbour]) == -1):
							open_list.append(current.neighbours[neighbour])
							came_from[current.neighbours[neighbour]] = current
				closed_list.append(current)
	
	animate()

func reconstruct():
	path_nodes.append(current)
	var previous = current
	
	while(previous != from):
		previous = came_from[previous]
		path_nodes.push_front(previous)

func create_curve():
	curve = Curve3D.new()
	
	for node in path_nodes:
		curve.add_point(node.get_translation())

func animate():
	create_curve()
	
	var size_node = node.get_scale()
	
	next_point_number = 1
	current_point = curve.get_point_pos(0)
	current_point.y = 0.5
	next_point = curve.get_point_pos(1)
	next_point.y = 0.5
	node.set_translation(current_point)
	set_fixed_process(true)

func _fixed_process(delta):
	delta_sum += delta
	node.set_translation(current_point + ((next_point - current_point) * (delta_sum / speed)))
	
	if (delta_sum >= speed):
		delta_sum = 0
		next_point_number += 1
		if(next_point_number < curve.get_point_count()):
			current_point = curve.get_point_pos(next_point_number - 1)
			next_point = curve.get_point_pos(next_point_number)
			current_point.y = 0.5
			next_point.y = 0.5
			node.set_translation(current_point)
		else:
			node.set_translation(next_point)
			set_fixed_process(false)
			animation_completed = true

func can_go(from, direction):
	var tile_from = map.columns[from.x][from.y]
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