
extends Node

var map = null
var from = null
var to = null
var current = null
var time = OS.get_ticks_msec()
var total_time = OS.get_ticks_msec()
#var path = Path.new()

var came_from = {}

var closed_list = []
var open_list = []

func print_time(arg):
	print("--> Time [", arg, "] : ", OS.get_ticks_msec() - time)
	print("--> Total Time : ", OS.get_ticks_msec() - total_time)
	time = OS.get_ticks_msec()

func _init(_from, _to, _map):
	print_time("Start")
	map = _map
	from = map.get_tile(_from)
	#print(from)
	#print(_from)
	to = map.get_tile(_to)
	
	open_list.append(from)
	
	var found = false
	
	print_time("Begin loop")
	
	while(open_list.size() && !found):
		#print("Size : ", open_list.size())
		current = open_list[0]
		#print("Current : ", current)
		#print("To : ", to)
		open_list.pop_front()
		#print("Current : ", current.x, " - ", current.y)
		if (closed_list.find(current) == -1):
			if (current == to):
				found = true
				#print("Path Found !")
				reconstruct()
				continue
			else:
				for neighbour in current.neighbours:
					if (map.can_go(current, neighbour)):
						if(open_list.find(current.neighbours[neighbour]) == -1 and closed_list.find(current.neighbours[neighbour]) == -1):
							open_list.append(current.neighbours[neighbour])
							came_from[current.neighbours[neighbour]] = current
							#print("Add neighbour : ", current.neighbours[neighbour].x, " - ", current.neighbours[neighbour].y)
				closed_list.append(current)
		print_time("Tile")
	print("Tiles tested : ", closed_list.size())
	#print("Any Path !")

func reconstruct():
	print("Reconstruct()")
	var path = []
	path.append(current)
	var previous = current
	
	while(previous != from):
		#print(previous, " : ", previous.x, " - ", previous.y)
		previous = came_from[previous]
		path.push_front(previous)
	
	for node in open_list:
		node.room_material.set_parameter(0, colors.black)
	
	for node in closed_list:
		node.room_material.set_parameter(0, colors.orange)
	
	for node in path:
		#print(node.x, " - ", node.y)
		node.room_material.set_parameter(0, colors.red)

	print_time("Finish")
