class_name pickups

extends Area2D

func _ready() -> void:
	global.buffUsed.connect(disable)


func _process(delta: float) -> void:
	pass

func _on_body_entered(body: CharacterBody2D) -> void:
	global.pickup_entered.emit()


func _on_body_exited(body: Node2D) -> void:
	global.pickup_exited.emit()

func disable():   # SEHR scheise gemacht
	visible = false
	monitorable = false
	monitoring = false
