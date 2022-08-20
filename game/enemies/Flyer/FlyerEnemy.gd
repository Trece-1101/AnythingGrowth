extends GrowthEnemy

func _ready() -> void:
	$SpriteAnimator.play("fly")

func Destroy() -> void:
	$AnimationPlayer.play("die")

func modify_physics() -> void:
	var new_animation_speed = $SpriteAnimator.speed_scale * 0.9
	$SpriteAnimator.speed_scale = new_animation_speed
