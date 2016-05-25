
extends Node

onready var root = get_tree().get_root()

var screenshot
var path
onready var game = get_node("/root/Game")

onready var save_path = "res://saves/"
onready var username_path = save_path + game.username
onready var directory_path = username_path + "/screens/"
onready var popup = get_node("ConfirmationDialog")
onready var line_edit= get_node("ConfirmationDialog/LineEdit")

func _ready():
	print(save_path)
	print(username_path)
	print(directory_path)
	pass


func screen():
	root.queue_screen_capture()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	screenshot = root.get_screen_capture()
	setScreenshotPath()
	popup.show()
	line_edit.set_text(path)


func setScreenshotPath():
	path = "screen_" + str(getScreenShotNumber(path)) + ".png"


func getScreenShotNumber(path):
	var dir = Directory.new()
	checkDirectories(dir)
	dir.open(directory_path)
	dir.list_dir_begin()
	var count = -1
	var file = " "
	while(file != ""):
		file = dir.get_next()
		if file != "." && file != "..":
			count += 1
	return count


func checkDirectories(dir):
	if !dir.dir_exists(save_path):
		dir.make_dir(save_path)
	if !dir.dir_exists(username_path):
		dir.make_dir(username_path)
	if !dir.dir_exists(directory_path):
		dir.make_dir(directory_path)

func _on_ConfirmationDialog_confirmed():
	path = line_edit.get_text()
	screenshot.save_png(directory_path + path)
	get_parent().remove_child(self)