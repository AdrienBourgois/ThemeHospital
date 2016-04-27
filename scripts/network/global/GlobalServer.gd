
extends Node

var socket = null setget ,getSocket
var host_name = null setget setHostName,getHostName
var messages_list = Array() setget addMessage,getMessagesList
var player_data = Array()
var packet_list = Array() setget addPacket,getPacketList
var current_packet_number = 0

var server_states = {
	server_connected = false,
	looking_for_players = false,
	game_started = false
}

func _ready():
	set_process(true)
	pass

func _process(delta):
	if (server_states.server_connected):
		checkForDisconnection()
		checkForIncomingConnection()
		checkForMessage()


func getSocket():
	return socket


func addMessage(message):
	messages_list.push_back(message)

func getMessagesList():
	return messages_list


func addPacket(packet):
	packet_list.push_back(packet)

func getPacketList():
	return packet_list


func setHostName(nickname):
	if (!nickname.empty() && host_name == null):
		host_name = nickname
		print("host name: ", host_name)
	else:
		print("nope")

func getHostName():
	return host_name


func startServer(port):
	if (socket != null):
		return false
	
	socket = TCP_Server.new()
	
	if (socket.listen(port) == 0):
		print("server is listening")
		server_states.server_connected = true
		server_states.looking_for_players = true
		return true
	else:
		socket = null
		return false


func stopServer():
	server_states.server_connected = false
	server_states.looking_for_players = false
	
	socket.stop()
	player_data.clear()
	messages_list.clear()
	
	socket = null


func checkForDisconnection():
	for player in range (player_data.size()):
		if (player_data[player][0] != null && !player_data[player][0].is_connected()):
			print("client disconnected")
			player_data[player].remove()
			checkLookingForPlayers()


func checkForMessage():
	for player in range (player_data.size()):
		if (player_data[player][1].get_available_packet_count() > 0):
			messages_list.push_back(player_data[player][1].get_var())
			#Make Packet Interpreter script to parse messages received


func checkForIncomingConnection():
	if (socket != null && socket.is_connection_available() && server_states.looking_for_players):
		var clientObject = socket.take_connection()
		var clientPeerstream = PacketPeerStream.new()
		clientPeerstream.set_stream_peer(clientObject)
		
		createClientData(clientObject, clientPeerstream)
		checkLookingForPlayers()


func createClientData(clientObject, clientPeerstream):
	var player = Array()
	var player_id = player_data.size() + 1
	
	player.push_back(clientObject)
	player.push_back(clientPeerstream)
	player.push_back("Client " + str(player_id))
	player.push_back(player_id)
	player.push_back(false)
	player.push_back(false)
	player_data.push_back(player)


func checkLookingForPlayers():
	var current_player_number = player_data.size() + 1
	if (current_player_number >= 4):
		server_states.looking_for_players = false
	else:
		server_states.looking_for_players = true


func sendPacket(packet):
	for player in range (player_data.size()):
		player_data[player][1].put_var(packet)
	pass