extends CharacterBody2D



@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D

@onready var rat_hole: Node2D = $"."

var is_picked_up = false

var is_gold_rat = true

const SPEED = 200.0

func _physics_process(_delta: float) -> void:
	if is_picked_up:
		velocity = Vector2.ZERO
		return

	if rat_hole:
		var direction = global_position.direction_to(rat_hole.global_position)
		velocity = direction * SPEED

	move_and_slide()
