tool
extends Node

export(String, FILE, "*.tscn") var next_level = ""
export var seconds_to_finish:int = 60

onready var level_camera:Camera2D = $Camera
onready var hud:HUD = $Camera/HUD

func _ready() -> void:
	hud.set_level_text(self.name)
	hud.set_time_to_finish(seconds_to_finish)
	Events.connect("level_win", self, "change_level")


func _get_configuration_warning():
	if next_level == "":
		return "No hay proximo nivel"
	
	return ""

func change_level() -> void:
	if next_level != "":
		level_camera.fade_out(next_level)
