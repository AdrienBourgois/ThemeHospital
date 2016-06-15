
extends Control


onready var game = get_node("/root/Game")
onready var control_panel = game.scene.get_node("./In_game_gui/HUD/Control_panel/Build_hire_controls")
onready var rooms_container = get_node("./BuildRoom/AvailableRooms/RoomsContainer")
onready var cost_label = get_node("./BuildRoom/AvailableRooms/CostLabel")
onready var rooms_types_container = get_node("./BuildRoom/RoomsTypesContainer")
onready var player = game.scene.player
onready var map = game.scene.map
onready var rooms_ressources = map.ressources
onready var rooms_type_dictionary = rooms_ressources.type_rooms
onready var pick_room_type_label = get_node("./BuildRoom/AvailableRooms/PickRoomTypeLabel")
onready var room_picture = get_node("./BuildRoom/RoomPicture")
onready var confirmation_build = get_node("./ConfirmationRoom")
onready var build_room = get_node("./BuildRoom")

export var max_rooms_container = 0
export var max_rooms_type_container = 0


var is_type_selected = false
var price = 0


func _ready():
	createButtonsForRoomsContainer()
	createButtonsForRoomsTypesContainer()
	connectRoomsTypeButtons()


func createButtonsForRoomsTypesContainer():
	for index in range ( max_rooms_type_container ):
		var button = Button.new()
		button.set_h_size_flags(SIZE_EXPAND_FILL)
		button.set_v_size_flags(SIZE_EXPAND_FILL)
		rooms_types_container.add_child(button)


func createButtonsForRoomsContainer():
	for index in range ( max_rooms_container ):
		var button = Button.new()
		button.set_h_size_flags(SIZE_EXPAND_FILL)
		button.set_v_size_flags(SIZE_EXPAND_FILL)
		rooms_container.add_child(button)


func connectRoomsTypeButtons():
	var button_number = 0
	var button = null
	
	for type in rooms_type_dictionary:
		button = rooms_types_container.get_child(button_number)
		button.set_text(type)
		button.connect("pressed", self, "typeRoomsPressed", [rooms_type_dictionary[type]])
		
		button_number += 1


func typeRoomsPressed(type):
	pick_room_type_label.set_text("PICK_ROOM")
	cleanButtons()
	
	var button_number = 0
	var button
	
	for rooms in type:
		button = rooms_container.get_child(button_number)
		button.set_text(type[rooms].NAME)
		button.set_tooltip(type[rooms].TOOLTIP)
		
		mouseEnterOnRoom(type, rooms, button_number)
		button.connect("pressed", self, "roomsPressed",[type[rooms]])
		button_number += 1
	
	is_type_selected = true


func cleanButtons():
	var button = null
	
	for button_number in range( max_rooms_container ):
		button = rooms_container.get_child(button_number)
		
		button.set_text("")
		button.set_tooltip("")
		
		disconnectButton(button)
	
	cost_label.set_text("")

func disconnectButton(button):
	disconnectFunc(button, "mouse_enter", "enterRooms")
	disconnectFunc(button, "mouse_exit", "exitRooms")
	disconnectFunc(button, "pressed", "roomsPressed")
	disconnectFunc(button, "pressed", "typeRoomsPressed")


func disconnectFunc(button, type, method):
	if button.is_connected(type, self, method):
		button.disconnect(type, self, method)


func mouseEnterOnRoom(type, rooms, button_number):
	var button = rooms_container.get_child(button_number)
	
	button.connect("mouse_enter", self, "enterRooms", [type[rooms]])
	button.connect("mouse_exit", self, "exitRooms")


func enterRooms(type):
	cost_label.set_text(tr("COST") + str(type.COST) + "$")
	updateTexture(type.RESSOURCES)

func updateTexture(texture_path):
	var texture = ImageTexture.new()
	texture = load(texture_path)
	room_picture.set_texture(texture)

func exitRooms():
	cost_label.set_text("")
	room_picture.set_texture(null)


func roomsPressed(room):
	if player.money >= room.COST:
		cleanButtons()
		price = room.COST
	
	if (is_type_selected == true):
		confirmation_build.show()
		confirmation_build.get_node("Panel/RoomNameLabel").set_text(room.NAME)
		build_room.hide()
		map.new_room("new", room)
	else:
		game.feedback.display("FEEDBACK_ENOUGH_MONEY")


func _on_CancelButton_pressed():
	control_panel.hideCurrentWindow()


func freeScene():
	queue_free()