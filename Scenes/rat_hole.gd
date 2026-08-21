extends Node2D

@onready var Goldrat: Node2D = $"."


func _on_area_2d_body_entered(body: Node2D) -> void:
	if "is_gold_rat" in body and body.is_gold_rat:
		print("LA DORADA SE ESCAPÓ")
		body.queue_free()
		get_tree().current_scene.gold_spawned = false
