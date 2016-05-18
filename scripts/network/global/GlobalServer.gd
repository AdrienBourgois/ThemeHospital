
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
	packet_list.clear()
	
	socket = null
	current_available_id = 0


func kickPlayer(player_id):
	for player in range ( player_data.size() ):
		if (player_data[player] != null && player_id == player_data[player][3]):
			sendInfo(player_data[player][2] + " MSG_KICKED") 
			sendTargetedPacket(player_data[player][3], "/game 7")
			player_data[player][5] = true
			updateServerData()
			return


func checkForDisconnection():
	for player in range ( player_data.size() ):
		if ( !player_data[player][0].is_connected() ):
			if ( !player_data[player][5] ):
				sendInfo(player_data[player][2] + " MSG_LEFT")
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
	player.push_back(null)
	player.push_back(current_available_id)
	player.push_back(false)
	player.push_back(false)
	player.push_back(Array())
	player_data.push_back(player)
	
	current_available_id += 1
	
	clientPeerstream.put_var("/game 0 " + str(player[3]))
	checkPlayersReady()


func checkLookingForPlayers():
	var current_player_number = player_data.size()
	if ( current_player_number >= 4 ):
		server_states.looking_for_players = false
	else:
		server_states.looking_for_players = true


func setNickname(player_id, nickname):
	if checkNicknameAlreadyTaken(nickname):
		sendTargetedPacket(player_id, "/game 3 0")
		sendInfo("MSG_CLIENT_CHOOSING_NAME")
		return
	
	for player in range (player_data.size()):
		if (player_data[player][3] == player_id):
			player_data[player][2] = nickname
			sendInfo(nickname + " MSG_JOINED")
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
				sendInfo(player_data[player][2] + " MSG_READY")
				pass
			else:
				sendInfo(player_data[player][2] + " MSG_NOT_READY")
				pass
	
	checkPlayersReady()
	updateReadyPlayers()


func checkPlayersReady():
	if (player_data.size() < 2):
		return
	
	var player_ready = 0
	var root = get_tree().get_current_scene()
	
	for player in range (player_data.size()):
		if (player_data[player][4]):
			player_ready += 1
	
	if (root == null || root.get_name() != "lobby"):
		return
	
	var start_game_button = root.get_node("./panel/information_box/server_commands_box/start_game_button")
	
	if ((player_ready == player_data.size() - 1) && start_game_button != null):
		start_game_button.set_disabled(false)
	elif (start_game_button != null):
		start_game_button.set_disabled(true)


func sendMessageToAll(from_client_id, message):
	var new_message = "/chat "
	
	for player in range(player_data.size()):
		if (player_data[player][3] == from_client_id):
			new_message += player_data[player][2] + ": " + message
			sendMessage(from_client_id, new_message)

func sendMessage(from_client_id, message):
	for player in range ( player_data.size() ):
		if ( !checkMutedPlayer(from_client_id, player) ):
			sendTargetedPacket(player_data[player][3], message)

func checkMutedPlayer(from_client_id, player):
	for player_muted in range (player_data[player][6].size() ):
		if ( player_data[player][6][player_muted].to_int() == from_client_id):
			return true
	
	return false

func sendInfo(message):
	var info_message = "/info " + message
	
	sendPacket(info_message)


func sendTargetedPacket(to_client_id, packet):
	for player in range (player_data.size()):
		if ( player_data[player][3] == to_client_id ):
			player_data[player][1].put_var(packet)
			return


func sendPacket(packet):
	for player in range (player_data.size()):
		if (player_data[player] != null && player_data[player][2] != null):
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


func sendMutablePlayers():
	var packet = "/game 8"
	
	for data in range (player_data.size()):
		packet += " " + player_data[data][2] + " " + str(player_data[data][3])
	
	sendPacket(packet)

func mutePlayer(player_id, muted_player_id):
	for player in range ( player_data.size() ):
		if (player_data[player][3] == player_id):
			var new_array = player_data[player][6]
			new_array.push_back(muted_player_id)
			player_data[player][6] = new_array
			return

func unmutePlayer(player_id, unmuted_player_id):
	for player in range ( player_data.size() ):
		if (player_data[player][3] == player_id):
			for muted_player in range ( player_data[player][6].size() ):
				if (player_data[player][6][muted_player] == unmuted_player_id):
					var new_array = player_data[player][6]
					new_array.remove(muted_player)
					player_data[player][6] = new_array
					return