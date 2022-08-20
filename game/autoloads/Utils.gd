extends Node

static func CreateRandomDirection() -> float:
	randomize()
	var random:float = rand_range(0.0, 1.0)
	
	return -1.0 if random <= 0.5 else 1.0
