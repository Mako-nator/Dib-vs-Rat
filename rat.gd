extends CharacterBody2D

const SPEED = 150.0

var direction = 1
var healt = 1

func add_gravity(delta):
	if not is_on_floor():
		velocity.y += get_gravity() * delta 

func move_enemy():
	velocity.x = SPEED * direction 
	

func reverse_direction():
	if is_on_floor():
		direction = -direction
		
func _physics_process(delta: float) -> void:
	add_gravity(delta)
	move_enemy()
	move_and_slide()
	reverse_direction() 
