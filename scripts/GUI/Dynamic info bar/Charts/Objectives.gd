
extends Control

onready var game = get_node("/root/Game")
var player
var objectives
onready var reputation_bar = get_node("ReputationBar")
onready var money_bar = get_node("MoneyBar")
onready var heal_patients_percent_bar = get_node("HealPatientsPercentBar")
onready var heal_patients_bar = get_node("HealPatientsBar")
onready var hospital_value_bar = get_node("HospitalValueBar")

func _ready():
	pass

func init():
	var gamescn = game.scene
	player = gamescn.player
	objectives = gamescn.objectives
	calculateReputation()
	calculateMoney()
	calculateHealPatientsPercents()
	calculateHealPatients()
	calculateHospitalValue()
	set_process(true)

func _process(delta):
	calculateReputation()
	calculateMoney()
	calculateHealPatientsPercents()
	calculateHealPatients()
	calculateHospitalValue()

func calculatePercent(numerator, denominator):
	return 100 * (float(numerator)/float(denominator))

func calculateReputation():
	if objectives.reputation_goal > 0:
		reputation_bar.set_value(calculatePercent(player.reputation, objectives.reputation_goal))

func calculateMoney():
	if objectives.money_goal > 0:
		money_bar.set_value(calculatePercent(player.money, objectives.money_goal))

func calculateHealPatientsPercents():
	if objectives.heal_patients_percent_goal > 0:
		heal_patients_percent_bar.set_value(calculatePercent(player.heal_patients_percent, objectives.heal_patients_percent_goal))

func calculateHealPatients():
	if objectives.heal_patients_goal > 0:
		heal_patients_bar.set_value(calculatePercent(player.heal_patients, objectives.heal_patients_goal))

func calculateHospitalValue():
	if objectives.hospital_value_goal > 0:
		hospital_value_bar.set_value(calculatePercent(player.hospital_value, objectives.hospital_value_goal))