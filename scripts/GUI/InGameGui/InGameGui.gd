
extends Control

onready var control_panel = get_node("HUD/Control_panel")
onready var objectives = get_node("Status/Objectives")
onready var label_3d = preload("res://scenes/GUI/3DLabel.scn")
onready var build_timer = get_node("HUD/Build_timer_panel") setget, getBuildTimer

func getBuildTimer():
	return build_timer