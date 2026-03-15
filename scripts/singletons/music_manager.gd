extends Node

@export var audio_player: AudioStreamPlayer
@export var click_player: AudioStreamPlayer

func _on_audio_stream_player_finished() -> void:
	audio_player.play(21.883)

func _init() -> void:
	SignalBus.button_clicked.connect(play_click)
	
func play_click() -> void:
	click_player.play()
