extends Node2D

var Rat_scene = preload("res://Scenes/rat.tscn")

func _ready():
	for i in range(3):
		spawn_rat()
		
func spawn_rat():
	var rat = Rat_scene.instantiate()
	
	add_child(rat)
	
	rat.global_position = Vector2(
		randi_range(100,700),
		randi_range(100,500)
	)
