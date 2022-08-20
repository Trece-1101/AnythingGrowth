class_name Ball extends GrowthItem


func _ready() -> void:
	set_label_text(weight)


func set_label_text(mass_value:float) -> void:
	$Label.text = "W\n{mass}".format({"mass": int(mass_value)})


func modify_physics() -> void:
	var new_anim_speed = animation.playback_speed * 0.80
	animation.playback_speed = new_anim_speed
	mass *= 1.2
	set_label_text(weight)


# warning-ignore:unused_argument
func _process(delta: float) -> void:
	var collisions:Array = get_colliding_bodies()
	
	for collision in collisions:
		if collision.is_in_group("platform"):
			collision.should_break(weight)
		elif collision.is_in_group("player"):
			collision.destroy()

func Interact(body: Node) -> void:
	if body.has_method("destroy"):
		body.destroy()


func _on_mouse_entered() -> void:
	._on_mouse_entered()
	set_label_text(weight * 1.2)


func _on_mouse_exited() -> void:
	._on_mouse_exited()
	set_label_text(weight)
