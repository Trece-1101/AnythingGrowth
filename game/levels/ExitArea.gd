extends Area2D


func _ready() -> void:
	$CPUParticles2D.emitting = true

func _on_body_entered(_body: Node) -> void:
	Events.emit_signal("level_win")
