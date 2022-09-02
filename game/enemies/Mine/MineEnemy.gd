extends GrowthEnemy

onready var animation:AnimationPlayer = $AnimationPlayer

func modify_physics() -> void:
	var new_animation_speed = animation.playback_speed * 0.8
	animation.playback_speed = new_animation_speed

func destroy() -> void:
	$DieSFX.play()
	$AnimationPlayer.play("die")
	$SpriteAnimator.visible = true
	$SpriteAnimator.play("explode")

func _on_SpriteAnimator_animation_finished() -> void:
	$SpriteAnimator.queue_free()


