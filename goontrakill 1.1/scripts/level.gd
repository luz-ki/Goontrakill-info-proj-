extends Node2D

@export var music = false


func _ready() -> void:
	if music :
		$Music.playing = true  ## spielt die musik ab

func _process(delta: float) -> void:
	pass
