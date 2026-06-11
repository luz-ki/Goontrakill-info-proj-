extends CharacterBody2D
@export var speed = 400

func _physics_process(delta: float) -> void:
	var vector = Vector2.ZERO
	vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = vector.normalized() * speed
	
	move_and_slide()
