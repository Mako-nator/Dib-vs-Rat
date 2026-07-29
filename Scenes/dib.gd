extends CharacterBody2D

@onready var object_marker: Marker2D = $Sprite2D/ObjectMarker
@onready var sfx_miaw = $sfx_miaw


const SPEED = 300.0

var possiblePickupObjects = []
var currentObject


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_pickup") and currentObject: 
		throw_object()
	elif Input.is_action_just_pressed("ui_pickup") and possiblePickupObjects:
		pickup_object()
	
func throw_object():
	currentObject.reparent(get_tree().current_scene)
	
	var throwDirection = global_position.direction_to(object_marker.global_position)
	currentObject.throw(throwDirection)
	
	currentObject = null 
	
func pickup_object():
	currentObject = possiblePickupObjects.pop_front()
	sfx_miaw.play()
	
	currentObject.global_position = object_marker.global_position
	currentObject.reparent(object_marker)
	
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
	
	


func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body is GameObject:
		possiblePickupObjects.append(body)


func _on_pickup_area_body_exited(body: Node2D) -> void:
	if body is GameObject:
		possiblePickupObjects.erase(body)
