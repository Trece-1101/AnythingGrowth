extends StaticBody2D

var max_weight:float

func should_break(weight: float):
	max_weight = owner.max_weight_allowed
	#return true if weight >= max_weight else false
	if weight >= max_weight:
		$"../AnimationPlayer".play("destroy")
