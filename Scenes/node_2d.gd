extends Node2D

var Rat_scene = preload("res://Scenes/rat.tscn")
var Gold_rat = preload("res://Scenes/gold_rat.tscn")

var rat_speed_multiplier = 1.0
var gold_spawned = false
var gold_unlocked = false

func _ready():
	for i in range(3):
		spawn_rat()
	MusicController.bgm_play()
		
func spawn_rat():
	var rat = Rat_scene.instantiate()
	
	add_child(rat)
	
	rat.speed = 200.0 * rat_speed_multiplier
	
	rat.global_position = Vector2(
		randi_range(100,700),
		randi_range(100,500)
	)
 
func gold_spawn():
	if gold_spawned:
		return
	
	gold_spawned = true
	
	rat_speed_multiplier *= 1.10
	var gold_rat = Gold_rat.instantiate()
	
	add_child(gold_rat)
	
	gold_rat.global_position = Vector2(
		randi_range(100,700),
		randi_range(100,500)
	)
	gold_rat.get_node("CharacterBody2D").rat_hole = $rat_hole
	
func _on_gold_rat_timer_timeout():
	print("TIMER:", gold_spawned)
	
	if get_tree().current_scene.gold_unlocked and not gold_spawned:
		gold_spawn()
