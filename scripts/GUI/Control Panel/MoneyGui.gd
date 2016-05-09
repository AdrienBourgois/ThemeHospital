
extends Control

onready var money_label = get_node("Label")
onready var game = get_node("/root/Game")
var player

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if player:
		money_label.set_text(str(player.money) + " $")

func init():
	player = game.scene.get_node("Player")