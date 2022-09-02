extends KinematicBody2D

export var jump_duration: float  # T
export var jump_height: float    # H

var velocity: Vector2
var gravity: float

func _ready() -> void:
	# Compute the gravity (g) once here
	gravity = 8 * (jump_height / pow(jump_duration, 2))


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, 1))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		velocity.y -= gravity * 0.5 * jump_duration
