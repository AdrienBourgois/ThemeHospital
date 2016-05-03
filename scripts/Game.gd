extends Node

var first_game = true setget ,getFirstGame

onready var init_path = "res://init.cfg"
onready var file = File.new() 
onready var dir = Directory.new() 
onready var config = {}
onready var default_config = {
res_x = 1024,
res_y = 600,
fullscreen = false,
sound = false,
online_mode = false
}

var scene setget ,getScene
var feedback setget ,getFeedback

var SPEED = {
	SLOWEST = 0.25,
	SLOWER = 0.5,
	NORMAL = 1.0,
	MAX = 2.0,
	AND_THEN_SOME_MORE = 4.0}

var speed = SPEED.NORMAL setget setSpeed, getSpeed

var speed_array = [SPEED.SLOWEST, SPEED.SLOWER, SPEED.NORMAL, SPEED.MAX, SPEED.AND_THEN_SOME_MORE] setget ,getSpeedArray

signal speed_change
signal end_month
signal build_timer_timeout

func _ready():
	pass

func setSpeed(new_speed):
	speed = new_speed
	emit_signal("speed_change")

func getSpeed():
	return speed

func getScene():
	return get_node("/root/GameScene")

func getFeedback():
	return get_node("/root/GameScene/In_game_gui/Feedback_panel")

func getSpeedArray(id):
	return speed_array[id]

func getFirstGame():
	return first_game