extends Control

func _ready() -> void:
	if GameMusic.get_music_playing() != "menu":
		GameMusic.play_music("menu")
