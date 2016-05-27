
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

var current_point = null
var current_point_number = 0
var speed = 1
var curve = null
var node = null
var delta_sum = 0

func _init(_from, _to, _map):
	map = _map
	from = map.columns[_from.x][_from.y]
	to = map.columns[_to.x][_to.y]
	
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
	
	print("--> Total Time : ", OS.get_ticks_msec() - total_time)

func reconstruct():
	print(current)
	path_nodes.append(current)
	var previous = current
	
	while(previous != from):
		previous = came_from[previous]
		path_nodes.push_front(previous)
	
#	for node in open_list:
#		node.room_material.set_parameter(0, colors.black)
#	
#	for node in closed_list:
#		node.room_material.set_parameter(0, colors.orange)
	
	for node in path_nodes:
		node.room_material.set_parameter(0, colors.red)

func create_curve():
	curve = Curve3D.new()
	
	for node in path_nodes:
		curve.add_point(node.get_translation() + Vector3(0.5,0.5,0.5))

func animate(_node, _speed):
	node = _node
	speed = _speed
	create_curve()
	set_fixed_process(true)
	current_point_number = 0
	current_point = curve.get_point_pos(current_point_number)
	node.set_translation(current_point)

func _fixed_process(delta):
	#node.set_translation(current_point)
	
	delta_sum += delta
	
	if (delta_sum >= 1):
		delta_sum = 0
		current_point_number += 1
		if(current_point_number < curve.get_point_count()):
			current_point = curve.get_point_pos(current_point_number)
			node.set_translation(current_point)
			print("Next point")
		else:
			set_fixed_process(false)
			print("Finish")
			queue_free()

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
