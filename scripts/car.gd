extends CharacterBody2D

@onready var path: Path2D = $Path2D
@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D

@export move_speed: float = 40.0
@export loop_path: bool = false

var last_postion: Vector2
