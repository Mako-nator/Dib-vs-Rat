extends CharacterBody2D

@onready var collision_shape2D: CollisionShape2D = $CollisionShape2D
@onready var dib: CharacterBody2D = $"."

const SPEED = 200.0

var time_left = 5.0

func _ready(): 
	dib = get_tree().current_scene.get_node("Dib")
	print("Dib ha sido encontrao:")
	
func _physics_process(delta: float) -> void:
	if dib:
		var direction  = global_position.direction_to(dib.global_position)
		velocity = direction  * SPEED
		move_and_slide ()
	
		if get_slide_collision_count() > 0:
			var collision = get_slide_collision(0)

			if collision.get_collider() == dib:
				dib.perder_vida()
				get_tree().current_scene.angry_rat_spawned = false
				queue_free()

		
	
	time_left -= delta
	
	if time_left <= 0:
		get_tree().current_scene.angry_rat_spawned = false
		queue_free()
