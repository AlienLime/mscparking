extends Area2D

# Parkingsplads godkendelses conditions
var conditions = [] # List of strings of accepted combinations

func _on_body_entered(body: Node2D) -> void:
	print(conditions)
	print(str(body.color) + "_" + str(body.origin) + "_" + str(body.shape))
	if conditions.has(str(body.color) + "_" + str(body.origin) + "_" + str(body.shape)):
		print("rigtigt")
		owner.score += 1
	print()
