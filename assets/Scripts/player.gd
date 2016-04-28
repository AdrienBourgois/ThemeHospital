
extends Node

onready var game = get_node("/root/Game")

export var money = 0 setget set_money,get_money
export var expense = 0 setget set_expense,get_expense

func _ready():
	game.connect("end_month", self, "_on_end_month")

func set_money(new_money):
	money = new_money

func get_money():
	return money

func set_expense(new_expense):
	expense = new_expense

func get_expense():
	return expense

func _on_end_month():
	money -= expense