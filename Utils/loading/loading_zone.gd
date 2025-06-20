extends Area2D
class_name Door

@export var destination_door_tag: String
@export var destination_level_tag: String
@export var spawn_direction: String = "up"


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		TransitionScreen.transition_to_scene()
		await get_tree().create_timer(0.5).timeout
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
