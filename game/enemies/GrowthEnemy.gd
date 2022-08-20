class_name GrowthEnemy extends KinematicBody2D

var can_growth:bool = true setget set_can_growth
var is_mouse_above:bool = false
var is_cooled_down:bool = true
var growth_number:int = 5


func set_can_growth(value: bool) -> void:
	can_growth = value


func _ready() -> void:
	Events.connect("max_level_growths_reached", self, "set_can_growth", [false])


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("growth") and is_mouse_above and can_growth and is_cooled_down and growth_number > 0:
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


func Die(body: Node) -> void:
	if body.has_method("Destroy"):
		body.Destroy()
	
	Destroy()


func Destroy() -> void:
	queue_free()


func _on_mouse_entered() -> void:
	is_mouse_above = true


func _on_mouse_exited() -> void:
	is_mouse_above = false


func _on_CoolDown_timeout() -> void:
	is_cooled_down = true


func _on_Detector_body_entered(body: Node) -> void:
	Die(body)

