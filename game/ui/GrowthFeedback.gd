extends Sprite

onready var animation:AnimationPlayer = $AnimationPlayer


func show() -> void:
	animation.play("show")

func hide() -> void:
	animation.stop(true)
	visible = false
