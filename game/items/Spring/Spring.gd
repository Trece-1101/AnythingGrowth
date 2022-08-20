extends GrowthItem

export var impulse:float = 100.0


func Interact(body: Node) -> void:
	var from_above:bool = body.get_foot_position() > $Detector/CollisionShape2D.global_position.y
	if body.has_method("impulse") and from_above:
		$AnimationPlayer.play("spring")
		print(impulse)
		body.impulse(impulse)

func growth() -> void:
	var tween_g := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	tween_g.tween_property(self, "scale", scale * scale_modifier, $CoolDown.wait_time)
	Events.emit_signal("shrink_player")
	growth_number -= 1
	$CoolDown.start()
	modify_physics()

func modify_physics() -> void:
	impulse *= 1.08
