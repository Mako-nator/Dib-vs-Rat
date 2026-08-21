extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	bgm_play()

func bgm_play():
	audio_stream_player.stream = preload("res://Audios/Dib vs rat soudtrack.ogg")
	audio_stream_player.play()
