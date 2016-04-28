
extends Panel

onready var day_label = get_node("Day")
onready var month_label = get_node("Month")
onready var year_label = get_node("Year")
onready var game = get_node("/root/Game")
onready var calendar = game.scene.get_node("Calendar")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	day_label.set_text(str(calendar.day))
	month_label.set_text(calendar.month)
	year_label.set_text(str(calendar.year))