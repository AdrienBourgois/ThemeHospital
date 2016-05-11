
extends Node

var tmpData = Array()
var client_packets_list = Array() setget addServerPacket,getServerPacketsList
var server_packets_list = Array() setget addClientPacket,getClientPacketsList
var current_player_id = null
onready var global_client = get_node("/root/GlobalClient")
onready var global_server = get_node("/root/GlobalServer")

var current_parsing = {
	server = false,
	client = false
}

func _ready():
	set_process(true)

func _process(delta):
	checkPacketToInterpret()


func checkPacketToInterpret():
	if (client_packets_list.size() > 0):
		setCurrentParsing("client", true)
		parsePacket(client_packets_list[0])
		client_packets_list.remove(0)
	
	if (server_packets_list.size() > 0):
		setCurrentParsing("server", true)
		current_player_id = server_packets_list[0][1]
		parsePacket(server_packets_list[0][0])
		server_packets_list.remove(0)


func parsePacket(packet):
	storeData(packet)
	
	var keyword = tmpData[0]
	
	if (keyword == "/game"):
		parseGame()
	elif (keyword == "/nickname"):
		setNickname()
	elif (keyword == "/chat"):
		parseMessage(packet)
	elif (keyword == "/info"):
		parseInfo()


func storeData(packet):
	tmpData.clear()
	var data = ""
	
	for character in range (packet.length()):
		if (packet[character] == ' '):
			if (!checkForEmptyness(data)):
				tmpData.push_back(data)
				data = ""
		else:
			data += packet[character]
	
	if (!checkForEmptyness(data)):
		tmpData.push_back(data)


func checkForEmptyness(data):
	if (data.empty()):
		return true
	
	for character in range (data.length()):
		if (data[character] != ' '):
			return false
	
	return true


func parseGame():
	var packet_id = tmpData[1]
	
	if (packet_id == "0"):
		playerIdPacket()
	elif (packet_id == "1"):
		playerReadyPacket()
	elif (packet_id == "2"):
		gameStartedPacket()
	elif (packet_id == "3"):
		checkNicknamePacket()
	elif (packet_id == "4"):
		updateLobbyData()
	elif (packet_id == "5"):
		updateMapRoom()


func playerIdPacket(): #Packet 0
	global_client.setClientId(tmpData[2].to_int())

func playerReadyPacket(): #Packet 1
	global_server.setPlayerReady(current_player_id, bool(tmpData[2].to_int()))

func gameStartedPacket(): #Packet 2
	var scene = tmpData[2]
	
	if (scene == "0"):
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/network/MapSelect.scn")
	elif (scene == "1"):
		get_tree().get_current_scene().queue_free()
		get_tree().change_scene("res://scenes/gamescn.scn")

func checkNicknamePacket(): #Packet 3
	var nickname_is_ok = bool(tmpData[2].to_int())
	var current_scene = get_tree().get_current_scene()
	
	if ( current_scene.get_name() == "lobby" ):
		current_scene.displayNicknameMenu(nickname_is_ok)


func updateLobbyData(): #Packet 4
	var label_to_update = tmpData[2]
	var scene = get_tree().get_current_scene()
	
	if (scene != null && scene.get_name() == "lobby"):
		if (label_to_update == "0"):
			scene.clearConnectedClientsLabel()
			for connected_client in range (3, tmpData.size()):
				scene.addConnectedClient("- " + tmpData[connected_client] + "\n")
		elif (label_to_update == "1"):
			scene.clearReadyPlayersLabel()
			for ready_client in range (3, tmpData.size()):
				scene.addReadyPlayer("- " + tmpData[ready_client] + "\n")

func updateMapRoom(): #Packet 5
	var state = tmpData[2]
	var parameters = tmpData[3]
	
	if (current_parsing.server):
		global_server.addPacket("/game 5 " + state + " " + parameters)
	elif (current_parsing.client):
		var x = 0
		var y = 0
		for character in range ( tmpData[3].length() ):
			if ( tmpData[3][character] == ","):
				x = int(tmpData[3].substr(0, character))
				y = int(tmpData[3].substr(character, tmpData[3].length()))
		var root = get_tree().get_current_scene()
		if (root != null && root.get_name() == "GameScene"):
			var map = root.get_child(1)
			if (map.get_name() == "Map"):
				map.new_room(state, Vector2(x,y))


func setNickname():
	if ( current_parsing.server ):
		var nickname = tmpData[1]
		global_server.setNickname(current_player_id, nickname)


func setCurrentParsing(current_parser, boolean):
	current_parsing.client = false
	current_parsing.server = false
	
	current_parsing[current_parser] = boolean


func parseMessage(packet):
	var message = packet.substr(6, packet.length() - 6)
	
	if (current_parsing.server):
		global_server.sendMessageToAll(current_player_id, message)
	elif (current_parsing.client):
		global_client.addMessage(message)


func parseInfo():
	var info = ""
	
	for word in range ( 1, tmpData.size() ):
		if (tmpData[word].begins_with("MSG")):
			info += tr(tmpData[word]) + " "
		else:
			info += tmpData[word] + " "
	
	info += "\n"
	
	global_client.addMessage(info)

func addServerPacket(packet, client_id):
	var client_data = Array()
	client_data.push_back(packet)
	client_data.push_back(client_id)
	server_packets_list.push_back(client_data)

func getServerPacketsList():
	return server_packets_list


func addClientPacket(packet):
	client_packets_list.push_back(packet)

func getClientPacketsList():
	return client_packets_list