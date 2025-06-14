extends Area2D
class_name LoadingZone

var level: String
var destination: String

var load_zone: Callable = func(level_tag: String, destination_tag: String):
	level = level_tag
	destination = destination_tag
	TransitionScreen.transition_to_scene()
	await get_tree().create_timer(0.5).timeout
	NavigationManager.go_to_level(level, destination)
	
	pass
	
