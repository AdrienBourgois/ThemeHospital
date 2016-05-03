extends Node

var first_game = true setget ,get_first_game

var scene setget ,get_scene
var feedback setget ,get_feedback

var SPEED = {
	SLOWEST = 0.25,
	SLOWER = 0.5,
	NORMAL = 1.0,
	MAX = 2.0,
	AND_THEN_SOME_MORE = 4.0}

var speed = SPEED.NORMAL setget set_speed, get_speed

var speed_array = [SPEED.SLOWEST, SPEED.SLOWER, SPEED.NORMAL, SPEED.MAX, SPEED.AND_THEN_SOME_MORE] setget ,get_speed_array

signal speed_change
signal end_month
signal build_timer_timeout

func _ready():
	pass

func set_speed(new_speed):
	speed = new_speed
	emit_signal("speed_change")

func get_speed():
	return speed

func get_scene():
	return get_node("/root/GameScene")

func get_feedback():
	return get_node("/root/GameScene/In_game_gui/Feedback_panel")

func get_speed_array(id):
	return speed_array[id]

func get_first_game():
	return first_game