extends GrowthEnemy

export var is_path_follower = false
export(float, 50.0, 250.0, 10.0) var speed:float = 100.0
export(float, 0.8, 2.0, 0.2) var wait_time: float = 1.0 setget set_wait_time


var path_points = null

onready var started = false
onready var timer:Timer = $Timer


func set_wait_time(value: float) -> void:
	wait_time = value
	if not timer:
		yield(self, "ready")
	timer.wait_time = wait_time


func _ready() -> void:
	set_process(false)
	if is_path_follower:
		path_points = get_node_or_null("PathPoints")
		
	if path_points:
		set_process(true)
		if not path_points and Engine.editor_hint:
			printerr("Falta ruta para la plataforma")
			return
	
	$SpriteAnimator.play("fly")


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



func destroy() -> void:
	timer.stop()
	set_process(false)
	$AnimationPlayer.play("die")


func modify_physics() -> void:
	var new_animation_speed = $SpriteAnimator.speed_scale * 0.9
	$SpriteAnimator.speed_scale = new_animation_speed
	speed *= 0.85
