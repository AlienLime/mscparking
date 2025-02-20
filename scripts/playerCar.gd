extends CharacterBody2D
@onready var player_car: CharacterBody2D = $"."

const speed = 150
var dir : Vector2

func _physics_process(delta: float) -> void:
	velocity = dir * speed
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")
	dir = dir.normalized()
