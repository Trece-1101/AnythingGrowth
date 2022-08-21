extends Node

export(String, FILE, "*.tscn") var main_menu = ""

func _on_Return_pressed() -> void:
	if main_menu != "":
		GameMusic.play_button()
		get_tree().change_scene(main_menu)
