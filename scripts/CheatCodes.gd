
extends Node

onready var player = get_parent().get_node("Player")

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_key_pressed(KEY_CONTROL):
		if Input.is_key_pressed(KEY_R):
			modifyReputation()
		elif Input.is_key_pressed(KEY_M):
			modifyMoney()
		elif Input.is_key_pressed(KEY_H):
			modifyHealPatients()
		elif Input.is_key_pressed(KEY_V):
			modifyHospitalValue()

func modifyReputation():
	if Input.is_key_pressed(KEY_KP_ADD):
		player.increaseReputation(100)
	elif Input.is_key_pressed(KEY_KP_SUBTRACT):
		player.decreaseReputation(100)

func modifyMoney():
	if Input.is_key_pressed(KEY_KP_ADD):
		player.increaseMoney(100)
	elif Input.is_key_pressed(KEY_KP_SUBTRACT):
		player.decreaseMoney(100)

func modifyHealPatients():
	if Input.is_key_pressed(KEY_KP_ADD):
		player.increaseHealPatients(1)
		player.increaseTotalPatients(1)
	elif Input.is_key_pressed(KEY_KP_SUBTRACT):
		player.decreaseHealPatients(1)
		player.decreaseTotalPatients(1)

func modifyHospitalValue():
	if Input.is_key_pressed(KEY_KP_ADD):
		player.increaseHospitalValue(100)
	elif Input.is_key_pressed(KEY_KP_SUBTRACT):
		player.decreaseHospitalValue(100)