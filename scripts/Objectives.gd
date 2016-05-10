
extends Node

export var reputation_goal = 0 setget ,getReputationGoal
export var money_goal = 0 setget ,getMoneyGoal
export var heal_patients_percent_goal = 0 setget ,getHealPatientsPercentGoal
export var heal_patients_goal = 0 setget ,getHealPatientsGoal
export var hospital_value_goal = 0 setget ,getHospitalValueGoal

onready var player = get_parent().get_node("Player")
onready var objectives_gui = get_parent().get_node("In_game_gui/Charts/Objectives")

func _ready():
	pass

func calculatePercent(numerator, denominator):
	return 100 * (float(numerator)/float(denominator))

func getHealPatientsGoal():
	return heal_patients_goal

func getHealPatientsPercentGoal():
	return heal_patients_percent_goal

func getMoneyGoal():
	return money_goal

func getReputationGoal():
	return reputation_goal

func getHospitalValueGoal():
	return hospital_value_goal

func _on_Player_heal_patients_change():
	pass
