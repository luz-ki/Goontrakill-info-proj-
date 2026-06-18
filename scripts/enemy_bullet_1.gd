extends Area2D

@export var bullet_speed = 1200
var bullet_direction: Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position -= bullet_direction * bullet_speed * delta 


func _on_body_entered(body: CharacterBody2D):
	visible = false
	global.player_hurt.emit()
