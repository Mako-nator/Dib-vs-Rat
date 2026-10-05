extends Node2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func bgm_play(cancion: AudioStream) -> void:
	audio_stream_player.stream = cancion
	audio_stream_player.play()

func bgm_stop():
	audio_stream_player.stop()
