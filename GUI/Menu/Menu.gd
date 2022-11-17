extends Control


func _ready():
	$CanvasLayer/VBoxContainer/StartButton.grab_focus()
	print(is_network_master())
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	$device_ip_adresse.text = P2PServer.ip_address

puppet var instanciate_players = [[1, 0]] setget instanciate_players_set

func instanciate_players_set(players_list):
	print(players_list)
	for i in players_list:
		Scene.populate_player(i[0], i[1])
	
func _connected_to_server():
	print("yg")
	
func _player_connected(id) -> void:
	print("Player " + str(id) + " is connected")
	print (id)
	if is_network_master():
		Scene.populate_player(id, len(instanciate_players))
		instanciate_players.push_back([id, len(instanciate_players)])
		rset_unreliable("instanciate_players", instanciate_players)

func _player_disconnected(id) -> void:
	print("Player " + str(id) + " is disconnected")
	#Supprimer le joueur

func _on_StartButton_pressed():
	pass
	#get_tree().change_scene("res://main.tscn")

func _on_OptionButton_pressed():
	pass # A faire

func _on_CreateServerButton_pressed():
	hide()
	P2PServer.create_server()
	print("Server created")
	Scene.populate_player(get_tree().get_network_unique_id(), 0)
	Global.camera_start = true
	get_parent().get_node("game").show()
#169.254.206.238

func _on_JoinServerButton_pressed():
	var debug = true
	if debug and $device_ip_adresse.text != "": #A changer
		self.hide()
		$CanvasLayer.hide()
		P2PServer.ip_address = $device_ip_adresse.text
		P2PServer.join_server()
		#Scene.populate_player(get_tree().get_network_unique_id())
		Global.camera_start = true
		get_parent().get_node("game").show()
	elif not debug and $LineIpAdresse.text != "":
		$CanvasLayer.hide()
		self.hide()
		P2PServer.ip_address = $LineIpAdresse.text
		P2PServer.join_server()
		#Scene.populate_player(get_tree().get_network_unique_id())
		Global.camera_start = true
		$main.show()

func _on_QuitButton_pressed():
	get_tree().quit()
