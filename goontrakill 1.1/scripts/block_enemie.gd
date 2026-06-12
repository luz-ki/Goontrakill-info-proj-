class_name Collisions
extends StaticBody2D

var HitEffectLenght :float = 0.1 ## wie lange der 2te Sprire sichtbar ist

func _ready() -> void:
	global.connect("bullet_hit", hitEffect) 

func _process(delta: float) -> void:
	pass

func hitEffect():  ## aktiviert den 2ten sprite und den timer (sehr uneffektiv)
	$HitSprite.visible = true
	$SpriteTimer.start(HitEffectLenght)	
func _on_sprite_timer_timeout() -> void: ## wenn dann der Timer abgelaufen, ist der 2te Sprite unsichtbar
	$HitSprite.visible = false
