
extends Node

onready var game = get_node("/root/Game")

var stats = {
NAME = "MAZUC",
MONEY = 0,
EXPENSE = 0,
HEAL_PATIENTS = 0.0,
TOTAL_PATIENTS = 0.0,
HEAL_PATIENTS_PERCENT = 0.0,
REPUTATION = 0,
HOSPITAL_VALUE = 0
}

signal reputation_change(reputation)

func _ready():
	game.connect("end_month", self, "_on_end_month")

func increase_money(val):
	stats.MONEY += val

func decrease_money(val):
	stats.MONEY -= val

func increase_expense(val):
	stats.EXPENSE += val

func decrease_expense(val):
	stats.EXPENSE -= val

func increase_heal_patients(val):
	stats.HEAL_PATIENTS += val

func decrease_heal_patients(val):
	stats.HEAL_PATIENTS -= val

func increase_total_patients(val):
	stats.TOTAL_PATIENTS += val

func decrease_total_patients(val):
	stats.TOTAL_PATIENTS -= val

func calculate_heal_patients_percent():
	if stats.TOTAL_PATIENTS > 0:
		stats.HEAL_PATIENTS_PERCENT = 100 * (stats.HEAL_PATIENTS/stats.TOTAL_PATIENTS)

func increase_reputation(val):
	stats.REPUTATION += val
	emit_signal("reputation_change", stats.REPUTATION)

func decrease_reputation(val):
	stats.REPUTATION -= val
	emit_signal("reputation_change", stats.REPUTATION)

func increase_hospital_value(val):
	stats.HOSPITAL_VALUE += val

func decrease_hospital_value(val):
	stats.HOSPITAL_VALUE -= val

func _on_end_month():
	decrease_money(stats.EXPENSE)