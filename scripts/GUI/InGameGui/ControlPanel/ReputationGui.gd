
extends ProgressBar

onready var game = get_node("/root/Game")
onready var player = game.scene.get_node("Player")
onready var control_panel = get_parent()

func _ready():
	control_panel.initConnect(self)
	set_value(player.reputation)
	player.connect("reputation_change", self, "_on_reputation_change")
	set_tooltip("Reputation : " + str(player.reputation))

func _on_reputation_change(reputation):
	set_value(reputation)
	set_tooltip("Reputation : " + str(reputation))
