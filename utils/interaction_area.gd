extends Area2D
class_name InteractionArea

var interact: Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.register_area(self)
	pass # Replace with function body.
