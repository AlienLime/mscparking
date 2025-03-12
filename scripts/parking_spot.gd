extends Area2D

# Parkingsplads godkendelses conditions
var conditions = [] # List of strings of accepted combinations
var isFree = true

func _on_body_entered(body: Node2D) -> void:
	owner.parked += 1
	body.isParked = true
	if conditions.has(str(body.color) + "_" + str(body.origin) + "_" + str(body.shape)):
		owner.score += 1
		body.isParkedCorrectly = true
