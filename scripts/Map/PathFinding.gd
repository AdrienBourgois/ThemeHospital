
extends Node

var path_finding = preload("Path.gd")

var map = null
var speed = 0.2

var thread = null
var thread_used = null

var to_resolve = []
var to_animate = []
var to_free = []

func _init(_map):
	map = _map
	thread = Thread.new()

func getPath(_from, _to, _node):
	var path = path_finding.new(_from, _to, _node, speed, map, self)
	set_fixed_process(true)
	
	add_child(path)
	to_resolve.append(path)
	
	return path

func askToAnimate(path):
	to_animate.append(path)

func _fixed_process(delta):
	var stop = true
	
	if(to_resolve.size()):
		stop = false
		if (!thread.is_active()):
			var path = to_resolve[0]
			to_resolve.pop_front()
			thread.start(path, "pathFinding")
	
	if(to_animate.size()):
		stop = false
		for path in to_animate:
			path.animate()
			to_animate.clear()
	
	if(to_free.size()):
		stop = false
		for path in to_free:
			if(path.ready_to_free):
				remove_child(path)
				#path.queue_free()
				#to_free.erase(path)

func deletePath(path):
	to_free.append(path)