class_name GrowthPlatform extends Node2D

export var max_weight_allowed:float = 10000.0

var can_growth:bool = true setget set_can_growth
var is_mouse_above:bool = false
var is_cooled_down:bool = true
var growth_number:int = 5
var scale_modifier:float = 1.20

func set_can_growth(value: bool) -> void:
	can_growth = value

func _ready() -> void:
	Events.connect("max_level_growths_reached", self, "set_can_growth", [false])
	set_label_text(max_weight_allowed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("growth") and is_mouse_above and can_growth and is_cooled_down and growth_number > 0:
		growth()

func growth() -> void:
	var tween_g := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
	tween_g.tween_property(self, "scale", scale * scale_modifier, $CoolDown.wait_time)
	Events.emit_signal("shrink_player")
	growth_number -= 1
	$CoolDown.start()
	modify_physics()


func modify_physics() -> void:
	max_weight_allowed *= 1.10
	set_label_text(max_weight_allowed)


func _on_CoolDown_timeout() -> void:
	is_cooled_down = true


func _on_PickableArea_mouse_entered() -> void:
	is_mouse_above = true
	set_label_text(max_weight_allowed * 1.2)


func _on_PickableArea_mouse_exited() -> void:
	is_mouse_above = false
	set_label_text(max_weight_allowed)


func set_label_text(max_weight:float) -> void:
	$Label.text = "L:{load}".format({"load": int(max_weight)})


func Destroy() -> void:
	$AnimationPlayer.play("destroy")
