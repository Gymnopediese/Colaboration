extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var device_ip_adresse = $device_ip_adresse

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	device_ip_adresse.text = P2PServer.ip_address

func _player_connected(id) -> void:
	print("Player " + str(id) + " is connected")

func _player_disconnected(id) -> void:
	print("Player " + str(id) + " is disconnected")

func _on_StartButton_pressed():
	get_tree().change_scene("res://main.tscn")

func _on_OptionButton_pressed():
	pass # A faire

func _on_CreateServerButton_pressed():
	self.hide()
	P2PServer.create_server()
	print("Server created")

func _on_JoinServerButton_pressed():
	if device_ip_adresse.text != "":
		self.hide()
		P2PServer.ip_address = device_ip_adresse.text
		P2PServer.join_server()

func _on_QuitButton_pressed():
	get_tree().quit()
