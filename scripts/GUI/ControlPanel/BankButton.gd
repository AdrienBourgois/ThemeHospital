
extends Button

onready var control_panel = get_parent()

func _ready():
	control_panel.init_connect(self)