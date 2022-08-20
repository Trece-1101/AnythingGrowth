class_name Platform extends Node2D

export var max_weight_allowed:float = 10000.0


func Destroy() -> void:
	$AnimationPlayer.play("destroy")
