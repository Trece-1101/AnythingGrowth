class_name GrowthEnemy extends KinematicBody2D

var can_growth:bool = true setget set_can_growth
var is_mouse_above:bool = false
var is_cooled_down:bool = true
var growth_number:int = 5
var scale_modifier:float = 1.20
var is_alive:bool = true

onready var visual_feedback:GrowthFeedback = $GrowthFeedback

func set_can_growth(value: bool) -> void:
	can_growth = value


func _ready() -> void:
	Events.connect("max_level_growths_reached", self, "set_can_growth", [false])


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("growth") and is_mouse_above and can_growth and is_cooled_down and growth_number > 0 and is_alive:
		growth()
		check_visual_feedback()


func growth() -> void:
	$GrowthSFX.play()
	var tween_g := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	tween_g.tween_property(self, "scale", scale * scale_modifier, $CoolDown.wait_time)
	Events.emit_signal("shrink_player")
	growth_number -= 1
	$CoolDown.start()
	if OS.is_debug_build():
		print("growth - ", growth_number)
	modify_physics()


func modify_physics() -> void:
	pass


func Die(body: Node) -> void:
	$DieSFX.play()
	is_alive = false
	visual_feedback.hide_feedback()
	if body.has_method("destroy"):
		body.destroy()
	
	destroy()


func destroy() -> void:
	queue_free()


func _on_CoolDown_timeout() -> void:
	is_cooled_down = true


func _on_Detector_body_entered(body: Node) -> void:
	Die(body)


func _on_PickableArea_mouse_entered() -> void:
	is_mouse_above = true
	check_visual_feedback()


func _on_PickableArea_mouse_exited() -> void:
	is_mouse_above = false
	visual_feedback.hide_feedback()


func check_visual_feedback() -> void:
	if not can_growth or not is_cooled_down or growth_number <= 0:
		visual_feedback.show_disabled()
	else:
		visual_feedback.show_enabled(growth_number)
