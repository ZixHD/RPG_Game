extends Node

@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var player: CharacterBody2D = $Player
@onready var loading_zone: LoadingZone = $LoadingZone

const ROOM_NAME = "hallway"
const DESTINATION_NAME = "child_room"

func _ready() -> void:
	player.visible = true;
	player.global_position = player_spawn.global_position
	

func _on_loading_zone_body_entered(body: Node2D) -> void:
	
	loading_zone.load_zone.call(ROOM_NAME, DESTINATION_NAME)
	pass 
