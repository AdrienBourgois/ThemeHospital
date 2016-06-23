
extends ConfirmationDialog

onready var hire_manager = get_node("/root/Game").scene.hire_manager
onready var player = get_node("/root/Game").scene.player
onready var root = get_tree().get_current_scene().get_node("./Control")
onready var info_bar = get_node("/root/Game").scene.in_game_gui.control_panel.dynamic_info_bar_label

func _ready():
	get_cancel().connect("pressed", self, "_on_CancelButton_pressed")

func _on_ConfirmationDialog_confirmed():
	player.decreaseMoney(hire_manager.staff_selected.salary)
	player.decreaseExpense(hire_manager.staff_selected.salary)
	hire_manager.sackStaff()
	info_bar.set_text("")
	root.queue_free()
	

func _on_CancelButton_pressed():
	get_parent().get_parent().get_parent().queue_free()