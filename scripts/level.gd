extends Node2D

@export var music = false
var enemy1_scene = preload("res://scenes/block_enemie.tscn")
#var portal_scene = preload("res://scenes/portal.tscn") # nicht wirklich effektiv, mal schuaen
var time_sec = global.time_sec
var time_min = global.time_min
var time_h = global.time_h
@onready var portal = $Portal
# ta pierdolona scheiss variable will nicht funktioneren und ich weiss nicht warum
var time := str("%0.f" % global.time_h + "."+"%0.f" %global.time_min +"."+ "%1.f" %global.time_sec)

func _ready() -> void:
	global.room_completed.connect(spawn_portal)
	$timeTimer.start(0.1)
	
		#spawn(enemy1_scene,(0.0, 0.0) )
		#var enemyBlock = enemy1_scene.instantiate()  # klappt nicht, wollte bullet kopieren
		#enemyBlock.position = position
		#get_parent().add_child(enemyBlock)
		#global.room_cleared.connect(pause)
	if music :
		$Music.playing = true  ## spielt die musik ab

func _process(_delta: float):
	#$player/Gun.position = $player.position
	minute()
	global.time_min = time_min
	#print(global.time_sec)
	#print(time)   # time geht net idk y   >:[ 

func spawn_portal():  
	$timeTimer.one_shot = true
	portal.monitorable = true
	portal.monitoring = true
	portal.visible =true
	portal.position = Vector2(0,-300)
	
func _input(event: InputEvent):  
	if event.is_action_pressed("restart"):  
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		#get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_time_timer_timeout(): ## in afrika vergeht jede 0.1 sekunde ein zehntel einer sekunde :
	global.time_sec += 0.1

func minute():
	if global.time_sec >= 60:
		time_min += 1
		#print(global.time_min)
		global.time_sec = 0.0
