tool
extends Node

export(String, FILE, "*.tscn") var next_level = ""


func _ready() -> void:
	Events.connect("level_ended", self, "change_level")


func _get_configuration_warning():
	if next_level == "":
		return "No hay proximo nivel"
	
	return ""

func change_level() -> void:
	if next_level != "":
		get_tree().change_scene(next_level)
