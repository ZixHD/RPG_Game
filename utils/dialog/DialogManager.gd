extends Node2D

var dialog_data = {}
func load_dialog(filePath: String) -> void:
	var file: FileAccess = FileAccess.open(filePath, FileAccess.READ)
	if file:
		var content = file.get_as_text();
		var parsed = JSON.parse_string(content);
		if parsed is Dictionary:
			dialog_data = parsed;
	else:
		push_error("Cannot open the file specified")
		

func get_message(item: String) -> String:
	if dialog_data.has(item):
		var messages = dialog_data[item]
		if messages.size() > 0:
			return str(messages[0])
		else:
			return ""  # or some default	
	else:
		push_warning("Dialog key '%s' not found." % item)
		return "[Missing dialog: %s]" % item
