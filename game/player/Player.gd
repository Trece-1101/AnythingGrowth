class_name Player extends KinematicBody2D

export var speed:float = 400.0
export var gravity:float = 20.0
export var jump_force:float = 400.0
export var dash_force := 1500.0

var movement:Vector2 = Vector2.ZERO
var can_jump:bool = true
var can_dash:bool = true setget set_can_dash
var input_enabled = true setget set_input_enabled
var dashed:bool = false
var alive = true setget ,get_is_alive

onready var skin:AnimatedSprite = $Skin/AnimatedSprite
onready var tween_dash:Tween = $TweenDash


func set_can_dash(value:bool) -> void:
	can_dash = value

func set_input_enabled(value: bool) -> void:
	input_enabled = value

func _ready() -> void:
	skin.play("idle")

func get_is_alive() -> bool:
	return alive

func _unhandled_input(event: InputEvent) -> void:
	if not input_enabled:
		return
	
	if event.is_action_pressed("jump"):
		manage_jump()
	elif event.is_action_pressed("dash") and can_dash and not dashed:
		dash()


func _physics_process(_delta: float) -> void:
	if not dashed:
		movement.y += gravity
	
	if not dashed:
		movement.x = get_horizontal_movement() * speed
	
# warning-ignore:return_value_discarded
	move_and_slide(movement, Vector2.UP)
	
	if is_on_floor():
		movement.y = 0
		can_jump = true
	
	if is_on_ceiling():
		movement.y = gravity


func get_horizontal_movement() -> float:
	if not input_enabled:
		return 0.0
	var h_mov := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		
	if h_mov == 0:
		if is_on_floor():
			skin.play("idle")
		else:
			if movement.y < 0:
				skin.play("jump")
			else:
				skin.play("fall")
	else:
		skin.scale.x = h_mov * -1
		skin.play("run")
	
	return h_mov


func manage_jump() -> void:
	if can_jump:
		movement.y = 0.0
		movement.y = -jump_force
		skin.play("jump")


func dash() -> void:
	dashed = true
	movement = Vector2.ZERO
# warning-ignore:return_value_discarded
	tween_dash.interpolate_property(
		self,
		"movement:x",
		0.0,
		(dash_force * skin.scale.x) * -1,
		0.15,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
	)
# warning-ignore:return_value_discarded
	tween_dash.start()


func disabled_player() -> void:
	if alive:
		movement = Vector2.ZERO
		player_enabled(false)
		skin.play("idle")

func player_enabled(valor:bool) -> void:
	set_process(valor)
	set_physics_process(valor)
	input_enabled = valor


func _on_TweenDash_tween_all_completed() -> void:
	dashed = false


func die() -> void:
	alive = false
	input_enabled = false
	rotation_degrees = 90
	skin.play("dead")
