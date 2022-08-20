extends Camera2D

var change_scene:bool = false
var next_level:String

func _ready() -> void:
	$AnimationPlayer.play_backwards("fade_in")


func fade_out(level:String) -> void:
	$AnimationPlayer.play("fade_in")
	next_level = level
	change_scene = true


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in" and change_scene:
		get_tree().change_scene(next_level)
