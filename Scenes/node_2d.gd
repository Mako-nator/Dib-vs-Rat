extends Node2D

var Rat_scene = preload("res://Scenes/rat.tscn")
var Gold_rat = preload("res://Scenes/gold_rat.tscn")
var Angry_rat = preload("res://Scenes/angry_rat.tscn")

var rat_speed_multiplier = 1.0
var gold_spawned = false
var gold_unlocked = false
var angry_rat_spawned = false
var angry_unlocked = true

func _ready():
	Global.current_score = 0
	for i in range(3):
		spawn_rat()
	MusicController.bgm_play(preload("res://Audios/Dib vs rat soudtrack.ogg"))
		
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

func _on_angry_rat_spawned():
	angry_rat_spawned = true
	
	var angry_rat = Angry_rat.instantiate()
	add_child(angry_rat)
	
	angry_rat.global_position = Vector2(
		randi_range(100, 700),
		randi_range(100, 500)
	)
	
	angry_rat.dib = $Dib


func _on_angry_rat_timer_timeout():
	print("AngryRat:", angry_rat_spawned)
	
	if get_tree().current_scene.angry_unlocked and not angry_rat_spawned:
		_on_angry_rat_spawned()
