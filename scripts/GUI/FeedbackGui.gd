
extends Panel

onready var game = get_node("/root/Game")
onready var feed_back_label = get_node("Feedback_label")
onready var timer = get_node("Timer")

var mouse_on_it = false

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_released("left_click") && mouse_on_it == true:
		hide()
		mouse_on_it = false
		timer.stop()

func display(txt):
	if game.config.tutorial :
		feed_back_label.set_text(txt)
		show()
		timer.start()

func _on_Feedback_panel_mouse_enter():
	mouse_on_it = true

func _on_Feedback_panel_mouse_exit():
	mouse_on_it = false

func _on_Timer_timeout():
	hide()
	mouse_on_it = false
