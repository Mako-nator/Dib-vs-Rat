extends ColorRect

@onready var ScoreLabel = $ScoreLabel
@onready var HighScoreLabel = $HighScoreLabel

func _ready() -> void:
	MusicController.bgm_play(preload("res://Audios/Game over.ogg"))
	
	if Global.current_score > Global.high_score:
		Global.high_score = Global.current_score
		Global.save_high_score()
		
	ScoreLabel.text = "Score: " + str(Global.current_score)
	HighScoreLabel.text = "High Score: " + str(Global.high_score)
	
	$Menuprincipal.pressed.connect(_on_menu_pressed)

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")
