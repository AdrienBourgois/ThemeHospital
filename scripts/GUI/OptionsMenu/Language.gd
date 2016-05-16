
extends MenuButton

onready var game = get_node("/root/Game")
onready var language_button = get_node("./LanguageOptionButton")
onready var options_menu = get_node("../..")

var language = ["fr", "en"]

func _ready():
	set_selected()

func set_selected():
	var count = 0
	for idx in language:
		if idx == game.config.langage:
			language_button.select(count)
		count += 1

func _on_LanguageOptionButton_item_selected( ID ):
	game.config.langage = language[ID]
	options_menu.apply_button.set_disabled(false)
