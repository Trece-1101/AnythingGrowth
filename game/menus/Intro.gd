extends Node

export(String, FILE, "*.tscn") var main_menu = ""

func change_scene() -> void:
	if main_menu != "":
		get_tree().change_scene(main_menu)
