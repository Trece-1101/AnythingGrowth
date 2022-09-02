extends GrowthItem

func Interact(body: Node) -> void:
	if body.has_method("destroy"):
		body.destroy()



func growth() -> void:
	$GrowthSFX.play()
	var tween_g := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	tween_g.tween_property(self, "scale", scale * scale_modifier, $CoolDown.wait_time)
	Events.emit_signal("shrink_player")
	growth_number -= 1
	$CoolDown.start()
	modify_physics()
