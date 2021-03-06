
extends Node

export var reputation_goal = 0 setget ,getReputationGoal
export var money_goal = 0 setget ,getMoneyGoal
export var heal_patients_percent_goal = 0 setget ,getHealPatientsPercentGoal
export var heal_patients_goal = 0 setget ,getHealPatientsGoal
export var hospital_value_goal = 0 setget ,getHospitalValueGoal

var objectives_complete = {
REPUTATION = false,
MONEY = false,
HEAL_PATIENTS_PERCENT = false,
HEAL_PATIENTS = false,
HOSPITAL_VALUE = false
}

onready var player = get_parent().get_node("Player")
var objectives_gui

func _ready():
	checkValidObjectives()
	set_process(true)

func _process(delta):
	for idx in objectives_complete:
		if objectives_complete[idx] == false:
			return
	
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://scenes/GUI/EndGameGUI.scn")

func checkValidObjectives():
	var goals = [reputation_goal, money_goal, heal_patients_percent_goal, heal_patients_goal, hospital_value_goal]
	var count = 0
	
	for idx in objectives_complete:
		if goals[count] == 0:
			objectives_complete[idx] = true
			
		count += 1

func linkToGui():
	objectives_gui = get_parent().get_node("In_game_gui/Status/Objectives")

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

func setObjectiveComplete(val, idx):
	if val >= 100:
		objectives_complete[idx] = true
	else:
		objectives_complete[idx] = false

func _on_Player_heal_patients_percent_change( patients_percent ):
		var val = objectives_gui.setHealPatientsPercents(patients_percent, heal_patients_percent_goal)
		setObjectiveComplete(val, "HEAL_PATIENTS_PERCENT")

func _on_Player_hospital_value_change( hospital_value ):
		var val = objectives_gui.setHospitalValue(hospital_value, hospital_value_goal)
		setObjectiveComplete(val, "HOSPITAL_VALUE")

func _on_Player_money_change( money ):
		var val = objectives_gui.setMoney(money, money_goal)
		setObjectiveComplete(val, "MONEY")


func _on_Player_reputation_change( reputation ):
		var val = objectives_gui.setReputation(reputation, reputation_goal)
		setObjectiveComplete(val, "REPUTATION")


func _on_Player_heal_patients_change( heal_patients ):
		var val = objectives_gui.setHealPatients(heal_patients, heal_patients_goal)
		setObjectiveComplete(val, "HEAL_PATIENTS")