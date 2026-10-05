extends Control

@onready var canasta = $"../Canasta"
@onready var ContadorDib =  $HBoxContainer/Contador

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	ContadorDib.text = str(Global.current_score)
