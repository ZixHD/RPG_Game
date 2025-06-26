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
		

func get_message(item: String) -> Array[Dictionary]:
	
	if dialog_data.has(item):
		var messages = dialog_data[item]
		if messages is Array:
			var result: Array[Dictionary] = []
			for msg in messages:
				if msg is String:
					result.append({
						"type": "text",
						"text": msg
					})
				elif msg is Dictionary and msg.has("type"):
					result.append(msg)
				else:
					push_warning("Unrecognized dialog entry for '%s': %s" % [item, str(msg)])
			return result
		else:
			push_warning("Value for key '%s' is not an array." % item)
	else:
		push_warning("Dialog key '%s' not found." % item)
	
	return []
