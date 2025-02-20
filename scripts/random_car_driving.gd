extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var car: CharacterBody2D = $"."
@export var parkingSpot: Node2D

var speed = 100

func _ready() -> void:
	sprite.frame = randi_range(0,41)
	make_path()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta: float) -> void:
#	var dir = to_local(nav_agent.target_position).normalized()
#	velocity = dir * speed
#	move_and_slide()

func _physics_process(_delta: float) -> void:
	if nav_agent.is_navigation_finished():
		speed = 0
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	var intended_velocity = dir * speed
	car.rotation = dir.angle() + (PI/2.0)
	nav_agent.set_velocity(intended_velocity)
	
	move_and_slide()


func make_path() -> void:
	nav_agent.target_position = parkingSpot.global_position

func _on_timer_timeout() -> void:
	make_path()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
