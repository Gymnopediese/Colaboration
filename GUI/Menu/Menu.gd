extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var device_ip_adresse = $device_ip_adresse
onready var line_ip_adresse = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	device_ip_adresse.text = P2PServer.ip_address

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _connected_to_server():
	print("yg")
func _player_connected(id) -> void:
	print("Player " + str(id) + " is connected")
	print (id)
	Scene.populate_player(id)

func _player_disconnected(id) -> void:
	print("Player " + str(id) + " is disconnected")
	#Supprimer le joueur

func _on_StartButton_pressed():
	get_tree().change_scene("res://main.tscn")

func _on_OptionButton_pressed():
	pass # A faire

func _on_CreateServerButton_pressed():
	self.hide()
	P2PServer.create_server()
	print("Server created")
	Scene.populate_player(get_tree().get_network_unique_id())
	Global.camera_start = true
	get_parent().get_node("game").show()
#169.254.206.238

func _on_JoinServerButton_pressed():
	var debug = true
	if debug and device_ip_adresse.text != "": #A changer
		self.hide()
		P2PServer.ip_address = device_ip_adresse.text
		P2PServer.join_server()
		Scene.populate_player(get_tree().get_network_unique_id())
		Global.camera_start = true
		get_parent().get_node("game").show()
	elif not debug and line_ip_adresse.text != "":
		self.hide()
		P2PServer.ip_address = line_ip_adresse.text
		P2PServer.join_server()
		Scene.populate_player(get_tree().get_network_unique_id())
		Global.camera_start = true
		$main.show()

func _on_QuitButton_pressed():
	get_tree().quit()
