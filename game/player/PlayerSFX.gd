class_name PlayerSFX extends Node

onready var jump_sfx:AudioStreamPlayer = $Jump
onready var dash_sfx:AudioStreamPlayer = $Dash
onready var impulse_sfx:AudioStreamPlayer = $Impulse
onready var die_sfx:AudioStreamPlayer = $Die

func play_jump_sfx() -> void:
	jump_sfx.play()

func play_dash_sfx() -> void:
	dash_sfx.play()

func play_impulse_sfx() -> void:
	impulse_sfx.play()

func play_die_sfx() -> void:
	die_sfx.play()
