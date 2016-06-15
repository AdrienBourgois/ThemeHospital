extends Button

onready var game = get_node("/root/Game")
onready var control_panel = game.scene.get_node("./In_game_gui/HUD/Control_panel/Build_hire_controls")

func _on_ExitHire_pressed():
	control_panel.hideCurrentWindow()
#	get_parent().get_parent().hide()
