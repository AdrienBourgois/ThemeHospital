
extends Panel

onready var money_label = get_node("Label")
onready var game = get_node("/root/Game")
onready var player = game.scene.get_node("Player")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	money_label.set_text(str(player.money) + " $")