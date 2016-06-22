extends Node

onready var root = get_tree().get_root()

onready var init_path = "res://init.cfg"
onready var file = File.new() 
onready var dir = Directory.new() 
onready var config = {}
onready var preloader = preload("res://scenes/LoadingScreen.scn")
onready var screenshot_preloader = preload("res://scenes/ScreenshotManager.scn")
var screenshot_manager
var loader
var ready = false setget getReady, setReady

onready var default_config = {
username = "Default",
res_x = 1024,
res_y = 600,
fullscreen = false,
sound = false,
online_mode = false,
langage = "fr",
tutorial = true,
move_cam_with_mouse = true
}

var username = "" setget setUsername,getUsername
var new_game = true setget setNewGame,getNewGame
var save_to_load setget setSaveToLoad,getSaveToLoad
var multiplayer setget setMultiplayer,getMultiplayer

var scene setget ,getScene
var feedback setget ,getFeedback
var infobar setget ,getInfobar

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

var action_list = []


func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("screenshot"):
		screenshot_manager = screenshot_preloader.instance()
		root.add_child(screenshot_manager)
		screenshot_manager.makeScreenshot()
	if event.is_action_pressed("fullscreen"):
		if config.fullscreen:
			config.fullscreen = false
		else:
			config.fullscreen = true
		OS.set_window_fullscreen(config.fullscreen)

func setSpeed(new_speed):
	speed = new_speed
	emit_signal("speed_change")

func getSpeed():
	return speed

func getScene():
	return get_node("/root/GameScene")

func getFeedback():
	return get_node("/root/GameScene/In_game_gui/HUD/Feedback_panel")

func getInfobar():
	return get_node("/root/GameScene/In_game_gui/Control_panel/Dynamic_info_bar")

func getSpeedArray(id):
	return speed_array[id]

func setUsername(name):
	username = name

func getUsername():
	return username

func setSaveToLoad(val):
	save_to_load = val

func getSaveToLoad():
	return save_to_load

func setNewGame(state):
	new_game = state

func getNewGame():
	return new_game

func setMultiplayer(state):
	multiplayer = state

func getMultiplayer():
	return multiplayer

func getReady():
	return ready

func setReady(boolean):
	ready = boolean

func goToScene(scene):
	loader = preloader.instance()
	var current_scene = root.get_child(root.get_child_count() - 1)
	loader.setCurrentScene(current_scene)
	root.add_child(loader)
	loader.goToScene(scene)