class_name Ball extends GrowthItem


func modify_physics() -> void:
	var new_anim_speed = animation.playback_speed * 0.80
	animation.playback_speed = new_anim_speed
	mass *= 1.2
	

func _process(delta: float) -> void:
	var collisions:Array = get_colliding_bodies()
	
	for collision in collisions:
		if collision.is_in_group("platform"):
			collision.should_break(weight)
