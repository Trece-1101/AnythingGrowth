class_name Player extends KinematicBody2D

export var speed:float = 400.0
export var gravity:float = 20.0
export var jump_force:float = 10.0
export var max_fall_movement: float = 600
export var max_up_movement:float = 2000
export var dash_force := 1500.0

var movement:Vector2 = Vector2.ZERO
var can_jump:bool = true
var can_dash:bool = true setget set_can_dash
var input_enabled = true setget set_input_enabled
var dashed:bool = false
var alive = true setget ,get_is_alive
var shrink_number = 5
var shrink_scale = 0.90
var impulsed = false

onready var skin:AnimatedSprite = $Skin/AnimatedSprite
onready var tween_dash:Tween = $TweenDash
onready var dash_cool_down:Timer = $TweenDash/CoolDown
onready var foot_position:Position2D = $FootPosition
onready var sfx:PlayerSFX = $SFX


func set_can_dash(value:bool) -> void:
	can_dash = value

func set_input_enabled(value: bool) -> void:
	input_enabled = value

func get_is_alive() -> bool:
	return alive

func get_foot_position() -> float:
	return foot_position.global_position.y


func _ready() -> void:
	Events.connect("shrink_player", self, "shrink")
	Events.connect("level_ended", self, "player_enabled", [false])
	skin.play("idle")


func _unhandled_input(event: InputEvent) -> void:
	if not input_enabled:
		return
	
	if event.is_action_pressed("dash") and can_dash and not dashed:
		dash()


func _physics_process(_delta: float) -> void:
	manage_input()
	if not dashed:
		movement.y += gravity
		movement.y = clamp(movement.y, -max_up_movement, max_fall_movement)
		movement.x = get_horizontal_movement() * speed
		
# warning-ignore:return_value_discarded
	move_and_slide(movement, Vector2.UP, false, 4, PI * 0.25, false)
	
	if is_on_floor():
		movement.y = 0
		can_jump = true
		impulsed = false
	
	if is_on_ceiling():
		movement.y = gravity


func manage_input() -> void:
	if Input.is_action_just_pressed("jump") and can_jump:
		manage_jump()
	
	if Input.is_action_just_released("jump") and not impulsed:
		if movement.y > 0.0:
			movement.y = -jump_force * 0.1
		else:
			movement.y = 0.0
		can_jump = false


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
		movement.y = clamp(movement.y, -max_up_movement, max_fall_movement)
		skin.play("jump")
		sfx.play_jump_sfx()


func dash() -> void:
	dashed = true
	can_dash = false
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
	dash_cool_down.start()


func _on_CoolDown_timeout() -> void:
	can_dash = true


func destroy() -> void:
	alive = false
	input_enabled = false
	rotation_degrees = 90
	skin.play("dead")


func shrink() -> void:
	if shrink_number > 0:
		var tween_s := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		tween_s.tween_property(self, "scale", scale * shrink_scale, 0.5)
		jump_force *= 0.98
		speed *= 1.10
		shrink_number -= 1
	else:
		Events.emit_signal("max_level_growths_reached")


func impulse(value:float) -> void:
	movement.y = 0.0
	movement.y = -value
	can_jump = false
	impulsed = true
