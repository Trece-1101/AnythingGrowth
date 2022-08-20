extends KinematicBody2D

var can_growth:bool = false
var is_cooled_down:bool = true
var growth_number:int = 5


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("growth") and can_growth and is_cooled_down and growth_number > 0:
		growth()


func growth() -> void:
	var tween_g := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	tween_g.tween_property(self, "scale", scale * 1.20, $CoolDown.wait_time)
	Events.emit_signal("shrink_player")
	growth_number -= 1
	$CoolDown.start()
	modify_physics()


func modify_physics() -> void:
	pass


func _on_mouse_entered() -> void:
	can_growth = true


func _on_mouse_exited() -> void:
	can_growth = false


func _on_CoolDown_timeout() -> void:
	is_cooled_down = true
