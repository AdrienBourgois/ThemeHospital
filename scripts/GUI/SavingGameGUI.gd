
extends Control

onready var saving_game = get_node("Panel/SavingGame")
onready var save_complete = get_node("Panel/SaveComplete")
onready var timer = get_node("Panel/Timer")

func _ready():
	timer.set_wait_time(2)
	timer.connect("timeout", self, "timerOut")

func showSaving():
	saving_game.show()
	save_complete.hide()

func showComplete():
	saving_game.hide()
	save_complete.show()
	timer.start()

func timerOut():
	self.hide()