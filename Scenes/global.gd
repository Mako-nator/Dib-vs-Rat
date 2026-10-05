extends Node

var current_score = 0
var high_score = 0

func save_high_score():
	var config = ConfigFile.new()
	config.set_value("Save", "high_score", high_score)
	config.save("user://save.cfg")
	print("High score guardado: ", high_score)

func load_high_score():
	var config = ConfigFile.new()
	var err = config.load("user://save.cfg")
	if err == OK:
		high_score = config.get_value("Save", "high_score", 0) 

func _ready() -> void:
	load_high_score()
	print("High score cargado: ", high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
