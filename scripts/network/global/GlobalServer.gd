
extends Node

var socket = null setget ,getSocket
var player_data = Array()
var packet_list = Array() setget addPacket

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
	var global_client = get_node("/root/GlobalClient")
	
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
		if (player_id == player_data[player][3]):
			sendMessageToAll(-1, player_data[player][2] + " has been kicked from server\n") 
			player_data.remove(player)
			
			updateServerData()


func checkForDisconnection():
	for player in range (player_data.size()):
		if (player_data[player][0] != null && !player_data[player][0].is_connected()):
			sendMessageToAll(-1, player_data[player][2] + " disconnected\n")
			player_data.remove(player)
			
			updateServerData()


func checkForMessage():
	for player in range (player_data.size()):
		if (player_data[player][1].get_available_packet_count() > 0):
			var message = player_data[player][1].get_var()
			get_node("/root/PacketInterpreter").addServerPacket(message, player_data[player][3])


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
	var player_id = player_data.size()
	
	player.push_back(clientObject)
	player.push_back(clientPeerstream)
	player.push_back("Client " + str(player_id))
	player.push_back(player_id)
	player.push_back(false)
	player_data.push_back(player)
	
	clientPeerstream.put_var("/game 0 " + str(player_id))


func checkLookingForPlayers():
	var current_player_number = player_data.size()
	if ( current_player_number >= 4 ):
		server_states.looking_for_players = false
	else:
		server_states.looking_for_players = true


func sendPacket(packet):
	for player in range (player_data.size()):
		player_data[player][1].put_var(packet)
	pass


func setNickname(player_id, nickname):
	if checkNicknameAlreadyTaken(nickname):
		#sendPacket
		return
	
	for player in range (player_data.size()):
		if (player_data[player][3] == player_id):
			player_data[player][2] = nickname
			sendMessageToAll(-1, nickname + " joined the server\n")
			updateClientsData()


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
				sendMessageToAll(-1, player_data[player][2] + " is ready to play\n")
			else:
				sendMessageToAll(-1, player_data[player][2] + " is no longer ready\n")
		checkPlayersReady()
		updateReadyPlayers()


func checkPlayersReady():
	var player_ready = 0
	
	for player in range (player_data.size()):
		if (player_data[player][4]):
			player_ready += 1
	
	var start_game_button = get_tree().get_current_scene().get_node("./panel/clients_information_box/start_game_button")
	
	if ((player_ready == player_data.size() - 1) && start_game_button != null):
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
	
	if ( root != null && root.get_name() == "lobby" ):
		root.clearConnectedClientsLabel()
		root.clearKickList()
		for player in range ( player_data.size() ):
			root.addConnectedClient("- " + player_data[player][2] + "\n")
			if (player_data[player][3] != 0):
				root.addPlayerKickList(player_data[player][2], player_data[player][3])


func updateReadyPlayers():
	var root = get_tree().get_current_scene()
	
	if ( root != null && root.get_name() == "lobby"):
		root.clearReadyPlayersLabel()
		for player in range ( player_data.size() ):
			if (player_data[player][4]):
				root.addReadyPlayer("- " + player_data[player][2] + "\n")


func updateServerData():
	updateClientsData()
	updateReadyPlayers()
	checkPlayersReady()
	checkLookingForPlayers()