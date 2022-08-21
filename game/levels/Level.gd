tool
extends Node

export(String, FILE, "*.tscn") var next_level = ""
export var seconds_to_finish:int = 60
export var is_tutorial:bool = false

onready var level_camera:Camera2D = $Camera
onready var hud:HUD = $Camera/HUD

func _ready() -> void:
	if GameMusic.get_music_playing() != "level":
		GameMusic.play_music("level")
	if is_tutorial:
		$CanvasLayer.visible = true
	hud.set_level_text(self.name)
	hud.set_time_to_finish(seconds_to_finish)
	Events.connect("level_win", self, "change_level")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _get_configuration_warning():
	if next_level == "":
		return "No hay proximo nivel"
	
	return ""

func change_level() -> void:
	if next_level != "":
		level_camera.fade_out(next_level)
