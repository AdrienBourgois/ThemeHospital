
extends Node

var map = null
var from = null
var to = null
var current = null
var time = OS.get_ticks_msec()
var total_time = OS.get_ticks_msec()

var came_from = {}

var closed_list = []
var open_list = []

var path = []

func _init(_from, _to, _map):
	map = _map
	from = map.columns[_from.x][_from.y]
	to = map.columns[_to.x][_to.y]
	
	open_list.append(from)
	
	var found = false
	
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
					if (map.can_go(current, neighbour)):
						if(open_list.find(current.neighbours[neighbour]) == -1 and closed_list.find(current.neighbours[neighbour]) == -1):
							open_list.append(current.neighbours[neighbour])
							came_from[current.neighbours[neighbour]] = current
				closed_list.append(current)

func reconstruct():
	path.append(current)
	var previous = current
	
	while(previous != from):
		previous = came_from[previous]
		path.push_front(previous)
	
	for node in open_list:
		node.room_material.set_parameter(0, colors.black)
	
	for node in closed_list:
		node.room_material.set_parameter(0, colors.orange)
	
	for node in path:
		node.room_material.set_parameter(0, colors.red)
	
	print("--> Total Time : ", OS.get_ticks_msec() - total_time)
