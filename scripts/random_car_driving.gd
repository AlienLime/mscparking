class_name RandomCar
extends CharacterBody2D

#const car_scene: PackedScene = preload("res://scenes/random_car_driving.tscn")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var car: CharacterBody2D = $"."
@export var parkingSpot: ParkingSpot
@export var navigationTarget: Node2D

var color: int
var origin: int
var shape: int
var isParked = false
var isParkedCorrectly = false
var waiting = false
var reverse = false

var speed = 175
var ID = "ID"



func withData(possibleColor:= [0, 1], possibleOrigin:= [0], possibleShape:= 0) -> void:
	color = possibleColor.pick_random()
	origin = possibleOrigin.pick_random()
	shape = possibleShape

func _ready() -> void:
	sprite.frame = color * 7 + randi_range(0,6)


func _physics_process(delta: float) -> void:
	if parkingSpot != null:
		navigationTarget = parkingSpot
	if nav_agent.is_navigation_finished() || waiting:
		speed = 0
	elif reverse:
		speed = -50
	else:
		speed = 175
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	var intended_velocity = dir * speed
	car.rotation = dir.angle() + (PI/2.0)
	nav_agent.set_velocity(intended_velocity)
	
	move_and_slide()


func make_path() -> void:
	if navigationTarget != null:
		nav_agent.target_position = navigationTarget.global_position

func _on_timer_timeout() -> void:
	make_path()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.nav_agent.is_navigation_finished(): # to avoid stopping for parked cars in neighbouring spots to the target
		if body.nav_agent.distance_to_target() < nav_agent.distance_to_target():
			waiting = true
			while body.waiting:
				if body.nav_agent.is_navigation_finished():
					break
			await wait(0.75)
			waiting = false
		elif body.get_index() < car.get_index():
			waiting = true
			await wait(1)
			waiting = false

#func _on_area_2d_body_exited(body: Node2D) -> void:
	#waiting = false


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
