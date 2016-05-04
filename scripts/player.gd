
extends Node

onready var game = get_node("/root/Game")

export var name = "default" setget setName,getName
export var money = 0 setget setMoney,getMoney
export var expense = 0 setget setExpense,getExpense
export var heal_patients = 0.0 setget setHealPatients,getHealPatients
export var total_patients = 0.0 setget setTotalPatients,getTotalPatients
export var heal_patients_percent = 0.0 setget ,getHealPatientsPercent
export var reputation = 0 setget setReputation,getReputation
export var hospital_value = 0 setget setHospitalValue,getHospitalValue

var stats = {}


signal reputation_change(reputation)

func _ready():
	game.connect("end_month", self, "_on_end_month")

func loadData():
	name = stats.NAME
	money = stats.MONEY
	expense = stats.EXPENSE
	heal_patients = stats.HEAL_PATIENTS
	total_patients = stats.TOTAL_PATIENTS
	heal_patients_percent = stats.HEAL_PATIENTS_PERCENT
	reputation = stats.REPUTATION
	hospital_value = stats.HOSPITAL_VALUE
	resetStatsDict()

func createStatsDict():
	stats = {
	NAME = name,
	MONEY = money,
	EXPENSE = expense,
	HEAL_PATIENTS = heal_patients,
	TOTAL_PATIENTS = total_patients,
	HEAL_PATIENTS_PERCENT = heal_patients_percent,
	REPUTATION = reputation,
	HOSPITAL_VALUE = hospital_value
	}

func resetStatsDict():
	stats.clear()

func setName(new_name):
	name = name

func getName():
	return name

func setMoney(val):
	money = val

func getMoney():
	return money

func increaseMoney(val):
	money += val

func decreaseMoney(val):
	money -= val

func setExpense(val):
	expense = val

func getExpense():
	return expense

func increaseExpense(val):
	expense += val

func decreaseExpense(val):
	expense -= val

func setHealPatients(val):
	heal_patients = val

func getHealPatients():
	return heal_patients

func increaseHealPatients(val):
	heal_patients += val

func decreaseHealPatients(val):
	heal_patients -= val

func setTotalPatients(val):
	total_patients = val

func getTotalPatients(val):
	return total_patients

func increaseTotalPatients(val):
	total_patients += val

func decreaseTotalPatients(val):
	total_patients -= val

func getHealPatientsPercent():
	return heal_patients_percent

func calculateHealPatientsPercent():
	if total_patients > 0:
		heal_patients_percent = 100 * (heal_patients/total_patients)

func setReputation(val):
	reputation += val
	emit_signal("reputation_change", reputation)

func getReputation():
	return reputation

func increaseReputation(val):
	reputation += val
	emit_signal("reputation_change", reputation)

func decreaseReputation(val):
	reputation -= val
	emit_signal("reputation_change", reputation)

func setHospitalValue(val):
	hospital_value = val

func getHospitalValue():
	return hospital_value

func increaseHospitalValue(val):
	hospital_value += val

func decreaseHospitalValue(val):
	hospital_value -= val

func _on_end_month():
	decrease_money(expense)