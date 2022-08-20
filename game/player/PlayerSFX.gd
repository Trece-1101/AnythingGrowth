class_name PlayerSFX extends Node

onready var jump_sfx:AudioStreamPlayer = $Jump

func play_jump_sfx() -> void:
	jump_sfx.play()
