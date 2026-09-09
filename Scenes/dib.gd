extends CharacterBody2D

@onready var object_marker: Marker2D = $Sprite2D/ObjectMarker

@onready var sfx_miaw = $sfx_miaw

@onready var heart1: TextureRect =  $"../Header/Lives/heart 1"
@onready var heart2: TextureRect =  $"../Header/Lives/heart 2"
@onready var heart3: TextureRect =  $"../Header/Lives/heart 3"

var lives = 3

const SPEED = 300.0
var possiblePickupObjects = []
var currentObject



func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_pickup") and currentObject: 
		throw_object()
	elif Input.is_action_just_pressed("ui_pickup") and possiblePickupObjects:
		pickup_object()
		 

	
func throw_object():
	if "is_gold_rat" in currentObject and currentObject.is_gold_rat:
		currentObject.reparent(get_tree().current_scene)
		currentObject.is_picked_up = false
		currentObject.get_node("CollisionShape2D").disabled = false
		currentObject.global_position = global_position
		currentObject = null
		
		perder_vida()
		
		return

	currentObject.reparent(get_tree().current_scene)
	
	var throwDirection = global_position.direction_to(object_marker.global_position)
	currentObject.throw(throwDirection)
	
	currentObject = null
	
	
func pickup_object():
	currentObject = possiblePickupObjects.pop_front()
	sfx_miaw.play()
	
	currentObject.global_position = object_marker.global_position
	currentObject.reparent(object_marker)
	
	if "is_gold_rat" in currentObject and currentObject.is_gold_rat:
		currentObject.is_picked_up = true
		currentObject.get_node("CollisionShape2D").disabled = true
		print("¡DIB ATRAPÓ LA GOLD RAT!")
		sfx_miaw.play()
		return

	
	currentObject.picked_up()
	


func has_object():
	return currentObject != null

	
func remove_object():
	if currentObject:
		currentObject.queue_free()
		currentObject = null

	
func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)
	velocity = direction  * SPEED
	move_and_slide()
	
func perder_vida():
	lives -= 1
	print("Vidas:", lives)
	if lives == 2:
		heart3.texture = preload("res://Sprites/Heartless.png")
	elif lives == 1:
		heart2.texture = preload("res://Sprites/Heartless.png")
	elif lives == 0:
		heart1.texture = preload("res://Sprites/Heartless.png")
		get_tree().call_deferred("change_scene_to_file","res://Scenes/game_over.tscn")


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is GameObject or ("is_gold_rat" in body and body.is_gold_rat):
		possiblePickupObjects.append(body)

func _on_pickup_area_body_exited(body: Node2D) -> void:
	if body is GameObject or ("is_gold_rat" in body and body.is_gold_rat):
		possiblePickupObjects.erase(body)
