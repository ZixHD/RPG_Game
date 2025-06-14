extends Node

@onready var player: CharacterBody2D = $Player
@onready var player_position: Marker2D = $PlayerPosition
@onready var loading_zone: LoadingZone = $LoadingZone
const ROOM_NAME = "child_room"
const DESTINATION_NAME = "hallway"

func _ready() -> void:
	player.global_position = player_position.global_position;
	
func _on_loading_zone_body_entered(_body: Node2D) -> void:
	player.velocity = Vector2.ZERO
	loading_zone.load_zone.call(ROOM_NAME, DESTINATION_NAME)
