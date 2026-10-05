extends Node2D

const escena_juego: = "res://Scenes/node_2d.tscn"


func _ready() -> void:
	MusicController.bgm_play(preload("res://Audios/Menu soudtrack.ogg"))
	
	$VBoxContainer/play.pressed.connect(_on_play_pressed) 
	$VBoxContainer/Exit.pressed.connect(_on_exit_pressed)
	$VBoxContainer/Settings.pressed.connect(_on_settings_pressed)
	
	$Panel.hide()
	$Panel/VBoxContainer/Close.pressed.connect(_on_close_pressed)
	$Panel/VBoxContainer/SliderVolumen.value_changed.connect(_on_volumen_changed)
	$Panel/VBoxContainer/CheckFullscreen.toggled.connect(_on_fullscreen_toggled)

	var bus_index := AudioServer.get_bus_index("Master")
	$Panel/VBoxContainer/SliderVolumen.value = AudioServer.get_bus_volume_db(bus_index)

	
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(escena_juego)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	$Panel.show()

func _on_close_pressed() -> void:
	$Panel.hide()

func _on_volumen_changed(valor: float) -> void:
	var bus_index := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, valor)

func _on_fullscreen_toggled(activado: bool) -> void:
	if activado:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
