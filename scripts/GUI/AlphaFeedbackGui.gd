
extends Panel

onready var game = get_node("/root/Game")
onready var feed_back_label = get_node("Alpha_feedback_label")
onready var plus_button = get_node("Plus")
onready var minus_button = get_node("Minus")

var mouse_on_it = false

onready var buff = [
	"TUTO_MOVE_CAM",
	"TUTO_BUILD_ROOMS",
	"TUTO_CORRIDOR_ITEMS",
	"TUTO_HIRE",
	"TUTO_INFO_BAR",
	"TUTO_TOWN_MAP",
	"TUTO_STATUS",
	"TUTO_GO",
	"TUTO_SPEED"
]

onready var count = 0


func _ready():
	changeTip(0)
	set_process_input(true)
	set_process(true)


func _process(delta):
	checkTuto()
	checkPlus()
	checkMinus()


func checkTuto():
	if game.config.tutorial :
		show()
	else:
		hide()

func checkPlus():
	if count >= buff.size() - 1:
		plus_button.set_disabled(true)
	else:
		plus_button.set_disabled(false)


func checkMinus():
	if count <= 0:
		minus_button.set_disabled(true)
	else:
		minus_button.set_disabled(false)


func changeTip(idx):
	if game.config.tutorial :
		feed_back_label.set_text(buff[idx])


func addTip(tip):
	buff.push_back(tip)


func _on_Alpha_feedback_panel_mouse_enter():
	mouse_on_it = true


func _on_Alpha_feedback_panel_mouse_exit():
	mouse_on_it = false


func _on_Plus_pressed():
	count += 1
	changeTip(count)


func _on_Minus_pressed():
	count -= 1
	changeTip(count)