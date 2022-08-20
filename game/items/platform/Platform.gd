class_name Platform extends Node2D

export var max_weight_allowed:float = 10000.0


func _ready() -> void:
	set_label_text(max_weight_allowed)


func set_label_text(max_weight:float) -> void:
	$Label.text = "L:{load}".format({"load": int(max_weight)})


func destroy() -> void:
	$AnimationPlayer.play("destroy")
