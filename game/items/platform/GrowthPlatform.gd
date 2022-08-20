class_name GrowthPlatform extends Node2D

export var is_path_follower = false
export(float, 50.0, 250.0, 10.0) var speed:float = 100.0
export(float, 0.8, 2.0, 0.2) var wait_time: float = 1.2 setget set_wait_time
export var max_weight_allowed:float = 10000.0

var can_growth:bool = true setget set_can_growth
var is_mouse_above:bool = false
var is_cooled_down:bool = true
var growth_number:int = 5
var scale_modifier:float = 1.20

var path_points = null

onready var started = false
onready var timer:Timer = $Timer

func set_wait_time(value: float) -> void:
	wait_time = value
	if not timer:
		yield(self, "ready")
	timer.wait_time = wait_time


func set_can_growth(value: bool) -> void:
	can_growth = value

func _ready() -> void:
	Events.connect("max_level_growths_reached", self, "set_can_growth", [false])
	set_label_text(max_weight_allowed)
	set_process(false)
	if is_path_follower:
		path_points = get_node_or_null("PathPoints")
		
	if path_points:
		set_process(true)
		if not path_points and Engine.editor_hint:
			printerr("Falta ruta para la plataforma")
			return

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("growth") and is_mouse_above and can_growth and is_cooled_down and growth_number > 0:
		growth()


func _process(_delta: float) -> void:
	if Engine.editor_hint:
		return
	
	if !started:
		started = true
		position = path_points.get_start_position()
		timer.start()


func _on_Timer_timeout() -> void:
	var target_position: Vector2 = path_points.get_next_position()
	var distance_to_target := position.distance_to(target_position)
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", target_position, distance_to_target / speed)
	
	tween.connect("finished", self, "_on_Tween_tween_all_completed")


func _on_Tween_tween_all_completed() -> void:
	timer.start()


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
	speed *= 0.80


func _on_CoolDown_timeout() -> void:
	is_cooled_down = true


func _on_PickableArea_mouse_entered() -> void:
	is_mouse_above = true
	if can_growth:
		set_label_text(max_weight_allowed * 1.2)


func _on_PickableArea_mouse_exited() -> void:
	is_mouse_above = false
	set_label_text(max_weight_allowed)


func set_label_text(max_weight:float) -> void:
	$Label.text = "L:{load}".format({"load": int(max_weight)})


func destroy() -> void:
	$AnimationPlayer.play("destroy")
