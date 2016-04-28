extends Node

var speed = 1 setget set_speed, get_speed
var scene setget ,get_scene

var SPEED = {
	SLOWEST = 0.25,
	SLOWER = 0.5,
	NORMAL = 1.0,
	MAX = 2.0,
	AND_THEN_SOME_MORE = 4.0 }

var speed_array = [SPEED.SLOWEST, SPEED.SLOWER, SPEED.NORMAL, SPEED.MAX, SPEED.AND_THEN_SOME_MORE] setget ,get_speed_array

signal speed_change
signal end_month

func _ready():
	for idx in speed_array:
		print(idx)
	pass

func set_speed(new_speed):
	speed = new_speed
	emit_signal("speed_change")

func get_speed():
	return speed

func get_scene():
	return get_node("/root/GameScene")

func get_speed_array(id):
	print(id)
	return speed_array[id]