
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
export var pharmacy_discover = []
export var psychatric_discover = []
export var clinics_discover = []


var stats = {}
var savename = "default"


signal reputation_change(reputation)
signal money_change(money)
signal heal_patients_change(heal_patients)
signal heal_patients_percent_change(patients_percent)
signal hospital_value_change(hospital_value)

func _ready():
	game.connect("end_month", self, "_on_end_month")

func initObjectives():
	emit_signal("money_change", money)
	emit_signal("heal_patients_change", heal_patients)
	calculateHealPatientsPercent()
	emit_signal("reputation_change", reputation)
	emit_signal("hospital_value_change", hospital_value)

func loadData():
	name = stats.NAME
	money = int(stats.MONEY)
	expense = stats.EXPENSE
	heal_patients = stats.HEAL_PATIENTS
	total_patients = stats.TOTAL_PATIENTS
	heal_patients_percent = stats.HEAL_PATIENTS_PERCENT
	reputation = stats.REPUTATION
	hospital_value = stats.HOSPITAL_VALUE
	pharmacy_discover = stats.PHARMACY_DISCOVER
	psychatric_discover = stats.PSYCHATRIC_DISCOVER
	clinics_discover = stats.CLINICS_DISCOVER
	resetStatsDict()

func createStatsDict():
	var date = str(OS.get_date().day) + '/' + str(OS.get_date().month) + '/' + str(OS.get_date().year)
	date += " - " + str(OS.get_time().hour) + ':' + str(OS.get_time().minute) + ':' + str(OS.get_time().second)
	stats = {
	NAME = game.username,
	MONEY = money,
	EXPENSE = expense,
	HEAL_PATIENTS = heal_patients,
	TOTAL_PATIENTS = total_patients,
	HEAL_PATIENTS_PERCENT = heal_patients_percent,
	REPUTATION = reputation,
	HOSPITAL_VALUE = hospital_value,
	PHARMACY_DISCOVER = pharmacy_discover,
	PSYCHATRIC_DISCOVER = psychatric_discover,
	CLINICS_DISCOVER = clinics_discover,
	SAVENAME = game.username + " -" + date
	}
	return stats

func resetStatsDict():
	stats.clear()

func setName(new_name):
	name = name

func getName():
	return name

func setMoney(val):
	money = val
	emit_signal("money_change", money)

func getMoney():
	return money

func increaseMoney(val):
	money += val
	emit_signal("money_change", money)

func decreaseMoney(val):
	money -= val
	emit_signal("money_change", money)

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
	emit_signal("heal_patients_change", heal_patients)
	calculateHealPatientsPercent()

func getHealPatients():
	return heal_patients

func increaseHealPatients(val):
	heal_patients += val
	emit_signal("heal_patients_change", heal_patients)
	calculateHealPatientsPercent()

func decreaseHealPatients(val):
	heal_patients -= val
	emit_signal("heal_patients_change", heal_patients)
	calculateHealPatientsPercent()

func setTotalPatients(val):
	total_patients = val
	calculateHealPatientsPercent()

func getTotalPatients(val):
	return total_patients

func increaseTotalPatients(val):
	total_patients += val
	calculateHealPatientsPercent()

func decreaseTotalPatients(val):
	total_patients -= val
	calculateHealPatientsPercent()

func getHealPatientsPercent():
	return heal_patients_percent

func calculateHealPatientsPercent():
	if total_patients > 0:
		heal_patients_percent = 100 * (heal_patients/total_patients)
	emit_signal("heal_patients_percent_change", heal_patients_percent)

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
	emit_signal("hospital_value_change", hospital_value)

func getHospitalValue():
	return hospital_value

func increaseHospitalValue(val):
	hospital_value += val
	emit_signal("hospital_value_change", hospital_value)

func decreaseHospitalValue(val):
	hospital_value -= val
	emit_signal("hospital_value_change", hospital_value)

func _on_end_month():
	decreaseMoney(expense)