
extends Panel

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var saver = get_node("/root/Save")

onready var chat_settings_button = get_node("./Chat_settings_button")
onready var chat_settings_control = chat_settings_button.get_node("Control")
onready var chat_visibility_checkbox = get_node("./Chat_settings_button/Control/Chat_settings_box/Hide_chat_checkbox")
onready var player_container = chat_settings_button.get_node("Control/Chat_settings_box/Mute_button/Player_container")
onready var mute_button = chat_settings_button.get_node("Control/Chat_settings_box/Mute_button")
onready var options_menu_res = preload("res://scenes/GUI/OptionsMenu.scn")
var in_game_chat = null

func _ready():
	initChatSettings()


func _on_Options_pressed():
	var scn = options_menu_res.instance()
	game.scene.add_child(scn)
	scn.setInGame()


func getInGameChat():
	if ( in_game_chat == null):
		in_game_chat = game.scene.get_node("in_game_chat")

func _on_Back_pressed():
	game.scene.map.path_finding.stopService()
	loader.gamescn = null
	saver.gamescn = null
	queue_free()
	game.goToScene("res://scenes/GUI/MainMenu.scn")


func initChatSettings():
	if ( game.getMultiplayer() ):
		getInGameChat()
		in_game_chat.initChatSettingsVariables()
	else:
		chat_settings_button.set_disabled(true)

func _on_Chat_settings_button_toggled( pressed ):
	chat_settings_control.set_hidden(!pressed)
	
	if ( !pressed ):
		mute_button.set_pressed(false)
		_on_Mute_button_toggled(false)


func setChatVisibility( boolean ):
	chat_visibility_checkbox.set_pressed( boolean )


func _on_Hide_send_button_checkbox_toggled( pressed ):
	in_game_chat.toggleSendMessageButton( pressed )


func _on_Hide_chat_checkbox_toggled( pressed ):
	in_game_chat.toggleVisibility()


func clearPlayerContainer():
	for player in range ( player_container.get_child_count() ):
		var node = player_container.get_child(0)
		node.queue_free()


func addPlayerInPlayerContainer(player_name, player_id):
	var button = Button.new()
	button.set_text(player_name)
	button.set_toggle_mode(true)
	button.connect("toggled", self, "mutePlayer", [player_id])
	
	player_container.add_child(button)