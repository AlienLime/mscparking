extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	sprite.frame = randi_range(0,41)
