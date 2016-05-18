
extends Panel

onready var game = get_node("/root/Game")
onready var loader = get_node("/root/Load")
onready var saver = get_node("/root/Save")

onready var global_client = get_node("/root/GlobalClient")
onready var chat_settings_button = get_node("./Chat_settings_button")
onready var chat_settings_control = chat_settings_button.get_node("Control")
onready var chat_visibility_checkbox = get_node("./Chat_settings_button/Control/Chat_settings_box/Hide_chat_checkbox")
onready var player_container = chat_settings_button.get_node("Control/Chat_settings_box/Mute_button/Player_container")
onready var options_menu_res = preload("res://scenes/GUI/OptionsMenu.scn")
var in_game_chat = null

func _ready():
	initChatSettings()
	player_container.add_child(Button.new())


func _on_Options_pressed():
	var scn = options_menu_res.instance()
	game.scene.add_child(scn)
	scn.setInGame()


func getInGameChat():
	if ( in_game_chat == null):
		in_game_chat = game.scene.get_node("in_game_chat")


func _on_Back_pressed():
	loader.gamescn = null
	saver.gamescn = null
	checkForMultiplayerGame()
	game.goToScene("res://scenes/GUI/MainMenu.scn")


func checkForMultiplayerGame():
	if (game.multiplayer):
		global_client.disconnectFromServer()


func initChatSettings():
	if ( game.getMultiplayer() ):
		getInGameChat()
		in_game_chat.initChatSettingsVariables()
	else:
		chat_settings_button.set_disabled(true)

func _on_Chat_settings_button_toggled( pressed ):
	chat_settings_control.set_hidden(!pressed)


func setChatVisibility( boolean ):
	chat_visibility_checkbox.set_pressed( boolean )


func _on_Hide_send_button_checkbox_toggled( pressed ):
	in_game_chat.toggleSendMessageButton( pressed )


func _on_Hide_chat_checkbox_toggled( pressed ):
	in_game_chat.toggleVisibility()
