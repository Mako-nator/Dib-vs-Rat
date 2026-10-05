extends Node2D

@onready var PlayerDib: CharacterBody2D =  $"../Dib"
@onready var sfx_prrs = $Prrs

var gold_spawned = false

func _ready() -> void:
	pass 
	
func _process(_delta: float) -> void:
	pass
	
func _on_area_2d_body_entered(body):
	if body == PlayerDib:
		if PlayerDib.currentObject != null:
			sfx_prrs.play()
			
			if "is_gold_rat" in PlayerDib.currentObject and PlayerDib.currentObject.is_gold_rat:
				PlayerDib.currentObject.queue_free()
				PlayerDib.currentObject = null
	
				Global.current_score += 300
				get_tree().current_scene.gold_spawned = false
	
				print(Global.current_score)
				return
			
			PlayerDib.currentObject.queue_free()
			PlayerDib.currentObject = null
			get_tree().current_scene.call_deferred("spawn_rat")

			Global.current_score += 100
			print(Global.current_score)
			
			if Global.current_score >= 700 and not get_tree().current_scene.gold_unlocked:
				get_tree().current_scene.gold_unlocked = true
