
extends Control

onready var game = get_node("/root/Game")
onready var hud = null
onready var heat_manager = game.scene.heat_manager
onready var increase_heat_button = get_node("./Panel/HospitalManager/IncreaseHeatButton")
onready var decrease_heat_button = get_node("./Panel/HospitalManager/DecreaseHeatButton")
onready var heat_level_progress_bar = get_node("./Panel/HospitalManager/HeatLevelProgressBar")
onready var heating_bill_label = get_node("./Panel/HospitalManager/HeatingBillLabel")

func _on_IncreaseHeatButton_pressed():
	if heat_manager.heat_ray < 10:
		heat_manager.heat_ray += 1
		heat_level_progress_bar.set_val(heat_manager.heat_ray * 10)
		heat_manager.increaseHeatCost()
		heating_bill_label.set_text(str(heat_manager.heat_cost))


func _on_DecreaseHeatButton_pressed():
	if heat_manager.heat_ray > 1:
		heat_manager.heat_ray -= 1
		heat_level_progress_bar.set_value(heat_manager.heat_ray * 10)
		heat_manager.decreaseHeatCost()
		heating_bill_label.set_text(str(heat_manager.heat_cost))


func _on_QuitButton_pressed():
	if (hud == null):
		hud = get_tree().get_current_scene().get_node("./In_game_gui/HUD")
	
	set_hidden(true)
	hud.set_hidden(false)
