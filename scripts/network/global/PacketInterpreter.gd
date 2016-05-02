
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
	
	if (tmpData[0] == "/game"):
		parseGame()
	elif (tmpData[0] == "/nickname"):
		setNickname()
	elif (tmpData[0] == "/chat"):
		parseMessage(packet)


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
		global_client.setClientId(tmpData[2].to_int())
	elif (packet_id == "1"):
		global_server.setPlayerReady(current_player_id, bool(tmpData[2].to_int()))

func setNickname():
	if (current_parsing.server):
		var nickname = tmpData[1]
		global_server.setNickname(current_player_id, nickname)

func setCurrentParsing(current_parser, boolean):
	current_parsing.client = false
	current_parsing.server = false
	
	current_parsing[current_parser] = boolean
	
	pass

func parseMessage(packet):
	var message = packet.substr(5, packet.length() - 5)
	
	if (current_parsing.server):
		global_server.sendMessageToAll(current_player_id, message)
	elif (current_parsing.client):
		global_client.addMessage(message)

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