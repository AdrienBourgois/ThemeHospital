
extends Control

onready var game = get_node("/root/Game")
onready var camera = game.scene.camera
var player
var objectives
onready var reputation_bar = get_node("ReputationBar")
onready var money_bar = get_node("MoneyBar")
onready var heal_patients_percent_bar = get_node("HealPatientsPercentBar")
onready var heal_patients_bar = get_node("HealPatientsBar")
onready var hospital_value_bar = get_node("HospitalValueBar")


func calculatePercent(numerator, denominator):
	if denominator > 0 :
		return 100 * (float(numerator)/float(denominator))
	else:
		return 100

func setReputation(reputation_player, reputation_goal):
	var val = calculatePercent(reputation_player, reputation_goal)
	reputation_bar.set_value(val)
	reputation_bar.set_tooltip(str(reputation_player) + "/" + str(reputation_goal))
	return val

func setMoney(money_player, money_goal):
	var val = calculatePercent(money_player, money_goal)
	money_bar.set_value(val)
	money_bar.set_tooltip(str(money_player) + "/" + str(money_goal))
	return val

func setHealPatientsPercents(heal_patients_percent_player, heal_patients_percent_goal):
	var val = calculatePercent(heal_patients_percent_player, heal_patients_percent_goal)
	heal_patients_percent_bar.set_value(val)
	heal_patients_percent_bar.set_tooltip(str(heal_patients_percent_player) + "%/" + str(heal_patients_percent_goal) + "%")
	return val

func setHealPatients(heal_patients_player, heal_patients_goal):
	var val = calculatePercent(heal_patients_player, heal_patients_goal)
	heal_patients_bar.set_value(val)
	heal_patients_bar.set_tooltip(str(heal_patients_player) + "/" + str(heal_patients_goal))
	return val

func setHospitalValue(hospital_value_player, hospital_value_goal):
	var val = calculatePercent(hospital_value_player, hospital_value_goal)
	hospital_value_bar.set_value(val)
	hospital_value_bar.set_tooltip(str(hospital_value_player) + "/" + str(hospital_value_goal))
	return val