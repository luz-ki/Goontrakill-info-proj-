extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global.player_died.connect(pause)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pause():
	get_tree().paused = true

func _input(event: InputEvent):
	if event.is_action_pressed("restart"):
		get_tree().paused = false
