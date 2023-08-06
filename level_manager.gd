extends Node


func next_level_path() -> String:
	var current_path = get_tree().current_scene.scene_file_path
	if not current_path.contains("/levels/"):
		return ""
	var level = int(current_path)
	var next_level = level + 1
	return current_path.replace(str(level), str(next_level))


func has_next_level() -> bool:
	var path = next_level_path()
	if path:
		return ResourceLoader.exists(path)
	return false


func change_to_next_level() -> void:
	var path = next_level_path()
	if path:
		get_tree().change_scene_to_file(path)
