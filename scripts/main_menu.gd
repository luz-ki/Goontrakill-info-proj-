extends Node3D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void: ##verandert die szene, wenn man enter druckt
	if event.is_action_pressed("enter"):
		get_tree().change_scene_to_file("res://scenes/level.tscn")
