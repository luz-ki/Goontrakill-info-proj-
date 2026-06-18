extends Area2D


func _ready():
	pass

func _process(delta: float):
	pass


func _on_body_entered(body: CharacterBody2D):
	global.portalTouching = true
	$portalInRange.visible = true
func _on_body_exited(body: CharacterBody2D):
	global.portalTouching = false
	$portalInRange.visible = false
