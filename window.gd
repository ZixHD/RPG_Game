extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	var text: String = DialogManager.get_message("window");
	print(text)
	Textbox.queue_text(text)
	
