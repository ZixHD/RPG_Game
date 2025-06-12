extends Node2D

var file_path: String = "res://Utils/dialog/json/child_room.json"
func _ready() -> void:
	DialogManager.load_dialog(file_path)
