extends "res://game/enemies/GrowthEnemy.gd"

func modify_physics() -> void:
	reduce_speed(0.85)

export var speed:Vector2 = Vector2(-20.0, 100.0)

var movement:Vector2 = Vector2.ZERO

onready var floor_detector:RayCast2D = $"FloorDetector"
onready var wall_detector:RayCast2D = $"WallDetector"

func reduce_speed(value:float) -> void:
	speed *= value

func _ready() -> void:
	$Sprite.play("move")

func _process(delta: float) -> void:
	if not floor_detector.is_colliding() or wall_detector.is_colliding():
		change_direction()


func _physics_process(_delta: float) -> void:
	movement.x = speed.x
	if not is_on_floor():
		movement.y = speed.y
# warning-ignore:return_value_discarded
	else:
		movement.y = 0
	
	move_and_slide(movement, Vector2.UP)
	print(movement)


func change_direction() -> void:
	speed.x *= -1
	scale.x *= -1
