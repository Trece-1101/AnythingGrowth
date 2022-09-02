class_name GrowthFeedback extends Node2D

onready var animation:AnimationPlayer = $AnimationPlayer

#func set_growths_left(value:int) -> void:
#	$SpriteBox/Label.text = "{v}".format({"v": value})

func show_enabled(value:int) -> void:
	visible = true
	animation.stop(true)
	$SpriteBox/Label.text = "{v}".format({"v": value})
	animation.play("show")


func show_disabled() -> void:
	visible = true
	animation.stop(true)
	animation.play("disable")


func hide_feedback() -> void:
	animation.stop(true)
	visible = false
