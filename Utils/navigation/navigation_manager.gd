extends Node

const CHILD_ROOM = preload("res://Scenes/ChildRoom/child_room.tscn")
const HALLWAY = preload("res://Scenes/Hallway/hallway.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load:PackedScene
	match level_tag:
		"child_room":
			scene_to_load = HALLWAY
		"hallway":
			scene_to_load = CHILD_ROOM
	
	if scene_to_load != null:
		spawn_door_tag = destination_tag;
		get_tree().change_scene_to_packed(scene_to_load)
		
func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
