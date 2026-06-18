class_name pickups

extends Area2D

var BuffStrength = 0.25

func _ready() -> void:
	pass


func _process(delta: float) -> void :
	pass

func _on_body_entered(body: CharacterBody2D) -> void:
	if global.areaTouching == true:
		global.attack_cooldown -= global.attack_cooldown*BuffStrength
		print(global.attack_cooldown)
		disable()

func disable():  ## macht alle funktionen weg  #geht vielleicht besser mit instanzen
	visible = false
	monitorable = false
	monitoring = false
