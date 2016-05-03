
extends Node

onready var game = get_node("/root/Game")

export var name = "default" setget set_name,get_name
export var money = 0 setget set_money,get_money
export var expense = 0 setget set_expense,get_expense
export var heal_patients = 0.0 setget set_heal_patients,get_heal_patients
export var total_patients = 0.0 setget set_total_patients,get_total_patients
export var heal_patients_percent = 0.0 setget ,get_heal_patients_percent
export var reputation = 0 setget set_reputation,get_reputation
export var hospital_value = 0 setget set_hospital_value,get_hospital_value

var stats = {}

signal reputation_change(reputation)

func _ready():
	game.connect("end_month", self, "_on_end_month")

func set_name(new_name):
	name = name

func get_name():
	return name

func set_money(val):
	money = val

func get_money():
	return money

func reset():
	stats.clear()


func increase_money(val):
	money += val

func decrease_money(val):
	money -= val

func set_expense(val):
	expense = val

func get_expense():
	return expense

func increase_expense(val):
	expense += val

func decrease_expense(val):
	expense -= val

func set_heal_patients(val):
	heal_patients = val

func get_heal_patients():
	return heal_patients

func increase_heal_patients(val):
	heal_patients += val

func decrease_heal_patients(val):
	heal_patients -= val

func set_total_patients(val):
	total_patients = val

func get_total_patients(val):
	return total_patients

func increase_total_patients(val):
	total_patients += val

func decrease_total_patients(val):
	total_patients -= val

func get_heal_patients_percent():
	return heal_patients_percent

func calculate_heal_patients_percent():
	if total_patients > 0:
		heal_patients_percent = 100 * (heal_patients/total_patients)

func set_reputation(val):
	reputation += val
	emit_signal("reputation_change", reputation)

func get_reputation():
	return reputation

func increase_reputation(val):
	reputation += val
	emit_signal("reputation_change", reputation)

func decrease_reputation(val):
	reputation -= val
	emit_signal("reputation_change", reputation)

func set_hospital_value(val):
	hospital_value = val

func get_hospital_value():
	return hospital_value

func increase_hospital_value(val):
	hospital_value += val

func decrease_hospital_value(val):
	hospital_value -= val

func _on_end_month():
	decrease_money(expense)