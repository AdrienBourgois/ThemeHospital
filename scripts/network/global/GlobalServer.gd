
extends Node

var socket = null setget ,getSocket
var player_data = Array()
var packet_list = Array() setget addPacket
var current_available_id = 0
onready var global_client = get_node("/root/GlobalClient")
onready var packet_interpreter = get_node("/root/PacketInterpreter")

var server_states = {
	server_connected = false,
	looking_for_players = false,
	game_started = false
}

func _ready():
	set_process(true)

func _process(delta):
	if (server_states.server_connected):
		checkForDisconnection()
		checkForIncomingConnection()
		checkForMessage()
		checkForPacketToSend()


func getSocket():
	return socket


func startServer(port):
	if (socket != null):
		return false
	
	socket = TCP_Server.new()
	
	if (socket.listen(port) == 0):
		return initializeServer(port)
	else:
		socket = null
		return false

func initializeServer(port):
	server_states.server_connected = true
	server_states.looking_for_players = true
	global_client.setHostClient(true)
	
	if (global_client.connectToServer("127.0.0.1", port)):
		return true
	else:
		stopServer()
		return false
	

func resetServerStates():
	server_states.server_connected = false
	server_states.looking_for_players = false
	server_states.game_started = false


func stopServer():
	resetServerStates()
	
	socket.stop()
	player_data.clear()
	
	socket = null


func kickPlayer(player_id):
	for player in range ( player_data.size() ):
		if (player_data[player] != null && player_id == player_data[player][3]):
			sendMessageToAll(-1, player_data[player][2] + " " + tr("MSG_KICKED") + "\n") 
			player_data.remove(player)
			
			updateServerData()
			return


func checkForDisconnection():
	for player in range ( player_data.size() ):
		if ( !player_data[player][0].is_connected() ):
			sendMessageToAll(-1, player_data[player][2] + " " + tr("MSG_LEFT") + "\n")
			player_data.remove(player)
			
			updateServerData()
			return

func checkForMessage():
	for player in range (player_data.size()):
		if (player_data[player][1].get_available_packet_count() > 0):
			var message = player_data[player][1].get_var()
			packet_interpreter.addServerPacket(message, player_data[player][3])


func checkForIncomingConnection():
	if (socket != null && socket.is_connection_available() && server_states.looking_for_players):
		var clientObject = socket.take_connection()
		var clientPeerstream = PacketPeerStream.new()
		clientPeerstream.set_stream_peer(clientObject)
		
		createClientData(clientObject, clientPeerstream)
		checkLookingForPlayers()


func checkForPacketToSend():
	if (packet_list.size() > 0 ):
		sendPacket(packet_list[0])
		packet_list.remove(0)


func createClientData(clientObject, clientPeerstream):
	var player = Array()
	
	player.push_back(clientObject)
	player.push_back(clientPeerstream)
	player.push_back("Client " + str(current_available_id))
	player.push_back(current_available_id)
	player.push_back(false)
	player_data.push_back(player)
	
	current_available_id += 1
	
	clientPeerstream.put_var("/game 0 " + str(current_available_id))
	checkPlayersReady()


func checkLookingForPlayers():
	var current_player_number = player_data.size()
	if ( current_player_number >= 4 ):
		server_states.looking_for_players = false
	else:
		server_states.looking_for_players = true


func sendPacket(packet):
	for player in range (player_data.size()):
		if (player_data[player] != null):
			player_data[player][1].put_var(packet)


func setNickname(player_id, nickname):
	if checkNicknameAlreadyTaken(nickname):
		sendTargetedPacket(player_id, "/game 3 0")
		sendMessageToAll(-1, tr("TXT_CLIENT_CHOOSING_NAME") + "\n")
		return
	
	for player in range (player_data.size()):
		if (player_data[player][3] == player_id):
			player_data[player][2] = nickname
			sendMessageToAll(-1, nickname + " " + tr("MSG_JOINED") + "\n")
			sendTargetedPacket(player_id, "/game 3 1")
			updateServerData()


func checkNicknameAlreadyTaken(nickname):
	for player in range (player_data.size()):
		if (player_data[player][2] == nickname):
			return true
	
	return false


func setPlayerReady(player_id, boolean):
	var root = get_tree().get_current_scene()
	
	for player in range (player_data.size()):
		if (player_data[player][3] == player_id):
			player_data[player][4] = boolean
			if (boolean):
				sendMessageToAll(-1, player_data[player][2] + " " + tr("MSG_READY") + "\n")
			else:
				sendMessageToAll(-1, player_data[player][2] + " " + tr("MSG_NOT_READY") + "\n")
		checkPlayersReady()
		updateReadyPlayers()


func checkPlayersReady():
	var player_ready = 0
	
	for player in range (player_data.size()):
		if (player_data[player][4]):
			player_ready += 1
	
	var start_game_button = get_tree().get_current_scene().get_node("./panel/information_box/server_commands_box/start_game_button")
	
	if ((player_ready == player_data.size() - 1)  && player_data.size() >= 2 && start_game_button != null):
		start_game_button.set_disabled(false)
	elif (start_game_button != null):
		start_game_button.set_disabled(true)


func sendMessageToAll(from_client_id, message):
	var new_message = "/chat "
	
	for player in range(player_data.size()):
		if (player_data[player][3] == from_client_id):
			new_message += player_data[player][2] + ": " + message
			sendPacket(new_message)
	
	if (from_client_id == -1):
		new_message += message
		sendPacket(new_message)


func sendTargetedPacket(to_client_id, packet):
	for player in range (player_data.size()):
		if ( player_data[player][3] == to_client_id ):
			player_data[player][1].put_var(packet)


func addPacket(packet):
	packet_list.push_back(packet)


func updateClientsData():
	var root = get_tree().get_current_scene()
	var packet = "/game 4 0"
	
	if ( root != null && root.get_name() == "lobby" ):
		root.clearKickList()
		for player in range ( player_data.size() ):
			packet += " " + player_data[player][2]
			if (player_data[player][3] != 0):
				root.addPlayerKickList(player_data[player][2], player_data[player][3])
			sendPacket(packet)


func updateReadyPlayers():
	var root = get_tree().get_current_scene()
	var packet = "/game 4 1"
	
	if ( root != null && root.get_name() == "lobby"):
		for player in range ( player_data.size() ):
			if (player_data[player][4]):
				packet += " " + player_data[player][2]
		sendPacket(packet)


func updateServerData():
	updateClientsData()
	updateReadyPlayers()
	checkPlayersReady()
	checkLookingForPlayers()