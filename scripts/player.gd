
## Dies ist mein Code, ich habe KEINERLEI KI benutzt

# bro look at this shit, its amzing https://www.reddit.com/r/godot/comments/18k1ydx/question_how_to_make_a_character_sprite_rotate/
extends CharacterBody2D

@export var speed = 400
@export var buffStr = 0.25   # UNBEDINGT in CD_Buff reinmachen # oder minus statt mal?
@onready var isPaused = false

var attack_timer: bool = true

@onready var player: CharacterBody2D = $"."
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var timer: Timer = $Timer
@onready var hpText: RichTextLabel = $"Hp (placeholder"

var cooldown = global.attack_cooldown 
var max_hp = global.player_max_health
var hp = global.player_health

@onready var gunHolePosition = $gun/gunHole.position # unnotig und scheise

func _ready() :
	$Camera2D/UserInterface/Hp_placeholder.text = str(hp) +"/" + str(max_hp)
	$Camera2D/UserInterface/GameOver.visible = false
	$Camera2D/UserInterface/YouWin.visible = false
	cooldown = global.attack_cooldown ## updated cooldown auf globale variable
	global.player_hurt.connect(hurt)
	
func _physics_process(delta: float): ## eingebaute funktion, wird jede frame gecallt
	global.player_position = position
	cooldown = global.attack_cooldown
	if global.portalTouching == true:
		$Camera2D/UserInterface/tipE.visible= true
	elif global.portalTouching == false:
		$Camera2D/UserInterface/tipE.visible= false
	#$gun/gunHole.position = $gun/gunSprite.position  # keine ahnung warum es nicht funktoniert
	#gunHolePosition = $gun/gunHole.position
	
	$gun.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("input 1"):  ##shoot
		if attack_timer == true:
			shoot()
			attack_timer = false
			timer.start(cooldown)
	var direction = Input.get_vector("left","right","up","down") ## Bewegung des Spielercharkters in 8 richtungen
	velocity = direction * speed
	move_and_slide()

func shoot():           ## macht eine neue instanz der node Bullet und gleicht die richtung an, damit es in richtung cursor fliegt
	var bullet = bullet_scene.instantiate() 
	bullet.position = position # es mit gunhole zu machen hat nicht geklappt
	$ShootSound.play() 
	bullet.bullet_direction  = (position - get_global_mouse_position()).normalized()
	get_parent().add_child(bullet)

func _input(event: InputEvent) :  ## handelt die eingabe (muss man erst in einstellungen vordefiniern)
	if event.is_action_pressed("interact"):
		if global.portalTouching == true:
			won()
		global.areaTouching = true
		#print(global.areaTouching)

func _on_timer_timeout() : ## meine komische losung, um einen cooldown zu machen
	attack_timer = true

func hurt():  ## wenn der spierle getroffen wird
	$Camera2D/UserInterface/Hp_placeholder.text = str(hp-1) +"/" + str(max_hp)  #keine ahnung warum ich das -1 brauche
	print($Camera2D/UserInterface/Hp_placeholder.text)
	print(max_hp)
	$HurtSound.play()
	hp -= 1
	print(hp)
	if hp <= 0:
		$Camera2D/UserInterface/GameOver.position = position
		global.player_died.emit()
		$Camera2D/UserInterface/GameOver.visible = true

func _on_gamewin_timer_timeout() -> void:
	isPaused = true
	global.room_cleared.emit()

func won():
		global.portalTouching = false
		$Camera2D/UserInterface/tipE.visible= false
		$Camera2D/UserInterface/YouWin/uwintext.position = position   + Vector2(-900,-100)
		$Camera2D/UserInterface/YouWin.position = position 
		$Camera2D/UserInterface/YouWin.visible = true
		$AudioListener2D.play()
		$AudioListener2D/gamewinTimer.start(5)
