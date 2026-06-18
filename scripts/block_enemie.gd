class_name Collisions
extends StaticBody2D

var HitEffectLenght :float = 0.1 ## wie lange der 2te Sprire sichtbar ist
var speed = 1 # ungenutzt
var velocity : Vector2
var HealthPoints : int
@export var max_hp : int = 3
var dead = false

var bullet_scene = preload("res://scenes/enemy_bullet_1.tscn")
@export var cooldown:float = 1.5  # unnotig lowk
var Ifcooldown = true

func _ready() -> void:
	HealthPoints = max_hp
	global.connect("bullet_hit", hitEffect) 

func _process(delta: float) -> void:  
	$hp_placehold.text = str(HealthPoints) +"/" + str(max_hp)
	$HitSprite.position =  position
	if Ifcooldown == true:
		if dead == false:
			shoot()
			Ifcooldown = false
			$AttackTimer.start(cooldown)
		#var direction :Vector2 = position + global.player_position  # geht net, wollte player kopiern
		#position = direction * speed

func shoot():  ## funktionier genaus wie beim player nur mit der position des players statt der maus
	$ShootSound.play()
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.position = position
	bullet.bullet_direction  = (position - global.player_position).normalized()
	
func hitEffect():  ## aktiviert den 2ten sprite und den timer (sehr uneffektiv)
	$HurtSound.play()
	$HitSprite.visible = true
	$SpriteTimer.start(HitEffectLenght)
	HealthPoints -= 1
	if HealthPoints <= 0:
		died()

func _on_sprite_timer_timeout() -> void: ## wenn dann der Timer abgelaufen, ist der 2te Sprite unsichtbar
	$HitSprite.visible = false

func _on_attack_timer_timeout() -> void:
	Ifcooldown = true
func _on_dead_timer_timeout() -> void: ## damit der gegner nicht sofot stirb, zeit fur den deathsound und death animation
	visible = false
	$DedSound.volume_db = -80       # MUSS geandert werden mit instanzen und spawnen

func died(): # braucht REWORK durch instanzen
	collision_layer = 2
	$DedSound.play()
	dead = true
	$Hitbox.disabled = true
	rotation = 80
	$DeadTimer.start(0.5)
	
	global.room_completed.emit()    #das bleib tho 
