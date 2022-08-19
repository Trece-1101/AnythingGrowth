class_name MainButton extends Button


export(String, FILE, "*.tscn") var go_to_scene = ""
export var is_quitter:bool = false

onready var selection_sfx:AudioStreamPlayer2D = $SelectionSFX
onready var move_sfx:AudioStreamPlayer2D = $MoveSFX


func _on_button_up() -> void:
	selection_sfx.play()


func _on_button_down() -> void:
	if is_quitter:
		get_tree().quit()
	
	if go_to_scene == "":
		return
		
	yield(get_tree().create_timer(0.2), "timeout")
	if get_tree().paused:
		get_tree().paused = false
	get_tree().change_scene(go_to_scene)


func _on_mouse_entered() -> void:
	move_sfx.play()
