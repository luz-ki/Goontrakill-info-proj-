
## Dies ist mein Code, ich habe KEINERLEI KI benutzt

extends CharacterBody2D
@export var speed = 400
@export var buffStr = 0.25   # UNBEDINGT in CD_Buff reinmachen # oder minus statt mal?

var attack_timer: bool = true

var IfpickupPoss :bool= false

@onready var player: CharacterBody2D = $"."
@onready var bullet_scene = preload("res://scenes/bullet.tscn")
@onready var timer: Timer = $Timer

var cooldown = global.attack_cooldown 
var hp = global.player_health
var ammo = global.player_ammo

func _ready() :
	cooldown = global.attack_cooldown ## updated cooldown auf globale variable
	global.pickup_entered.connect(ChangeEnterTrue)
	global.pickup_exited.connect(ChangeEnterFalse)
func _physics_process(delta: float):  ## wird jede frame gecallt
	if Input.is_action_pressed("input 1"):
		if attack_timer == true:
			shoot()
			attack_timer = false
			timer.start(cooldown)
		
	var direction = Input.get_vector("left","right","up","down") ## Bewegung des Spielercharkters in 8 richtungen
	velocity = direction * speed
	move_and_slide()

func shoot():           ## macht eine neue instanz der node Bullet und gleicht die richtung an,
	var bullet = bullet_scene.instantiate()  ## damit es in richtung cursor fliegt
	bullet.position = position               ## (die bewegung selbst ist in bullet script drin)
	bullet.bullet_direction  = (position - get_global_mouse_position()).normalized()
	get_parent().add_child(bullet)
	#ammo -= 1

func _input(event: InputEvent) :  ## handelt die eingabe (muss man erst in einstellungen vordefiniern)
	if event.is_action_pressed("interact"):
		if IfpickupPoss == true:
			print(cooldown)
			cooldown = cooldown - (cooldown*0.25)  # die berechnung macht dezimalstellen weg, ale dziala
			print(cooldown)
			pickup()

func _on_timer_timeout() -> void:
	attack_timer = true

func ChangeEnterTrue():      ## verandert die bool var, die bestimmt, ob man einen pickup aufnehmen kann
	IfpickupPoss = true
func ChangeEnterFalse():     ## genauso wie die obere, blos umgekehrt
	IfpickupPoss = false

func pickup(): # trzeba tutaj polaczyc sygnal albo coś
	global.buffUsed.emit()
