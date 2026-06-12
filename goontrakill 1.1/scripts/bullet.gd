extends Node2D

@export var bullet_speed = 400
var bullet_direction: Vector2

func _ready():
	pass

func _process(delta: float): ## updatet die Position jede Frame (bewegung)
	position -= bullet_direction * bullet_speed * delta

func _on_body_entered(body: Node2D):  ## schaut, ob es eine Hitbox des Gegners getroffen hat
	if body is Collisions:
		visible = false
		global.bullet_hit.emit()  ## sendet signal aus, worauf andere nodes zugreifen konnen
		$BulletSound.play()
