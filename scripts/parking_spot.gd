extends Area2D

# Parkingsplads godkendelses conditions
var conditions = [] # List of strings of accepted combinations

func _on_body_entered(body: Node2D) -> void:
	if conditions.has(str(body.color) + "_" + str(body.origin) + "_" + str(body.shape)):
		owner.score += 1
