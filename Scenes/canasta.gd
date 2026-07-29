extends Node2D

@onready var PlayerDib: CharacterBody2D =  $"../Dib"
@onready var sfx_prrs = $Prrs

var score = 0

func _ready() -> void:
	pass 
	
func _process(delta: float) -> void:
	pass
	
func _on_area_2d_body_entered(body):
	if body == PlayerDib:
		if PlayerDib.currentObject != null:
			sfx_prrs.play()
			PlayerDib.currentObject.queue_free()
			get_tree().current_scene.call_deferred("spawn_rat")

		if body.has_object():
			body.remove_object()
			score += 100
			print(score)
