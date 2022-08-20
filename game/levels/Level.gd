tool
extends Node

export(String, FILE, "*.tscn") var next_level = ""


func _get_configuration_warning():
	if next_level == "":
		return "No hay proximo nivel"
	
	return ""

