extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var car: CharacterBody2D = $"."
@export var parkingSpot: Node2D

var random = randi_range(0,13)
var color: int
var origin: int
var shape: int

var speed = 175
var ID = "ID"

func _ready() -> void:
	sprite.frame = random
	if random >= 7:
		color=1 # Red
	else: 
		color=0 # Blue
		
	make_path()


func _physics_process(delta: float) -> void:
	if nav_agent.is_navigation_finished():
		speed = 0
	else:
		speed = 175
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	var intended_velocity = dir * speed
	car.rotation = dir.angle() + (PI/2.0)
	nav_agent.set_velocity(intended_velocity)
	
	move_and_slide()


func make_path() -> void:
	if parkingSpot != null:
		nav_agent.target_position = parkingSpot.global_position

func _on_timer_timeout() -> void:
	make_path()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()
