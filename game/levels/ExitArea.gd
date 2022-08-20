extends Area2D


func _on_body_entered(body: Node) -> void:
	Events.emit_signal("level_ended")
