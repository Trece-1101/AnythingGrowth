extends Node2D



func _on_Detector_body_entered(body: Node) -> void:
	$Detector/CollisionShape2D.set_deferred("disabled", true)
	var body_pos:float = body.global_position.x
	var from_left:bool = body_pos < self.global_position.x
	if from_left:
		$AnimatedSprite.play("switch_to_right")
	else:
		$AnimatedSprite.play("switch_to_left")
