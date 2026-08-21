extends CharacterBody2D
class_name GameObject

@export var throwForce = Vector2(100, -300)

@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D

var is_gold_rat = false
var speed = 200.0

var direction = 1
var health = 1

func move_enemy():
	velocity.x = speed * direction
	

func reverse_direction():
	if is_on_wall():
		direction = -direction
		
func picked_up():
	collision_shape2d.disabled = true 
	
	set_physics_process(false)

func throw(direction):
	set_physics_process(true)
	velocity = throwForce
	velocity.x *= direction.x 
	
	await get_tree().create_timer(0.1).timeout
	collision_shape2d.disabled = false 
	
	
func _physics_process(_delta: float) -> void:
	move_enemy()
	move_and_slide()
	reverse_direction()
